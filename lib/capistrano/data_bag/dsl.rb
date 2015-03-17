require "json"

module Capistrano::DataBag
  module DSL
    def self.create_data_bag_item(key, value, data)
      FileUtils.makedirs "#{data_bag_config.data_bag_path}" unless Dir.exist? "#{data_bag_config.data_bag_path}"
      data_bag_item_file = "#{data_bag_config.data_bag_path}/#{key}.json"
      File.open(data_bag_item_file, "w") do |f|
        f.write JSON.pretty_generate(data.merge!(id: key))
      end
      puts "Created a data bag item at: #{data_bag_item_file}"
    end

    def self.create_encrypted_data_bag_item(k, v)
      secret = load_data_bag_secret
      encrypted_data = Capistrano::DataBag::Support.encrypt_data_bag_item(k, v, secret)
      create_data_bag_item(k, v, encrypted_data)
    end

    def self.load_data_bag(key, secret = nil)
      unless File.exist? "#{data_bag_config.data_bag_path}/#{key}.json"
        puts "could not find #{data_bag_config.data_bag_path}/#{key}.json"
        exit 2
      end

      item_json = Capistrano::DataBag::Support.load_json("#{data_bag_config.data_bag_path}/#{key}.json")
      secret ||= load_data_bag_secret
      item_json = Capistrano::DataBag::Support.decrypt_value(item_json, secret)
      item_json
    end

    def self.load_data_bag_secret(data_bag_secret = nil)
      data_bag_secret ||= fetch(:data_bag_secret)
      throw ArgumentError.new("You must supply a secret file path. (Hint: set :data_bag_secret, \"#{Capistrano::DataBag::Config::data_bag_key}\")") unless data_bag_secret
      IO.read(data_bag_secret).strip
    end
  end
end

