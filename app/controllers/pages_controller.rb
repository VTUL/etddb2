class PagesController < ApplicationController
  skip_before_filter :authenticate_person!

  def home
  @title = "Home"
  end

  def about
  @title = "About"
  end

  def contact
  @title = "Contact"
  end

  def authorhelp
  @title = "Author Help"
  end

  def staffhelp
  @title = "Staff Help"
  end

  def dev
  @title = "Development"
  end

  def survey_return
    @etd = Etd.find(cookies.signed[:etd])
    Redis.current.setbit("created:#{@etd.id}", 2, 1)
    cookies.delete(:etd)
  end
end
