#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class ApprovalMailer < ActionMailer::Base

  def confirm(person)
    subject    "Dear #{person.last_name}, #{person.first_name}"
    recipients person.email
    from       'shpark@vt.edu'
    sent_on    Time.now

    body       "Confirmed."
  end

  def sent(sent_at = Time.now)
    subject    'ApprovalMailer#sent'
    recipients person.email
    from       'shpark@vt.edu'
    sent_on    Time.now

    body       :greeting => 'Hi,'
  end

end
