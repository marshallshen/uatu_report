require "sequel"

module UatuReport
  def database
    config = {
      username: 'postgres',
      password: 'postgres',
      host: 'localhost',
      port: '5432',
      schema: 'local_third_party_feed',
      db: 'postgres'
    }

    @database ||= Sequel.connect("#{config[:db]}://#{config[:username]}:#{config[:password]}@#{config[:host]}:#{config[:port]}/#{config[:schema]}")
  end

  def run
    config

    results = {}

    if @mode == :count
      @collections.product(@timestamps).each do |collection, timestamp|
        count = database[collection].where("#{timestamp} <= (now() - interval '1 day')").count
        results[collection] = count
      end
    elsif @mode == :inspect
      # Have expectations for DB but actuallly the state of the database is not meeting requirements
      # Due date: July 5th, 2015
      raise "To be implemented"
    else
      raise "To be implemented"
    end

    results
  end

  def collections(*args)
    @collections = Array.new(args)
  end

  def timestamps(*args)
    @timestamps = Array.new(args)
  end

  def template(template)
    @template = template
  end

  def mode(mode)
    @mode = mode
  end

  def config
    raise "Please specifiy report config"
  end
end
