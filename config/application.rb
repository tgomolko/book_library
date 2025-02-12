require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookLibrary
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
   # config.autoload_paths += %W(#{config.root}/services/**/)
    config.autoload_paths += Dir[Rails.root.join('app','interactors','{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'presenters', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('lib','services','stripe', '{*/}')]
    config.autoload_paths += Dir["#{config.root}/lib/services/**/"]
    #config.autoload_paths << File.join(config.root, "lib")
    #config.autoload_paths += Dir[Rails.root.join('app', 'services', '{*/}')]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
