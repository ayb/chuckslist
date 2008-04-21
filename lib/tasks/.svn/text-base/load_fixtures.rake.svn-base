#Rake task to populate the default data into the **current environment's database**.
#It can import data from .yml files. The files should be present under "test/fixtures/app_default_data/import" folder.
#Load specific tables using the environment variable "TABLE". Eg:
#=> rake db:fixtures:import TABLE=assessment_components,lookups (Note: There should not be spaces between commas)
#Specific environment using the environment variable "RAILS_ENV"
#=> rake db:fixtures:import TABLE=assessment_components,lookups RAILS_ENV=test
# 
# source: http://www.michaelhill.info/blog/?p=16 (Thanks!)
desc "Sets default categories and parent categories for ChucksList using fixtures provided."
namespace :db  do
  namespace :fixtures do
      task :import => :environment do
	
        require 'active_record/fixtures'
        require 'rake'
        ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
        ## set directory to import
        file_base_path = File.join(RAILS_ROOT, 'test', 'fixtures', 'app_default_data', 'import') 
        puts "importing from: " + file_base_path
	
        puts "the RAILS_ENV is " + RAILS_ENV
	
        if ENV["TABLE"] != nil
            files_array = ENV["TABLE"].to_s.split(",")
        else
            files_array = Dir.glob(File.join(file_base_path, '*.{yml}'))
        end
	
        files_array.each do |fixture_file|
            puts "\n Importing " + File.basename(fixture_file.strip, ".yml") + "..."
            begin
                  if fixture_file.downcase != 'schema_info'
                    Fixtures.create_fixtures(file_base_path, File.basename(fixture_file.strip, '.yml'))
                  else
                    raise   "Not willing to import schema_info!"
                  end
                puts    " Status: Completed"
            rescue
                puts    " Status: Aborted\n\n" + $!
            end
        end
        puts "\nTask completed!"
	
      end
    end
end
