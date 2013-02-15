class DoIt
  @queue = :do_it

  def self.perform()
    puts 'Done.'
  end
end
