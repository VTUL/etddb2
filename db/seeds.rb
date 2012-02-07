# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create your first administrator account here:
Person.create([{ :first_name => "Super", :last_name => "User", :pid => "suser",
                 :email => "user@example.com", :password => "123456", :password_confirmation => "123456" }])

# These are your active departments:
departments = ["Forestry", "English", "Materials Science and Engineering", "Teaching and Learning",
 "Gerontology", "Biochemistry", "International Studies", "Crop and Soil Environmental Sciences",
 "Veterinary Medical Sciences", "Political Science", "Electrical and Computer Engineering",
 "Agricultural and Applied Economics", "Women's Studies", "Environmental Sciences and Engineering",
 "Chemical Engineering", "Near Environments", "Food Science and Technology",
 "Public Administration/Public Affairs", "Molecular Cell Biology and Biotechnology",
 "Hospitality and Tourism Management", "Information Technology", "Environmental Design and Planning",
 "Computer Science", "Human-Computer Interaction", "Wood Science and Forest Products", "Humanities",
 "Biological Systems Engineering", "Mechanical Engineering", "Public and International Affairs",
 "Chemistry", "Genetics", "Management", "Music", "Animal and Poultry Sciences",
 "Educational Leadership and Policy Studies", "Fisheries and Wildlife Sciences",
 "Plant Pathology, Physiology, and Weed Science", "Entomology", "Theatre Arts",
 "Horticulture", "Information Systems", "Statistics", "Civil Engineering",
 "Housing, Interior Design and Resource Management", "Environmental Programs",
 "Industrial and Systems Engineering", "Mining and Minerals Engineering",
 "Foreign Languages and Literatures", "Management Science and Information Technology",
 "Science and Technology Studies", "Biology", "Philosophy", "Accounting and Information Systems",
 "Engineering Science and Mechanics", "Economics", "Plant Physiology", "Systems Engineering",
 "Geosciences", "Mathematical Physics", "Landscape Architecture", "Architecture", "Marketing",
 "Sociology", "Aerospace and Ocean Engineering", "Engineering (General)",
 "Urban Affairs and Planning", "History", "Physics", "International Research And Development",
 "Dairy Science", "Finance, Insurance, and Business Law", "Art and Art History",
 "Communication Studies", "Natural Resources", "Geography", "Macromolecular and Science Engineering",
 "Psychology", "Mathematics", "Environmental Engineering", "Human Development",
 "Human Nutrition, Foods, and Exercise", "Business Administration"]

retired_departments = ["Uncivil Engineering", "Numerology"]

for department in departments do
  Department.create!([{ :name => department, :retired => false }])
end

for department in retired_departments do
  Department.create([{ :name => department, :retired => true }])
end

# Add your degrees here:
degrees = ["PhD", "Master of Science", "Master of Arts", "Master of Fine Arts",
 "Master of Education", "Master of Architecture", "Master of Engineering",
 "Master of Engineering Education", "Master of Forestry", "Master of Information Systems",
 "Master of Landscape Architecture", "Master of Natural Resources",
 "Master of Public and International Affairs", "Master of Science in Life Science",
 "Master of Urban and Regional Planning"]

retired_degrees = ["Master of Plumbing"]

for degree in degrees do
  Degree.create([{ :name => degree, :retired => false }])
end

for degree in retired_degrees do
  Degree.create([{ :name => degree, :retired => true }])
end

# Add your availabilities here, in (name, description) pairs.
availabilities = [
  ["Unrestricted", "Release the entire work immediately for access worldwide."],
  ["Restricted", "Release the entire work for Virginia Tech access only."],
  ["Withheld", "Secure the entire work for patent and/or proprietary purposes for a period of one year. During this period the copyright owner also agrees not to exercise their ownership rights, including public use in works, without prior authorization from Virginia Tech. At the end of the one year period, either they or Virginia Tech may request an automatic extension for one additional year. At the end of the one year secure period, or its extension, if such is requested, the work will be handled under option 1 above, unless we request option 2 or 4 in writing."],
  ["Mixed", "Release the entire work for Virginia Tech access only, while at the same time releasing parts of the work for worldwide access. Parts of the work may also be completely withheld from access. You will be asked at a later point to specify the availability of each file you submit."]
]

retired_availabilities = [
  ["Available", "Release the entire work immediately for access worldwide."]
]

