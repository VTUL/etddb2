#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Etd < ActiveRecord::Base
  delegate :url_helpers, to: 'Rails.application.routes'

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

  def next_unfinished()
    unless self.status == "Created"
      return nil
    end

    # 7 - Needs creator.
    if Redis.current.getbit("created:#{self.id}", 7) == 0
      return [url_helpers.add_creator_to_etd_path(self), "add an author"]
    end
    # 6 - Needs content
    if Redis.current.getbit("created:#{self.id}", 6) == 0
      return [url_helpers.etd_contents_path(self), "add content"]
    end

    if self.bound?
      # BTDs only need the two above.
      return nil
    end

    # 5 - Needs collaborator(s)
    if Redis.current.getbit("created:#{self.id}", 5) == 0
      return [url_helpers.add_collaborator_to_etd_path(self), "add your committee"]
    end
    # 4 - Needs a release review.
    if Redis.current.getbit("created:#{self.id}", 4) == 0 && self.availability.allows_reasons?
      return [url_helpers.pick_reason_for_etd_path(self), "review your release schedule"]
    end
    # 3 - Needs to take the survey.
    # 2 - Needs to return from the survey.
    if Redis.current.getbit("created:#{self.id}", 2) == 0
      return [url_helpers.survey_path(self), "take the survey"]
    end

    return nil
  end

  def create_archive()
    # TODO: create archive.
    puts("I'll get right on that.")
  end
end
