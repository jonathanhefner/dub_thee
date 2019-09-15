require "test_helper"
require "dub_thee"


INTERPOLATION_ARGS = {
  foo: "foooo",
  "bar.nested": "baaaar",
}

ApplicationController.class_eval do
  before_action do
    @foo = INTERPOLATION_ARGS[:foo]
    @bar = { nested: INTERPOLATION_ARGS[:"bar.nested"] }
  end
end

PostsController.class_eval do
  remove_method :create
  def create
    @post = Post.new
    render :new # simulate failed save
  end

  remove_method :update
  def update
    render :edit # simulate failed save
  end

  remove_method :destroy
  def destroy
    render :show # simulate failed destroy
  end
end

class PageTitleHelperTest < ActionDispatch::IntegrationTest

  POST_ID = Post.pluck(:id).first

  def test_index_action_page_title
    assert_page_title_i18n("posts.index") do
      get posts_path
    end
  end

  def test_show_action_page_title
    assert_page_title_i18n("posts.show") do
      get post_path(POST_ID)
    end
  end

  def test_new_action_page_title
    assert_page_title_i18n("posts.new") do
      get new_post_path
    end
  end

  def test_create_action_page_title
    assert_page_title_i18n("posts.new") do
      post posts_path, params: { post: { title: "" } }
    end
  end

  def test_edit_action_page_title
    assert_page_title_i18n("posts.edit") do
      get edit_post_path(POST_ID)
    end
  end

  def test_update_action_page_title
    assert_page_title_i18n("posts.edit") do
      put post_path(POST_ID), params: { post: { title: "" } }
    end
  end

  def test_destroy_action_page_title
    assert_page_title_i18n("posts.show") do
      delete post_path(POST_ID)
    end
  end

  def test_namespaced_controller_page_title
    assert_page_title_i18n("namespaced.things.index") do
      get namespaced_things_path
    end
  end

  def test_page_title_is_memoized
    get posts_path
    assert_match "page_title is memoized", response.body
  end

  def test_page_title_can_be_overridden
    get posts_path
    assert_match "@page_title can be overridden", response.body
  end

  private

  def assert_page_title_i18n(partial_key, &make_request)
    action_part = partial_key.split(".")[-1]
    generic_key = "page_title.#{action_part}"
    generic_title = "%{plural} %{singular} %{foo} %{bar.nested} #{action_part}"
    specific_key = "page_title.#{partial_key}"
    specific_title = generic_title + "-specific"

    plural = partial_key.split(".")[-2].titleize
    interpolation_args = INTERPOLATION_ARGS.merge(plural: plural, singular: plural.singularize)

    store_translation(generic_key, generic_title)
    store_translation(specific_key, specific_title)
    make_request.call
    assert_select "title", (specific_title % interpolation_args)

    store_translation(specific_key, nil)
    make_request.call
    assert_select "title", (generic_title % interpolation_args)
  end

  def store_translation(key, value)
    normalized = key.split(".").reverse.reduce(value){|acc, scope| { scope.to_sym => acc } }
    I18n.backend.store_translations(:en, normalized)
  end

end
