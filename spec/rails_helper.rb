# spec/rails_helper.rb

# Load the Rails application
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

# Require other libraries you might need for testing

# Configure RSpec
RSpec.configure do |config|
  # Remove the line that used to configure infer_spec_type_from_file_location!
  # config.infer_spec_type_from_file_location!

  # Instead, use the following settings:
  config.define_derived_metadata(file_path: Regexp.new('/spec/models/')) do |metadata|
    metadata[:type] = :model
  end

  config.define_derived_metadata(file_path: Regexp.new('/spec/controllers/')) do |metadata|
    metadata[:type] = :controller
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :active_record
    end
  end
end
