# typed: true
# frozen_string_literal: true

require "action_cable/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "active_job/railtie"
require "active_support/core_ext/integer/time"
require "bootsnap/setup"
require "bundler/setup"
require "devise/orm/mongoid"
require "rails"
require "rails/test_help"
require "rails/test_unit/railtie"
