module DubThee
  # @!visibility private
  class Railtie < ::Rails::Railtie
    initializer "dub_thee" do
      ActionView::Base.send(:include, DubThee::PageTitleHelper)
    end
  end
end
