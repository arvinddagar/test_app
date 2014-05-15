# /app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  def index
    @settings = Setting.all
  end
end
