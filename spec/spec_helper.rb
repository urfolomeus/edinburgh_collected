# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause this
# file to always be loaded, without a need to explicitly require it in any files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, make a
# separate helper file that requires this one and then use it only in the specs
# that actually need it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'webmock/rspec'
WebMock.disable_net_connect!(:allow => "codeclimate.com")

RSpec.configure do |config|
  config.before(:each) do
    @sample_request = [
      {
        title: "Arthur's Seat",
        file_type: "img",
        url: "/meadows.jpg",
        alt: "Arthur's Seat from the Meadows",
        description: "Arthur's Seat is the plug of a long extinct volcano.",
        width: 1280,
        height: 878,
        resolution: 72,
        device: "iphone",
        length: nil,
        is_readable: false,
        updated_at: "2014-06-24T09 : 55 : 58.874Z",
        created_at: "2014-06-24T09 : 55 : 58.874Z",
        _id: "986ff7a7b23bed8283dfc4b979f89b99",
        _rev: "3-818a609da8da9d9296d787b5a78fc01e",
        type: "Asset"
      },
      {
        title: "Castle",
        file_type: "img",
        url: "/castle.jpg",
        alt: "Edinburgh Castle",
        description: "Edinburgh Castle is still in active use. Situated on the Royal Mile it is very much part of the tourist trail.",
        width: 1000,
        height: 667,
        resolution: 72,
        device: "android",
        length: nil,
        is_readable: false,
        updated_at: "2014-06-24T09 : 55 : 58.871Z",
        created_at: "2014-06-24T09 : 55 : 58.871Z",
        _id: "986ff7a7b23bed8283dfc4b979f8aad9",
        _rev: "2-acf04fed22f9fd9d42dc9ba6edbc059c",
        type: "Asset"
      },
      {
        title: "Cathedral",
        file_type: "img",
        url: "/st_giles.jpg",
        alt: "St Giles Cathedral",
        description: "St Giles is Edinburgh's Cathedral. Situated on the Royal Mile it is very much part of the tourist trail.",
        width: 1880,
        height: 1254,
        resolution: 72,
        device: "iphone",
        length: nil,
        is_readable: false,
        updated_at: "2014-06-24T09 : 55 : 58.851Z",
        created_at: "2014-06-24T09 : 55 : 58.853Z",
        _id: "986ff7a7b23bed8283dfc4b979f8b8cc",
        _rev: "2-eda16fc8cca927ae37a8780119cd586f",
        type: "Asset"
      },
      {
        title: "Palace",
        file_type: "img",
        url: "/palace.jpg",
        alt: "Holyrood Palace",
        description: "Holyrood Palace is the Queen's official residence in Edinburgh. Situated on the Royal Mile it is very much part of the tourist trail.",
        width: 990,
        height: 556,
        resolution: 72,
        device: "android",
        length: nil,
        is_readable: false,
        updated_at: "2014-06-24T09 : 55 : 58.881Z",
        created_at: "2014-06-24T09 : 55 : 58.881Z",
        _id: "986ff7a7b23bed8283dfc4b979f87dfb",
        _rev: "2-0112ebc82a8a77d5359e0a90ca98612e",
        type: "Asset"
      },
      {
        title: "Tattoo",
        file_type: "img",
        url: "/tattoo.jpg",
        alt: "The Royal Military Tattoo",
        description: "Every year Edinburgh Castle plays host to the Royal Military Tattoo.",
        width: 1500,
        height: 1000,
        resolution: 72,
        device: "android",
        length: nil,
        is_readable: false,
        updated_at: "2014-06-24T09 : 55 : 58.877Z",
        created_at: "2014-06-24T09 : 55 : 58.878Z",
        _id: "986ff7a7b23bed8283dfc4b979f88d5c",
        _rev: "2-175e57c21e9dc9f6d25b6bd2d3e8b703",
        type: "Asset"
      }
    ]
    stub_request(:get, "#{ENV['HOST']}/assets").
      to_return(:body => @sample_request.to_json)
  end
# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end
=end
end

