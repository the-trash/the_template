# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

##
# Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#

# Tilt monkey patch for Ru text
module Tilt
  class HamlTemplate
    def prepare
      @data.force_encoding Encoding.default_external
      options = @options.merge(:filename => eval_file, :line => line)
      @engine = ::Haml::Engine.new(data, options)
    end
  end
  class CoffeeScriptTemplate
    def prepare
      @data.force_encoding Encoding.default_external
      if !options.key?(:bare) and !options.key?(:no_wrap)
        options[:bare] = self.class.default_bare
      end
    end
  end
end

##
# Add your before load hooks here
#
Padrino.before_load do
end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!