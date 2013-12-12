# TenThousandFeet

Ruby wrapper for the [10,000ft API (BETA)](http://10kft.github.io/api-documentation).

## Installation

    gem 'ten_thousand_feet'

Or

    gem install ten_thousand_feet

## Setup

    require 'ten_thousand_feet'

    # Initialize a new 10,000ft client
    client = TenThousandFeet.new(auth: YOUR_AUTH_TOKEN)

## Users

    client.get_users(options)
    client.show_user(id, options)
    client.update_user(id, options)
    client.create_user(options)

## Projects

    client.get_projects(options)
    client.show_project(id, options)
    client.update_project(id, options)
    client.create_project(options)
    client.delete_project(id, options)

## Time Entries

    client.get_time_entries(user_id, options)
    client.show_time_entry(id, user_id, options)
    client.update_time_entry(id,user_id, options)
    client.create_time_entry(user_id, options)
    client.delete_time_entry(id, user_id, project_id, options)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
