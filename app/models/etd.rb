#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Etd < ActiveRecord::Base
  belongs_to :availability, inverse_of: :etds
  belongs_to :copyright_statement, inverse_of: :etds
  belongs_to :degree, inverse_of: :etds
  belongs_to :document_type, inverse_of: :etds
  belongs_to :privacy_statement, inverse_of: :etds

  has_many :contents, dependent: :destroy, inverse_of: :etd
  accepts_nested_attributes_for :contents, allow_destroy: true
  has_many :people_roles, dependent: :destroy, inverse_of: :etd
  has_many :roles, through: :people_roles
  has_many :people, through: :people_roles
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  has_and_belongs_to_many :departments

  validates_presence_of :abstract, :availability_id, :copyright_statement_id, :degree_id,
                        :document_type_id, :title, :privacy_statement_id, :urn, :url
  validates_uniqueness_of :urn
  validates :bound, inclusion: {in: [true, false], message: "must be boolean"}
  statuses = ["Created", "Submitted", "Approved", "Released"]
  validates :status, inclusion: {in: statuses, message: "must be a valid status."}

  searchable do
    text :title, :boost => 5
    text :keywords
    text :abstract
    text :author
    text :committee
    text :urn
    text :file_type
    integer :document_type_id
    integer :department, :multiple => true
    string :urn
    string :author, :multiple => true
    string :committee, :multiple => true
    string :defense_year
    string :release_year
    string :file_type, :multiple => true
    date :defense_date
    date :release_date
    boolean :bound
    text :etd_attachment
  end

  def author
    creators = Person.where(id: self.people_roles.where(role_id: Role.where(group: 'Creators'))
        .pluck(:person_id)).order('last_name ASC')
    creators.map { |o| o.name }
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
    cont.map { |content|
      if content.content_content_type.eql?('application/pdf')
        # java -cp :/RAILS_ROOT/parser/tika-app-1.3.jar:/RAILS_ROOT/parser pdfparser <pdf filepath>
        parser_path = Rails.root.join('parser').to_s
        tika_path = Rails.root.join('parser', 'tika-app-1.3.jar').to_s
        parsed = `java -cp :#{tika_path}:#{parser_path} pdfparser #{content.content.path}`
      end
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
end
