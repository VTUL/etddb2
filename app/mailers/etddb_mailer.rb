#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class EtddbMailer < ActionMailer::Base
  default :from => 'shpark@vt.edu'

  def confirm_submit(etd)
    @etd = etd
    @author = Person.find(etd.people_roles.where(:role_id => Role.where(:name => 'Author').first).first.person_id)
    @committee = Person.find(etd.people_roles.where(:role_id => Role.where("name LIKE 'Committee%'")).map(&:person_id))
    mail(:to => @author.email, :subject => 'ETD Successfully Submitted.', :template_name => 'confirm_submit_author')
    mail(:to => @committee.map(&:email), :subject => 'New ETD Submitted.', :template_name => 'confirm_submit_committee')
    mail(:to => 'gradute.school@vt.edu', :subject => 'New ETD Submitted.', :template_name => 'confirm_submit_school')
  end
end
