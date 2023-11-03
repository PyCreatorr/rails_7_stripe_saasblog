class ApplicationController < ActionController::Base
    before_action :authenticate_user! # unless user is logged in - no action is awailable
end
