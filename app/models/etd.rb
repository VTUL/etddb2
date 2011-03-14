#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Etd < ActiveRecord::Base
 # belongs_to :author, :class => "Person", :foreign_key => "written_by"
  has_many :contents
  has_many :keywords
  has_many :provenances

#  has_one  :availability_description
#  has_one  :copyright_statement
#  has_one  :degree_description
#  has_one  :doctype_description
#  has_one  :department_list
#  has_one  :urn_register
  
  has_and_belongs_to_many :people
  
#  belongs_to  :committee_chair, :class => "Person", :foreign_key => "advisor" 
#  belongs_to  :committee_cochair, :class => "Person", :foreign_key => "coadvisor"
#  has_and_belongs_to_many :committee_members, :class => "Person", :foreign_key => "member"
  validates_presence_of :title, :abstract, :degree, :department, :dtype, :availability_description,
                        :availability, :bound, :url #, :urn
#  validates_uniqueness_of #:urn

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
