COPY_TASKS = ['assets/stylesheets', 'assets/javascripts', 'views']

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
    COPY_TASKS.each do |path|
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
    COPY_TASKS.each do |path|
      Rake::Task["linkifier:copy:#{File.basename(path)}"].invoke
    end
  end
end

