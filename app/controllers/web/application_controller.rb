# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :logged_in_user
end
