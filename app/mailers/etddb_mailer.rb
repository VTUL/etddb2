#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class EtddbMailer < ActionMailer::Base
  default from: 'etd@vt.edu'

  def created_authors(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    mail(to: @authors.pluck(:email), subject: 'ETD Successfully Created.')
  end

  def submitted_authors(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    mail(to: @authors.pluck(:email), subject: 'ETD Successfully Submitted.')
  end

  def submitted_school(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    mail(to: 'cnbrittle@gmail.com', subject: 'New ETD Submitted.')
    # TODO: Change email address for graduate school.
  end

  def submitted_committee(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    committee = Person.where(id: etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))
    mail(to: committee.pluck(:email), subject: 'New ETD Submitted.')
  end

  def approved_authors(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    mail(to: @authors.pluck(:email), subject: 'Your ETD has been approved!')
  end

  def approved_school(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    mail(to: 'cnbrittle@gmail.com', subject: 'A Committee has approved an ETD.')
    # TODO: Change email address for graduate school.
  end

  def approved_committee(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    committee = Person.where(id: etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))
    mail(to: committee.pluck(:email), subject: 'An ETD has been approved.')
  end

  def approved_proquest(etd)
    @etd = etd
    @authors = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    mail(to: 'email@proquest.vt.edu', subject: 'New Electronic Dissertation')
    # TODO: the real proquest email address is 'dissepubl@proquest.com', but I don't want to send them anything by accident.
  end
end
