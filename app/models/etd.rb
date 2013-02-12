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

  def self.search(search)
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
