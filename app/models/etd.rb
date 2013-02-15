#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

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
  validates_uniqueness_of :urn

  ACCESS = AccessConstraint.new()

  searchable do
    text :title, :boost => 5
    text :keywords
    text :abstract
    text :author
    text :committee
    text :urn
    text :file_type
    text :etd_attachment
    integer :document_type_id
    integer :department, :multiple => true
    string :title
    string :urn
    string :author, :multiple => true
    string :committee, :multiple => true
    string :defense_year
    string :release_year
    string :file_type, :multiple => true
    string :availability_status
    date :defense_date
    date :release_date
    boolean :bound
  end

  def author
    creators = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Creators'))
        .pluck(:person_id)).order('last_name ASC')
    creators.map { |o| o.name }
  end

  def availability_status
    self.availability.name
  end

  def committee
    collaborators = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Collaborators'))
        .pluck(:person_id)).order('last_name ASC')
    collaborators.map { |o| o.name }
  end

  def department
    dept = Department.where(id: self.departments)
    dept.map { |e| e.id }
  end

  def etd_attachment
    cont = self.contents
    exception_identifier = 'EXCEPTION_IN_SCRIPT'
    cont.map { |content|
      parser_path = Rails.root.join('parser').to_s
      tika_path = Rails.root.join('parser', 'tika-app-1.3.jar').to_s
      # execute script to parse pdf
      parsed = `java -cp :#{tika_path}:#{parser_path} pdfparser #{content.content.path} #{exception_identifier}`
      if parsed.start_with?(exception_identifier)
        # Log here as desired.  Java exceptions printed to console.
        next nil
      end
      next parsed
    }
  end

  def file_type
    cont = self.contents
    cont.map { |e| e.content_content_type }
  end

  def defense_year
    # Need to change to defense_date when merging with devel
    if !defense_date.nil?
      defense_date.strftime("%Y")
    end
  end

  def release_year
    # Need to change to release_date when merging with devel
    if !release_date.nil?
      release_date.strftime("%Y")
    end
  end

  def self.search_quick(search)
    if search 
      where('etds.title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def create_archive()
    # TODO: create archive.
    puts("I'll get right on that.")
  end
end
