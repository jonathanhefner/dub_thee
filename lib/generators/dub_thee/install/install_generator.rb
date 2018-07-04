require "rails/generators/base"

module DubThee
  # @!visibility private
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(__dir__, "templates")

      def copy_locales
        copy_file "config/locales/page_title.en.yml"
      end
    end
  end
end
