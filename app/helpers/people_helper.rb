module PeopleHelper
  def get_name(person)
    person.display_name.to_s.empty? ? "#{person.first_name} #{person.last_name}" : "#{person.display_name}"
  end
end
