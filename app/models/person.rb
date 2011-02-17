#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

require 'edauth'

class Person < ActiveRecord::Base

  # set multiple roles
#  ROLES=%w[admin author committee_chair committee_cochair committee_member reviewer manager cataloger]

  has_and_belongs_to_many :etds

  has_and_belongs_to_many :roles

  # for authentication through matching the login name to the stored names.
  def self.find_by_name(name)
    return user = Person.find(:first, :conditions => "last_name='#{name}'")
  end

  # Return true if the user's password matches the submitted password.
  def has_password?(name, submitted_password)
    encrypted_password == encrypt(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
  end

  # for authentication by EdAuth
  def self.authenticateByEdAuth(pid, submitted_password)
    x = EdAuth.new(pid, submitted_password)
    if x.authenticate
      x.get_primary_affiliation
      x.get_affiliations
      x.close
      user = Person.new
      user.pid = pid
#      user.email = email
      return user
    else
      return nil
    end
  end

  # for regular authentiction
  def self.authenticate(name, submitted_password)
    puts name, submitted_password
    user = find_by_name(name)
    return user if user.has_password?(name, submitted_password)
    return Person.authenticateByEdAuth(name, submitted_password)  if user.nil?
  end

  #separated role model
#  def roles=(roles)
#    self.roles_mask = (roles && ROLES).map { |r| 2**ROLES.index(r) }.sum
#  end

#  def roles
#    ROLES.reject do |r|
#      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
#    end
#  end

  
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
