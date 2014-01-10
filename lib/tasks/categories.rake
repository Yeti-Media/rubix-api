namespace :categories do
  desc "Seed categories"
  task seed: :environment do
    Category.delete_all
    Settings.patterns.categories.each do |c|
      Category.create title: c
    end
  end
end
