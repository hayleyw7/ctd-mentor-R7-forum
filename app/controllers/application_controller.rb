class ApplicationController < ActionController::Base
  before_action :set_current_user

private

  def set_current_user
    if session[:current_user]
      begin
        if session[:current_user].is_a?(Hash)
          @current_user = User.find(session[:current_user]["id"])
        else
          @current_user = User.find(session[:current_user])
        end
      rescue ActiveRecord::RecordNotFound
        session[:current_user] = nil
        @current_user = nil
      end
    else
      @current_user = nil
    end
  end
end
