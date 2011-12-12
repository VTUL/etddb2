#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Etd < ActiveRecord::Base
 # belongs_to :author, :class => "Person", :foreign_key => "written_by"
  has_many :contents, :dependent => :destroy
  has_many :keywords
  has_many :provenances

  accepts_nested_attributes_for :contents, :allow_destroy => true

# attr_accessible :contents_attributes
#, :availability, :title, :pid, :degree, :dtype, :department,
#                  :timestamp

#  has_one  :availability_description
#  has_one  :copyright_statement
#  has_one  :degree_description
#  has_one  :doctype_description
#  has_one  :department_list
#  has_one  :urn_register

#  has_and_belongs_to_many :people

#  has_and_belongs_to_many :people_roles
  has_many :people_roles
  has_many :roles, :through => :people_roles
  has_many :people, :through => :people_roles




#  belongs_to  :committee_chair, :class => "Person", :foreign_key => "advisor"
#  belongs_to  :committee_cochair, :class => "Person", :foreign_key => "coadvisor"
#  has_and_belongs_to_many :committee_members, :class => "Person", :foreign_key => "member"
  validates :abstract, :availability, :bound, :degree, :department, :dtype,  :title, :url, :urn, :presence => true
            #:adate, :cdate, :ddate, :rdate, :sdate,
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
