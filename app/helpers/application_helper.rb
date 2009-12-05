# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def client_browser_name
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    return "Safari" if user_agent =~ /applewebkit/i
    return "Internet Explorer" if user_agent =~ /msie/i
    return "Mozilla" if user_agent =~ /gecko/i
    "Unkown"
  end
end
