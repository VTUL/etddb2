#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class EtddbMailer < ActionMailer::Base
  default from: 'etds-no-reply@scholar.lib.vt.edu'

  def confirm_create(etd, author)
    @etd = etd
    @author = author
    mail(to: @author.email, subject: 'ETD Successfully Created.')
  end

  def confirm_submit_author(etd, author)
    @etd = etd
    @author = author
    mail(to: @author.email, subject: 'ETD Successfully Submitted.')
  end

  def confirm_submit_school(etd, author)
    @etd = etd
    @author = author
    mail(to: 'cnbrittle@gmail.com', subject: 'New ETD Submitted.')
    # TODO: Change email address for graduate school.
  end

  def confirm_submit_committee(etd, author)
    @etd = etd
    @author = author
    committee = Person.where(id: etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))
    mail(to: committee.pluck(:email), subject: 'New ETD Submitted.')
  end

  def committee_approved(etd)
    @etd = etd
    mail(to: 'cnbrittle@gmail.com', subject: 'A Committee has approved an ETD.')
    # TODO: Change email address for graduate school.
  end

  def proquest(etd)
    @etd = etd
    mail(to: 'email@proquest.vt.edu', subject: 'New Dissertation from Virginia Tech')
    # TODO: the real proquest email address is 'dissepubl@proquest.com', but I don't want to send them anything by accident.
  end
end
