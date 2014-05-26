module Anakin
  class Trainer

    attr_accessor :user, :error

    def initialize(user)
      self.user = user
    end

    def train!
      begin
        patterns = self.user.patterns.to_be_trained
        while !patterns.empty?
          trainer = get_trainer
          Rails.logger.info("TRAINER")
          Rails.logger.info(trainer.inspect)
          selected_patterns = select_patterns(trainer, patterns)
          Rails.logger.info("SELECTED PATTERNS")
          Rails.logger.info(selected_patterns.inspect)
          filename = SecureRandom.base64(25).tr('+/=lIO0', 'pqrsxyz')
          train(trainer, selected_patterns, filename)
          save(filename, trainer, selected_patterns)
        end
        return true
      rescue Errno::ENOENT => e
        Rollbar.report_exception(e, {user_id: self.user.id, error: self.error})
        return false
      end
    end

    private

    def get_trainer
      self.user.trainers.availables.first || self.user.trainers.new
    end
 
    def select_patterns(trainer, patterns)
      amount = Settings.patterns.limit - trainer.patterns.count
      amount = 0 if amount < 0
      patterns.shift(amount)
    end

    def train(trainer, patterns, filename)
      pattern_ids = trainer.patterns.order("patterns.id asc").ids + patterns.map(&:id)
      trainer_command = File.join(Rails.root, 'bin', 'trainer')
      command = "#{trainer_command} -user #{self.user.id} -saveToFile #{Rails.root}/tmp/ #{filename}"
      #command = "#{trainer_command} -patternsId #{pattern_ids.join(' ')} -saveToFile #{Rails.root}/tmp/ #{filename}"
      shell = Mixlib::ShellOut.new(command, {timeout: 1200})
      shell.run_command
      self.error = shell.stderr
      Rails.logger.info("TRAINER_ERROR: " + shell.stderr)
    end

    def save(filename, trainer, patterns)
      lb = Anakin::FeatureMatcher.new
      if_file = "#{Rails.root}/tmp/#{filename}.if"
      xml_file = "#{Rails.root}/tmp/#{filename}.xml"
      new_trainer = trainer.new_record?
      trainer.attributes = {if_file: File.open(if_file), xml_file: File.open(xml_file)}
      if trainer.save
        patterns.each do |p| 
          p.attributes =  {trainer_id: trainer.id}
          p.save
        end
        trainer.patterns.order('patterns.id asc').each_with_index do |pattern, index|
          pattern.update_column :position, index
        end
        Rails.logger.info "SAVED"
        if new_trainer
          lb.add_indexes({user_id: user.id, indexes: [trainer.id], category: 'matching'})
        else
          lb.update_indexes({indexes: [trainer.id]})
        end
        true
      else
        Rails.logger.info "NOT SAVED"
        false
      end
    end
  end
  end