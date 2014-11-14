# Preview all emails at http://localhost:3000/rails/mailers/lead_notifier
class LeadNotifierPreview < ActionMailer::Preview

  def lead_email
    LeadNotifier.lead_email(Lead.first)
  end

  def request_info_email
    LeadNotifier.request_info_email({name: "John Doe", email: "bob@dylan.com", phone: "(242) 300-3020"})
  end
end
