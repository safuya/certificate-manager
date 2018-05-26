# Certificate Manager

This application manages certificates, tracking expiry dates and ciphers being
used. It runs on Ruby 2.3.3 and Rails 5.2.

## Configuration

You need to add a GITHUB_ID and GITHUB_SECRET in .env in the root directory.

You will also need to run `bundle` to get the correct packages.

## Database Creation

Use rake db:migrate RAILS_ENV=your_environment

Without an environment specified, development will be used. Other configured
environments are test and production.

## Test Suite

The tests use rspec and capybara. To run the tests use `rspec`. By default it
will give summarised feedback. They will give more detailed feedback if running
on a specific folder or file.

All tests are located in `spec`.

## Deployment Instructions

Coming soon..

## Contributing

Bug reports and pull requests are welcome on GitHub at
[Certificate Manager](https://github.com/safuya/certificate-manager). This
project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The code is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Device Manager project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/safuya/device-manager/blob/master/CODE_OF_CONDUCT.md).
