# VersionBomb

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'version_bomb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install version_bomb

## Usage

Here is an example. Important things to note are the specific gem version and
the massive comment with instructions for the developer who gets hit by the
bomb.

```ruby
require 'version_bomb'

VersionBomb.blow_up_if_gem_version_changes('actionview', '4.2.0')

# NOTE: Removing this will probably cause a regression for some IE browsers.
# Do not remove until it is fixed in Rails and you know exactly what you are doing.
# See: https://github.com/rails/rails/issues/13523

# WHEN UPGRADING:
# Copy select_content_tag from lib/action_view/helpers/tags/base.rb
# in actionview and change the `tag(...) + select` line to `select + tag(...)`
# NOTE: if you do not find that method in that file, it may have moved. Look for it.
# Leave the PATCH line from below.

# This works around a problem with multi selects in the form helper. In order to combat
# the browser not sending no selection, rails adds a hidden field along with the actual
# select tag. Unfortunately, it adds the hidden field BEFORE the select. That's fine in
# Chrome, but it breaks firefox's handling of labels that contain inputs. Firefox looks
# for the first element, which in this case would be a hidden. All this patch does is
# change the order of the two items.

ActionView::Helpers::Tags::Base.class_eval do
  def select_content_tag(option_tags, options, html_options)
    html_options = html_options.stringify_keys
    add_default_name_and_id(html_options)
    options[:include_blank] ||= true unless options[:prompt] || select_not_required?(html_options)
    value = options.fetch(:selected) { value(object) }
    select = content_tag("select", add_options(option_tags, options, value), html_options)

    if html_options["multiple"] && options.fetch(:include_hidden, true)
      # PATCH: this line is the only one that changed, the order of the operands
      select + tag("input", :disabled => html_options["disabled"], :name => html_options["name"], :type => "hidden", :value => "")
    else
      select
    end
  end
end
```

As a bonus, you can also test your ruby version:

```ruby
VersionBomb.blow_up_if_ruby_version_changes('2.2.0')
```

## Contributing

1. Fork it ( https://github.com/aaronjensen/version_bomb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
