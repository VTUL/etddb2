class DoIt
  @queue = :do_it

  def self.perform()
    puts 'great'
  end
end
