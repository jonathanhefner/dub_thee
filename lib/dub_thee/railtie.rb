module DubThee
  # @!visibility private
  class Railtie < ::Rails::Railtie
    initializer "dub_thee" do
      ActiveSupport.on_load :action_view do
        include DubThee::PageTitleHelper
      end
    end
  end
end
