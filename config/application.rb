require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

# #####################################################
# CHUCKSLIST CONFIGURATION VALUES
# #####################################################
DOMAIN = 'chuckslist.org'
SITE_NAME = 'ChucksList'
# be sure to include the trailing slash '/' here
SITE_URL =  case Rails.env
                when 'development' then 'http://localhost:3000/'
                when 'production'  then 'http://chuckslist.org/'
                when 'test'        then 'http://test.chuckslist.org/'
               end
JUNK_MAIL = 'garbage@chuckslist.org'

# Define DateTime format for use in our ads email address generator
# e.g. DateTime.now.to_s(:generate_hash)
Time::DATE_FORMATS[:generate_hash] = "%Y%j%S%H%M"

# Global var
$generatedKeyCount = 1

module Chuckslist
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W( #{::Rails.root.to_s}/vendor/uuid-1.0.4/lib )
    config.autoload_paths += %W( #{::Rails.root.to_s}/lib)

    config.assets.enabled = false
    config.assets.version = '1.0'

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]  
  end
end
