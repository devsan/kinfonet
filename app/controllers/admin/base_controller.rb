class Admin::BaseController < ApplicationController
  before_filter :signed_in_user
  before_filter :authorize_admin!
end