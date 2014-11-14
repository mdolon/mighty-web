class LeadNotifier < ActionMailer::Base
  default from: "hi@mightyapp.co"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def lead_email(lead)
    # attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @lead = lead
    send_to = "#{@lead.name} <#{@lead.email}>"
    mail(to: send_to, subject: 'Welcome to Mighty and a healthier lifestyle!')
  end

  def request_info_email(lead)
    # attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @lead = lead
    send_to = "Mighty Team <hi@mightyapp.co>"
    mail(to: send_to, subject: 'New contact request from Startup')
  end
end
