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

end
