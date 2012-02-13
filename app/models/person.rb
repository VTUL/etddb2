#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################
require 'edauth'

class Person < ActiveRecord::Base
  self.table_name = "people"

  # Assicate tables
  has_many :people_roles
  has_many :roles, :through => :people_roles
  has_many :etds, :through => :people_roles

  # Validates attributes
  validates_presence_of :first_name, :last_name, :pid, :email
  validates_uniqueness_of :pid, :email

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :pid ]

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me

  # for authentication through matching the login name to the stored names.
  def self.find_by_pid(pid)
    return user = Person.find(:first, :conditions => "pid='#{pid}'")
  end

  # Return true if the user's password matches the submitted password.
  def has_password?(name, submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  ##for authorization
  #def authorize
  #   begin
  #     return @user = Person.find(:first,:conditions=> "pid='#{pid}'")
  #   rescue ActiveRecord::RecordNotFound
  #     return nil
  #   end
  #
  #  #if (roles.count.greater.than 2)
  #    # Re enter credentials for authorization w/ dropdown box of roles
  #    # land on the user page
  #    # Prints basic user info pid, full name , email previous documents (if an rink to submit new)
  #  #end
  #end

  # for authentication by EdAuth
  def self.authenticateByEdAuth(pid, submitted_password)
    x = EdAuth.new(pid, submitted_password)
    if x.nil?
      return nil
    else
      if x.authenticate
        x.get_primary_affiliation
        x.get_affiliations
        x.close
        user = Person.new
        user.pid = pid
#       user.email = email
        return user
      else
        return nil
      end
    end
  end

  # for regular authentiction
  def self.authenticate(pid, submitted_password)
    puts pid, submitted_password
    user = find_by_pid(pid)
    return Person.authenticateByEdAuth(pid, submitted_password)  if user.nil?
    return user #if user.has_password?(name, submitted_password)
  end

  #separated role model
  #def roles=(roles)
  #  self.roles_mask = (roles && ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end
  #
  #def roles
  #  ROLES.reject do |r|
  #    ((roles_mask || 0) & 2**ROLES.index(r)).zero?
  #end


  def has_role?(role_sym)
    roles.any? { |r| r.name.to_sym == role_sym }
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  private
  def encrypt_password
    unless password.nil?
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
    end
  end

  def encrypt(string)
    string # Only a temporary implementation!
  end

  def make_salt
    secure_hash("#{Time.now.utc}#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
