require "test_helper"
require "generators/dub_thee/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests DubThee::Generators::InstallGenerator
  destination File.join(__dir__, "tmp")

  setup do
    prepare_destination
  end

  def test_generates_installation_files
    run_generator
    assert_file "config/locales/page_title.en.yml"
  end
end
