require 'capistrano/data_bag/version'
require 'capistrano/data_bag/support'
require 'capistrano/data_bag/dsl'
require 'capistrano/data_bag/config'

namespace :data_bag do
  def data_bag_config
    Capistrano::DataBag::Config
  end

  def dsl
    Capistrano::DataBag::DSL
  end

  def load_data_bag(k)
    @data_bag = dsl.load_data_bag(k)
  end

  desc 'Show the content of a data bag'
  task :show do
    run_locally do
      k = request_key_data
      if data_bag = load_data_bag(k)
        puts "#{data_bag}"
      end
    end
  end

  desc 'Create a new data bag with encrypted content'
  task :create do
    run_locally do
      key   = request_key_data
      value = request_value_data

      dsl.create_encrypted_data_bag_item(key, value)
    end
  end

  private

  def request_key_data
      ask(:data_bag_key, nil)
      k = fetch(:data_bag_key)
      input_data_check(k)
      k
  end

  def request_value_data
      ask(:data_bag_value, nil)
      v = fetch(:data_bag_value)
      input_data_check(v)
      v
  end

  def input_data_check(value)
    if value.nil?
      puts 'Please input data.'
      exit 2
    end
  end
end

