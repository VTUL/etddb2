#require 'EdAuth'
class Person2 < ActiveRecord::Base
  has_and_belongs_to_many :etds

  has_and_belongs_to_many :roles


  def self.find_by_name(name)
    return user = Person.find(:first, :conditions => "last_name='#{name}'")
  end
  # Return true if the user's password matches the submitted password.
  def has_password?(name, submitted_password)
    encrypted_password == encrypt(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
  end
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

  def self.authenticate(name, submitted_password)
    puts name, submitted_password
    user = find_by_name(name)
    return Person.authenticateByEdAuth(name, submitted_password)  if user.nil?
    return user #if user.has_password?(name, submitted_password)
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
