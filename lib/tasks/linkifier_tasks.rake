LINKIFIER_COPY_TASKS = ['assets/stylesheets', 'assets/javascripts', 'views']

namespace :linkifier do
  namespace :install do
    desc "Copy initializers from linkifier to application"
    task :initializers do
      Dir.glob(File.expand_path('../../../config/initializers/*.rb', __FILE__)) do |file|
        if File.exists?(File.expand_path(File.basename(file), 'config/initializers'))
          print "NOTE: Initializer #{File.basename(file)} from linkifier has been skipped. Initializer with the same name already exists.\n"
        else
          cp file, 'config/initializers', :verbose => false
          print "Copied initializer #{File.basename(file)} from linkifier\n"
        end
      end
    end
  end

  namespace :copy do
    LINKIFIER_COPY_TASKS.each do |path|
      name = File.basename(path)
      desc "Copy #{name} from linkifier to application"
      task name.to_sym do
        cp_r File.expand_path("../../../app/#{path}/linkifier", __FILE__), "app/#{path}", :verbose => false
        print "Copied #{name} from linkifier\n"
      end
    end
  end
  
  desc "Copy migrations from linkifier to application"
  task :install do
    Rake::Task["linkifier:install:initializers"].invoke
    Rake::Task["linkifier:install:migrations"].invoke
  end
  
  desc "Copy assets and views from linkifier to application"
  task :copy do
    LINKIFIER_COPY_TASKS.each do |path|
      Rake::Task["linkifier:copy:#{File.basename(path)}"].invoke
    end
  end

  desc "Syncs all linkified resources with Linkify"
  task :sync => :environment do
    Rails.application.eager_load!
    uri = Linkifier::Resource.linkify_resources_url(:json)
    uri.query = URI.encode_www_form(:auth_token => Linkifier.authentication_token)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = Rails.env.production?
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.ca_file = Linkifier.ca_file_path

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    if response.kind_of? Net::HTTPSuccess
      json_response = ActiveSupport::JSON.decode(response.body)
      linkify_resource_ids = json_response.collect {|r| r['id']}

      Linkifier::Resource.all.each do |lr|
        unless linkify_resource_ids.include?(lr.linkify_resource_id)
          print "Deleting linkifier resource ##{lr.id} (Linkify resource ##{lr.linkify_resource_id})\n"
          lr.delete
          next
        end
        if lr.app_resource.nil? || !lr.app_resource.send(lr.app_resource.linkify_config.persisted_method)
          print "Destroying linkifier resource ##{lr.id} (Linkify resource ##{lr.linkify_resource_id})\n"
          lr.destroy
        end
      end

      Linkifier::LINKIFIED_CLASSES.each do |lc|
        lc.all.each do |ar|
          next unless ar.linkifier_resource.nil? && ar.send(ar.linkify_config.persisted_method)
          print "Creating new linkifier resource for #{ar.linkify_config.name_proc.call(ar)}\n"
          Linkifier::Resource.create(:app_resource => ar)
        end
      end
    else
      print "Could not retrieve resource data from Linkify\n"
    end
  end
end

