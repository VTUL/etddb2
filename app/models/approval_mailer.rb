#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class ApprovalMailer < ActionMailer::Base
  default :from => 'shpark@vt.edu'

  def confirm(person)
    @person = person
    mail(:to => person.email, :subject => "Confirmed.")
  end

end