for availability in availabilities do
  Availability.create([{ :name => availability[0], :description => availability[1], :retired => false }])
end

for availability in retired_availabilities do
  Availability.create([{ :name => availability[0], :description => availability[1], :retired => true }])
end

#Add your document types here.
doc_types = ["Dissertation", "Master's Thesis", "Major Paper", "Project", "Report", "Technical Report", "Special Report"]

retired_doc_types = ["Postcard"]

for doc_type in doc_types do
  DocumentType.create([{ :name => doc_type, :retired => false }])
end

for doc_type in retired_doc_types do
  DocumentType.create([{ :name => doc_type, :retired => true }])
end

# Add your copyright statements here.
copyrights = ["Copyright Statement Goes Here."]

retired_copyrights = ["None!"]

for copyright in copyrights do
  CopyrightStatement.create([{ :statement => copyright, :retired => false }])
end

for copyright in retired_copyrights do
  CopyrightStatement.create([{ :statement => copyright, :retired => true }])
end

# Add your privacy statements here.
privacies = ["I hereby grant to Virginia Tech and its agents the non-exclusive license to archive and make accessible, under the conditions specified below, my thesis, dissertation, or project report in whole or in part in all forms of media, now or hereafter known. I retain all other ownership rights to the copyright of the thesis, dissertation, or project report. I also retain the right to use in future works (such as articles or books) all or part of this thesis, dissertation, or project report."]

retired_privacies = ["None!"]

for privacy in privacies do
  PrivacyStatement.create([{ :statement => privacy, :retired => false }])
end

for privacy in retired_privacies do
  PrivacyStatement.create([{ :statement => privacy, :retired => true }])
end

#! Beyond this point, you should not need to edit this file.

roles = ["Author", "Admin", "Committee Chair", "Comittee CoChair", "Comittee Member", "Reviewer"]
for role in roles do
  Role.create([{ :name => role }])
end

digital_objects = ["Etd", "Content", "Role", "Department", "Degree", "Availability",
  "CopyrightStatement", "PrivacyStatement", "Provenance"]
for object in digital_objects do
  DigitalObject.create([{ :name => object }])
end

user_actions = ["Create", "Read", "Update", "Delete"]
for action in user_actions do
  UserAction.create([{ :name => action }])
end

# Give Admin all permissions.
for action in UserAction.select(:id)
  for object in DigitalObject.select(:id)
    Permission.create([{:user_action_id => action.id, :digital_object_id => object.id, :role_id => Role.where(:name => "Admin").first.id}])
  end
end

# Make the super user an admin.
PeopleRole.create([{:person_id => Person.first.id, :role_id => Role.where(:name => "Admin").first.id}])

#! These are just for ease of use for testing
# Create an ETD for the super user.
Etd.create([{:title => "Test", :abstract => "This is an abstract for an ETD.", :availability => Availability.first, :copyright_statement => CopyrightStatement.first, :degree => Degree.first, :document_type => DocumentType.first, :privacy_statement => PrivacyStatement.first, :url => "/", :urn => "0", :bound => false}])
Etd.first.departments = [Department.first, Department.last]
PeopleRole.create([{:person_id => Person.first.id, :etd_id => Etd.first.id, :role_id => Role.where(:name => "Author").first.id}])

# Add Sung Hee to People, give him an ETD.
Person.create([{ :first_name => "Sung Hee", :last_name => "Park", :pid => "shpark", :email => "shpark@vt.edu", :password => "123456789", :password_confirmation => "123456789" }])
Etd.create([{:title => "Tesst", :abstract => "This is another abstract.", :availability => Availability.last, :copyright_statement => CopyrightStatement.last, :degree => Degree.last, :document_type => DocumentType.last, :privacy_statement => PrivacyStatement.last, :url => "/", :urn => "1", :bound => false}])
Etd.last.departments << Department.where(:name => "Computer Science").first
PeopleRole.create([{:person_id => Person.last.id, :etd_id => Etd.last.id, :role_id => Role.where(:name => "Author").first.id}])

# Add Kimberli to People, add her to the SU ETD.
Person.create([{ :first_name => "Kimberli", :last_name => "Weeks", :pid => "kdweeks", :email => "kdweeks@vt.edu", :password => "123456789", :password_confirmation => "123456789" }])
PeopleRole.create([{:person_id => Person.last.id, :etd_id => Etd.first.id, :role_id => Role.where(:name => "Committee Chair").first.id}])
