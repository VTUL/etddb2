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

  has_many :provenances

  has_and_belongs_to_many :departments

  has_many :contents, :dependent => :destroy
  accepts_nested_attributes_for :contents, :allow_destroy => true

  has_many :people_roles #, :dependent => :destroy
  has_many :roles, :through => :people_roles
  has_many :people, :through => :people_roles

  validates_presence_of :abstract, :availability_id, :bound, :copyright_statement_id, :degree_id,
                        :document_type_id, :title, :privacy_statement_id, :url, :urn
  validates_uniqueness_of :urn

  def self.find_etds_for_browsing_by_author(letter)
    @person = Person.find(:all, :conditions => "role='author' and last_name like '#{letter}%'", :order => 'first_name')
    @person.each do |person|
      return person.etds
    end
  end

  def self.find_etds_for_browsing_by_department(letter)
    @etds = Etd.find(:all, :conditions => "department like '#{letter}%'")
  end

  def self.find_etds_for_browsing_by_advisor(letter)
    @person = Person.find(:all, :conditions => "role='committee_chair' and last_name like '#{letter}%'", :order => 'first_name')
    @person.each do |person|
      return person.etds
    end
  end

  def self.find_etds_for_view(id)
    Etd.find(:all, :conditions => "id='#{id}'")
  end

end
