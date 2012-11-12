class Archive
  @queue = :archive

  def self.perform(etd_id)
    etd = Etd.find(etd_id)
    etd.create_archive()
  end
end
