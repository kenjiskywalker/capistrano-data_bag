mespace :data_bag do
  desc 'Create a new data bag'
  task :create do
    execute 'echo "create"'
#    data = read_create_data_bag_information
#    create_data_bag_item(data_bag_name, data_bag_item, data)
  end

  desc 'Show the content of a data bag'
  task :show do
    execute 'echo "show"'
#    set(:data_bag_name, Capistrano::CLI.ui.ask("Enter data bag name: ")) unless exists?(:data_bag_name)
#    if data_bag = load_data_bag(data_bag_name)
#      Capistrano::CLI.ui.say "Data bag :#{data_bag_name} content:\n#{JSON.pretty_generate data_bag}"
#    else
#      Capistrano::CLI.ui.say "could not find data bag: #{data_bag_name}"
#    end
  end

  namespace :encrypted do
    desc 'Create a new data bag with encrypted content'
    task :create do
    execute 'echo "create"'
#      secret = load_data_bag_secret
#      data = read_create_data_bag_information
#      create_encrypted_data_bag_item(data_bag_name, data_bag_item, data, secret)
    end
  end
end

