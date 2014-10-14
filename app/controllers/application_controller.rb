class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
   
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  private

  def set_locale
    if request.fullpath.include? 'casein'
      I18n.locale = "en" 
    else
      I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    end
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
 
end
