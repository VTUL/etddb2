#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-16-2011
#########################################################
class SearchController < ApplicationController

  def method_missing(title, *args)
    render(:inline => %{
      <h2>Unknown action: %(name) </h2>
      Here are the request parameters:<br/>
      <%= debug(params) %> })
  end

  def search_by_title
    @etd = Etd.new(params[:etd1])
    @etds = Etd.find(:all, :conditions => "title like '#{@etd.title}%'")
  end

  def search_by_keyword
    @etd = Etd.new(params[:etd1])

    @etds = Etd.find(:all, :conditions => "title like '#{params[:etd2_metadata]}%'")
  end

  def search_by_advisor
    @person = Person.new(params[:person])
    @etds = Person.find(:all, :conditions => "first_name like '#{@person.first_name}%' or last_name like '#{@person.last_name}'")
  end

  def index
  end
end
