# /app/controllers/settings_controller.rb
class SettingsController < ApplicationController
  respond_to :json
  def create
    value = Setting.get_value(params[:setting][:data_type], params[:setting][:value])
    Setting[params[:setting][:name]] = value
    Setting.find_by(name: params[:setting][:name]).update_attribute(data_type: "#{value.class}")
    render nothing:true
  end
end