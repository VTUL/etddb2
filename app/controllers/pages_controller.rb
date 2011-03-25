class PagesController < ApplicationController
  def home
	@title = "Home"
  end

  def about
	@title = "About"
  end

  def contact
	@title = "Contact"
  end

  def help
	@title = "Author Help"
  end

  def dev
	@title = "Development"
  end

end
