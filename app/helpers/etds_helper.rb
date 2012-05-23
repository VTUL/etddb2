module EtdsHelper
  def get_creators(etd)
    if block_given?
      yield Person.where(id: etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    else
      Person.where(id: etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    end
  end

  def get_collabs(etd)
    if block_given?
      yield Person.find(etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))
    else
      Person.find(etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))
    end
  end
end
