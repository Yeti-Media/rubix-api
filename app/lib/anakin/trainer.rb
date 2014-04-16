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
      Rails.logger.info(command)
      shell = Mixlib::ShellOut.new(command)
      shell.run_command
      Rails.logger.info "COMMAND"
      Rails.logger.info command 
      Rails.logger.info "OUTPUT ERR"
      Rails.logger.info shell.stderr
      Rails.logger.info "OUTPUT STD"
      Rails.logger.info shell.stdout
      filename
    end

    def save(filename)
      lb = Anakin::FeatureMatcher.new
      if_file = "#{Rails.root}/tmp/#{filename}.if"
      xml_file = "#{Rails.root}/tmp/#{filename}.xml"
      trainer = user.trainers.new
      unless new_trainer = (user.trainers.count == 0)
        trainer = user.trainers.first
      end
      trainer.attributes = {if_file: File.open(if_file), xml_file: File.open(xml_file)}
      if trainer.save
        user.patterns.order('patterns.id asc').each_with_index do |pattern, index|
          raw_parameters = {position: index, trainer_id: trainer.id}
          params = ActionController::Parameters.new(raw_parameters)
          pattern.update_attributes(params.permit(:position, :trainer_id))
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