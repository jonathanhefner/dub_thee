require "i18n/interpolate_nested"
require "dub_thee/version"
require "dub_thee/railtie"


module DubThee::PageTitleHelper

  ACTION_TRANSLATION_PARTS = {
    "create" => "new",
    "update" => "edit",
    "destroy" => "show",
  }

  I18N_RESERVED_OPTIONS = I18n::RESERVED_KEYS.index_by(&:itself)

  def page_title
    return @page_title if defined?(@page_title)

    controller_part = controller_path.tr("/", I18n.default_separator)
    action_part = ACTION_TRANSLATION_PARTS[action_name] || action_name

    options = controller.view_assigns.symbolize_keys
    options.reject!{|key| I18N_RESERVED_OPTIONS[key] }
    options[:plural] = controller_name.titleize
    options[:singular] = options[:plural].singularize
    options[:default] = :"page_title.#{action_part}"

    @page_title = I18n.t("page_title.#{controller_part}.#{action_part}", options)
  end

end
