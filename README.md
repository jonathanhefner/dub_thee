# dub_thee [![Build Status](https://travis-ci.org/jonathanhefner/dub_thee.svg?branch=master)](https://travis-ci.org/jonathanhefner/dub_thee)

Rails page titles via I18n.  For example, given the following
application layout:

```html+erb
<!-- app/views/layouts/application.html.erb -->

<html>
  <head>
    <title><%= page_title %> | My Web Site</title>
  </head>
  ...
</html>
```

And the following translations:

```yaml
## config/locales/page_title.en.yml

en:
  page_title:
    home:
      index: "Welcome"
```

The "app/views/home/index.html.erb" view will automatically be titled
"Welcome | My Web Site".

The `page_title` helper fetches the title via `I18n.t`, using the
controller name and action name to make up the translation key.  Any
action name is allowed, however "create", "update", and "delete" are
special-cased to instead fetch the titles of their render-on-failure
counterparts: "new", "edit", and "show", respectively.


## Variable interpolation

For more dynamic titles, view assignment variables are made available
for interpolation.  Additionally, the [i18n-interpolate_nested] gem
is included to enable attribute interpolation.  For example, given the
following translations:

```yaml
## config/locales/page_title.en.yml

en:
  page_title:
    products:
      show: "%{product.name} (%{product.brand})"
```

The value of `page_title` for "app/views/products/show.html.erb" will be
equivalent to `"#{@product[:name]} (#{@product[:brand]})"`.

[i18n-interpolate_nested]: https://rubygems.org/gems/i18n-interpolate_nested


## Generic titles

Generic action titles (i.e. not controller-specific) are also supported.
To allow such titles to be slightly more dynamic, two additional values
are provided for interpolation: `plural` is the `String#titleize`'d name
of the controller, and `singular` is the `String#singularize`'d form of
`plural`.  For example, given the following translations:

```yaml
## config/locales/page_title.en.yml

en:
  page_title:
    index: "%{plural}"
    new: "New %{singular}"
```

The value of `page_title` for "app/views/part_orders/index.html.erb"
will be `"Part Orders"`, and for "app/views/locations/index.html.erb"
will be `"Locations"`.  Likewise, the value of `page_title` for
"app/views/part_orders/new.html.erb" will be `"New Part Order"`, and for
"app/views/locations/new.html.erb" will be `"New Location"`.


## Additional logic

Additional logic can be incorporated by using the `@page_title`
variable.  If `@page_title` is set, the `page_title` helper will simply
return `@page_title`.  Thus, individual views can implement more nuanced
title logic.  For example, given the following translations:

```yaml
## config/locales/page_title.en.yml

en:
  page_title:
    users:
      show: "%{user.name}"
```

And the following view:

```html+erb
<!-- app/views/users/show.html.erb -->

<% @page_title = "Your Profile" if current_user == @user %>

...
```

The value of `page_title` in "app/views/layouts/application.html.erb"
will be `"Your Profile"` if the current logged-in user is viewing their
own profile.  Else, it will be equivalent to `"#{@user[:name]}"`.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "dub_thee"
```

Then execute:

```bash
$ bundle install
```

And finally, run the install generator:

```bash
$ rails generate dub_thee:install
```


## Contributing

Run `rake test` to run the tests.


## License

[MIT License](https://opensource.org/licenses/MIT)
