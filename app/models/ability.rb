#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Ability
  include CanCan::Ability

  def initialize(user, etd=nil, roles=nil, role_names=nil)
    user ||= Person.new
    #if !etd.nil? and !roles.nil? and !role_names.nil?
    #  # Check if the user has a specific role for this ETD, and only give them
    #  # appropriate permissions.
    #  pr = PeopleRole.new(person_id: user.id, etd_id: etd.id)
    #  for role in roles
    #    pr.role_id = role.id
    #    if user.people_roles.exists?(pr)
    #      role_names << role.name
    #      for permission in role.permission
    #        can permission.user_action.name.to_sym, permission.digital_object.name.to_sym
    #      end
    #      return
    #    end
    #  end
    #  # Since the user did not have any of the given roles, do not give them any permissions.
    #  return
    #end
    # Give the user all their permissions.
    for role in user.roles
      for permission in role.permissions
        can permission.user_action.name.to_sym, permission.digital_object.name.to_sym
      end
    end
  end

end
