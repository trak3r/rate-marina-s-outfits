require 'rake'

namespace :db do
  desc 'Compress the dumped database'
  task :compress => :environment do
    system("gzip --force -9 #{dump_full_path}")
  end

  desc 'Mail the compressed database'
  task :mail => :environment do
    system("uuencode #{dump_full_path}.gz #{dump_file_name}.gz | mail -s 'Marina Database Backup' marina@anachromystic.com")
  end

  desc 'Backup the database (dump, compress, and mail)'
  task :backup => :environment do
    Rake::Task['db:data:dump'].invoke
    Rake::Task['db:compress'].invoke
    Rake::Task['db:mail'].invoke
  end

  namespace :data do
    desc "Dump the current database to a MySQL file"
    task :dump do
      db_config = load_db_for 'production'
      pw = db_config['password'].eql?('') || db_config['password'].nil? ? '' : '-p'+ db_config['password']
      file = ENV['BACKUP_FILE'] || dump_file_path
      system "mysqldump -u #{db_config['username']} #{pw} -Q --disable-keys --add-drop-table -O add-locks=FALSE -O lock-tables=FALSE --ignore-table=#{db_config['database']}.sessions -h #{db_config['host']} #{db_config['database']} > #{file}"
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