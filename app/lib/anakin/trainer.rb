module Anakin
  class Trainer

    attr_accessor :user

    def initialize(user)
      self.user = user
    end

    def train!
      save(train)
    end

    private

    def train
      trainer_command = File.join(Rails.root, 'bin', 'trainer')
      filename = SecureRandom.base64(25).tr('+/=lIO0', 'pqrsxyz')
      command = "#{trainer_command} -user #{self.user.id} -saveToFile #{Rails.root}/tmp/ #{filename}"
      Rails.logger.info("===== Trainer Starts =====")
      shell = Mixlib::ShellOut.new(command)
      Rails.logger.info(command)
      shell.run_command
      Rails.logger.info(shell.stdout)
      Rails.logger.info(shell.stderr)
      filename
    end

    def save(filename)
      lb = Anakin::FeatureMatcher.new
      if_file = "#{Rails.root}/tmp/#{filename}.if"
      xml_file = "#{Rails.root}/tmp/#{filename}.xml"
      trainer = user.trainers.new
      unless new_trainer = (user.trainers.count > 0)
        trainer = user.trainers.first
      end
      trainer.attributes = {if_file: File.open(if_file), xml_file: File.open(xml_file)}
      if trainer.save
        if new_trainer
          lb.add_indexes({user_id: user.id, indexes: [trainer.id]})
        else
          lb.update_index({index_id: trainer.id})
        end
        true
      else
        false
      end
    end
  end
end