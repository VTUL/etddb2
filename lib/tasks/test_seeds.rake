namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
      load File.join(Rails.root, 'db', 'test_seeds.rb')
    end
  end
end
