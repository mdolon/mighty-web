# Preview all emails at http://localhost:3000/rails/mailers/lead_notifier
class LeadNotifierPreview < ActionMailer::Preview

  def lead_email
    LeadNotifier.lead_email(Lead.first)
  end
end
