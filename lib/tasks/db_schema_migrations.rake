namespace :db do
  
  desc "Prints the migrated versions"
  task :schema_migration => :environment do
    puts ActiveRecord::Base.connection.select_rows(
      'select title, description from commodities')
  end
end