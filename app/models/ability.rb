#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-16-2011
#########################################################
class Ability
  include CanCan::Ability

  def initialize(user)
    # Defining Ability
       user ||= Person.new # guest user (not logged in)

    for role in user.roles
      for permission in role.permission
        can permission.user_action.name.to_sym, permission.digital_object.name.to_sym
        puts permission.user_action.name.to_sym,  permission.digital_object.name.to_sym
      end
    end
  end
end
