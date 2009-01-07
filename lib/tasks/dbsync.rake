require 'yaml'
require 'erb'

namespace :db do
  desc "Ensure we're not doing anything stupid or dangerous in the production environment"
  task :sanity => :environment do
    raise "That's not safe for #{RAILS_ENV}" if 'production' == RAILS_ENV
  end

  namespace :sync do
    desc "Sync the database from the local copy (from the last remote sync)"
    task :local => ['db:sanity', 'db:drop', 'db:create'] do
      db_config = YAML::load(ERB.new(IO.read('config/database.yml')).result)['development']
      pw = db_config['password'].eql?('') || db_config['password'].nil? ? '' : '-p'+ db_config['password']
      system "gunzip -c ./db/production_data.sql.gz | mysql -u #{db_config['username']} #{pw} #{db_config['database']}"
    end
  end
end
