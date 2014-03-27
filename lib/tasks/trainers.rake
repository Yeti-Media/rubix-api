namespace :trainers do
  desc "update trainers"
  task update: :environment do
    User.all.each do |user|
      if trainer = user.trainers.last
        do_train = user.patterns.where("patterns.created_at > ?" , trainer.updated_at).count
      else
        do_train = 1
      end 
      if do_train > 0 
        trainer = Anakin::Trainer.new(user)
        trailer.delay.train!
      end
    end
  end
end