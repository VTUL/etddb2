#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class EtddbMailer < ActionMailer::Base
  default :from => 'shpark@vt.edu'

  def confirm_submit_author(etd, author)
    @etd = etd
    @author = author
    mail(:to => @author.email, :subject => 'ETD Successfully Submitted.')
  end

  def confirm_submit_school(etd, author)
    @etd = etd
    @author = author
    mail(:to => 'graduate.school@vt.edu', :subject => 'New ETD Submitted.')
  end

  def confirm_submit_committee(etd, author)
    @etd = etd
    @author = author
    committee = Person.find(etd.people_roles.where(:role_id => Role.where(group: 'Collaborators')).map(&:person_id))
    mail(:to => committee.map(&:email), :subject => 'New ETD Submitted.')
  end
end
