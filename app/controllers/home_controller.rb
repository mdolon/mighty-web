class HomeController < ApplicationController
  def index
    if params[:type].present? && params[:type] == "request_info"
      begin
        LeadNotifier.request_info_email({name: params[:name], email: params[:email], phone: params[:phone]}).deliver
      rescue
      end
    end
  end
end
