module Capistrano::DataBag
  module Config
    def self.data_bag_path
      @data_bag_path = fetch(:data_bag_path) || "#{Dir::pwd}/config/deploy/data_bag"
    end

    def self.data_bag_key
      @data_bag_key = fetch(:data_bag_key) || "#{Dir::pwd}/config/deploy/encrypted_data_bag_secret"
    end
  end
end

