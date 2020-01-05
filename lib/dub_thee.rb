require "i18n/interpolate_nested"
require "dub_thee/version"
require "dub_thee/railtie"


module DubThee::PageTitleHelper

  # @!visibility private
  ACTION_TRANSLATION_PARTS = {
    "create" => "new",
    "update" => "edit",
    "destroy" => "show",
  }

  # @!visibility private
  I18N_RESERVED_OPTIONS = I18n::RESERVED_KEYS.index_by(&:itself)

  # Fetches the current page's title via +I18n.t+.  The current
  # controller and action are combined to form the translation key.
  # Specifically, the +"page_title.#{controller_name}.#{action_name}"+
  # and +"page_title.#{action_name}"+ keys are tried.  For namespaced
  # controllers, the namespace is included as part of +controller_name+
  # (dot-separated).
  #
  # I18n string interpolation is supported using the view's assignment
  # variables.  Additionally, the +titleize+'d controller name in both
  # singular and plural form is available via the interpolation keys
  # +singular+ and +plural+, respectively.
  #
  # This method is memoized to +@page_title+, and can be invoked
  # multiple times without additional cost.  This also allows views to
  # manipulate the page title outside of I18n, if necessary, by
  # assigning to the +@page_title+ variable.
  #
  # @return [String]
  def page_title
    return @page_title if defined?(@page_title)

    controller_part = controller_path.tr("/", I18n.default_separator)
    action_part = ACTION_TRANSLATION_PARTS[action_name] || action_name

    options = controller.view_assigns.symbolize_keys
    options.reject!{|key| I18N_RESERVED_OPTIONS[key] }
    options[:plural] = controller_name.titleize
    options[:singular] = options[:plural].singularize
    options[:default] = :"page_title.#{action_part}"

    @page_title = I18n.t("page_title.#{controller_part}.#{action_part}", **options)
  end

end
