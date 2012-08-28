#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Etd < ActiveRecord::Base
  belongs_to :availability
  belongs_to :copyright_statement
  belongs_to :degree
  belongs_to :document_type
  belongs_to :privacy_statement

  has_many :contents, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true
  has_many :people_roles, dependent: :destroy
  has_many :roles, through: :people_roles
  has_many :people, through: :people_roles
  has_many :provenances, as: :model
  #has_many :messages, as: :model

  has_and_belongs_to_many :departments

  validates_presence_of :abstract, :availability_id, :copyright_statement_id, :degree_id,
                        :document_type_id, :title, :privacy_statement_id, :urn, :url
  validates_uniqueness_of :urn
  validates :bound, inclusion: {in: [true, false], message: "must be boolean"}
  statuses = ["Created", "Submitted", "Approved"]
  validates :status, inclusion: {in: statuses, message: "must be a valid status."}

  def self.search(search)
    if search 
      where('etds.title LIKE ?', "%#{search}%")
    else 
      scoped
    end
  end
end
