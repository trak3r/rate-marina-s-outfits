require 'rake'

namespace :db do
  desc 'Compress the dumped database'
  task :compress => :environment do
    exec("gzip --force #{dump_full_path}")
  end

  desc 'Mail the compressed database'
  task :mail => :environment do
    exec("uuencode #{dump_full_path}.gz #{dump_file_name}.gz | mail -s 'Marina Database Backup' marina@anachromystic.com")
  end

  desc 'Backup the database (dump, compress, and mail)'
  task :backup => :environment do
    Rake::Task['db:database_dump'].invoke
    Rake::Task['db:compress'].invoke
    Rake::Task['db:mail'].invoke
  end
  
  desc "Dump the current database to a MySQL file" 
  task :database_dump do
    load 'config/environment.rb'
    abcs = ActiveRecord::Base.configurations
    case abcs[RAILS_ENV]["adapter"]
    when 'mysql'
      ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
      File.open(dump_full_path, "w+") do |f|
        if abcs[RAILS_ENV]["password"].blank?
          f << `mysqldump -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} #{abcs[RAILS_ENV]["database"]}`
        else
          f << `mysqldump -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} -p#{abcs[RAILS_ENV]["password"]} #{abcs[RAILS_ENV]["database"]}`
        end
      end
    when 'sqlite3'
      ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
      File.open("db/#{RAILS_ENV}_data.sql", "w+") do |f|
        f << `sqlite3  #{abcs[RAILS_ENV]["database"]} .dump`
      end
    else
      raise "Task not supported by '#{abcs[RAILS_ENV]['adapter']}'" 
    end
  end

  private

  def dump_file_name
    "#{RAILS_ENV}_data.sql"
  end

  def dump_full_path
    "db/#{dump_file_name}"
  end
end