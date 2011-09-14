#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-16-2011
#########################################################
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # Defining Ability
       user ||= Person.new # guest user (not logged in)
       if user.has_role? :admin
         can :manage, :all
         puts 'admin role' 
       else
         can :read, :all
         puts 'other than admin role'
       end
    # Abilities in Database
    #can do |action, subject_class, subject|
    #  user.permissions.find_all_by_action(action).any do |permission|
    #    permission.subject_class == subject_class.to_s &&
    #      (subject.nil? || permission.subject_id.nil? || permission.subject_id == subject.id)
    #  end
    #end

    #can do |action, subject_class, subject|
    #  user.roles.permissions.find_all_by_action(action).any do |permission|
    #    permission.subject_class == subject_class.to_s &&
    #      (subject.nil? || permission.subject_id.nil? || permission.subject_id == subject.id)
    #  end
    #end


    # For admin
    can :manage, :all if user.has_role? :admin
    can :assign_roles, Person if user.has_role? :admin
    can :assign_permission, Permission if user.has_role? :admin

    # For author
    can :show_etd, Etd if user.has_role? :author
    can :edit_etd, Etd if user.has_role? :author
    cannot :destroy, Etd if user.has_role? :author

  end

#  def new(user)
#    Ability.new(user) 
#  end

end
