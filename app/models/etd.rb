#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################
class DepartmentValidator < ActiveModel::Validator
  def validate(record)
    if record.departments.empty?
      record.errors[:base] << "Must have at least one department."
    end
  end
end

class Etd < ActiveRecord::Base
  belongs_to :copyright_statement, inverse_of: :etds
  belongs_to :degree, inverse_of: :etds
  belongs_to :document_type, inverse_of: :etds
  belongs_to :privacy_statement, inverse_of: :etds
  belongs_to :availability, inverse_of: :etds
  belongs_to :reason, inverse_of: :etds

  has_many :contents, dependent: :destroy, inverse_of: :etd
  accepts_nested_attributes_for :contents, allow_destroy: true
  has_many :people_roles, dependent: :destroy, inverse_of: :etd
  has_many :roles, through: :people_roles
  has_many :people, through: :people_roles
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  has_and_belongs_to_many :departments

  STATUSES = ["Created", "Submitted", "Approved", "Released"]
  validates :status, inclusion: {in: STATUSES, message: "must be a valid status."}
  validates :bound, inclusion: {in: [true, false], message: "must be boolean"}
  validates_presence_of :availability_id, :copyright_statement_id, :degree_id, :document_type_id, :privacy_statement_id, :reason_id
  validates_presence_of :abstract, :title, :urn, :url
  validates_with DepartmentValidator
  validates_uniqueness_of :urn

  ACCESS = AccessConstraint.new()

  # Block telling Sunspot how to index this ETD
  searchable do
    text :title, :boost => 5
    text :keywords
    text :abstract
    text :author
    text :author_email
    text :committee
    text :urn
    text :file_type
    text :pid
    text :etd_attachment, :stored => true
    integer :document_type_id
    integer :department, :multiple => true
    string :title
    string :urn
    string :author, :multiple => true
    string :committee, :multiple => true
    string :defense_year
    string :release_year
    string :creation_year
    string :approval_year
    string :file_type, :multiple => true
    string :availability_status
    date :defense_date
    date :release_date
    date :approval_date
    date :created_at
    boolean :bound
  end

  # Get array of all author names associated with this ETD
  private
  def author
    creators = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Creators'))
        .pluck(:person_id)).order('last_name ASC')
    creators.map { |o| o.name }
  end

  # Get array of all author emails associated with this ETD
  private
  def author_email
    authors = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Creators'))
        .pluck(:person_id))
    authors.map { |o| o.email }
  end

  # Get an array of all PIDS from both the authors and collaborators
  private
  def pid
    authors = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Creators'))
        .pluck(:person_id))
    committee = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Collaborators'))
        .pluck(:person_id))
    auth = authors.map { |o| o.pid }
    comm = committee.map { |o| o.pid }
    return auth.concat(comm)
  end

  # Get the vailability status of this ETD
  private
  def availability_status
    self.availability.name
  end

  # Get an array of the names of all committee members of this ETD
  private
  def committee
    collaborators = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Collaborators'))
        .pluck(:person_id)).order('last_name ASC')
    collaborators.map { |o| o.name }
  end

  # Get an array of all department ID's for this ETD
  private
  def department
    dept = Department.where(id: self.departments)
    dept.map { |e| e.id }
  end

  # For each document associated with this ETD parse it with Tika, the text
  # of each document will be read in through STDOUT
  private
  def etd_attachment
    cont = self.contents
    exception_identifier = 'EXCEPTION_IN_SCRIPT'
    cont.map { |content|
      parser_path = Rails.root.join('parser').to_s
      tika_path = Rails.root.join('parser', 'tika-app-1.3.jar').to_s
      # execute script to parse pdf
      parsed = `java -cp :#{tika_path}:#{parser_path} FileParser #{content.content.path} #{exception_identifier}`
      if parsed.start_with?(exception_identifier)
        # Log here as desired.  Java exceptions printed to console.
        next nil
      end
      next parsed
    }
  end

  # Get an array of all file types of associated documents
  private
  def file_type
    cont = self.contents
    cont.map { |e| e.content_content_type }
  end

  # Get the defense year as a string
  private
  def defense_year
    if !defense_date.nil?
      defense_date.strftime("%Y")
    end
  end

  # Get the release year as a string
  private
  def release_year
    if !release_date.nil?
      release_date.strftime("%Y")
    end
  end

  # Get the creation year as a string
  private
  def creation_year
    # Theoretically should never be null, sanity check
    if !created_at.nil?
      created_at.strftime("%Y")
    end
  end

  # Get the approval year as a string
  private
  def approval_year
    if !approval_date.nil?
      approval_date.strftime("%Y")
    end
  end

  def create_archive()
    # TODO: create archive.
    puts("I'll get right on that.")
  end
end
