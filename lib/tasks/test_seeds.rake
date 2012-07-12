namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
      load File.join(RAILS_ROOT, 'db', 'test_seeds.rb')
    end
  end
end
