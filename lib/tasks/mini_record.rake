namespace :db do
  desc "Use model properties to auto-migrate"
  task :automigrate => :environment do
    Dir[File.expand_path 'app/models/**.rb', Rails.root].each do |model|
      require model
      klass = File.basename(model.sub(/\.rb$/,'')).classify.constantize
      puts "== Migrating #{klass.name}"
      klass.auto_upgrade!
    end
  end
end
