# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create your first administrator account here:
Person.create(first_name: "Super", last_name: "User", pid: "suser",
  display_name: "Dr. Super T. User III, Esq.", email: "user@example.com",
  password: "123456", password_confirmation: "123456")

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
  Department.create(name: department, retired: false)
end

for department in retired_departments do
  Department.create(name: department, retired: true )
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
  Degree.create(name: degree, retired: false)
end

for degree in retired_degrees do
  Degree.create(name: degree, retired: true)
end

# Add your availabilities here, in [name, description] pairs.
availabilities = [
  ["Unrestricted", "Provide open and immediate access to the ETD."],
  ["Restricted", "Restrict access to the ETD for Virginia Tech only for a period of one year."],
  ["Withheld", "Withold access to the ETD for one year for patent, security, or another reason."],
  ["Mixed", "Release the entire work for Virginia Tech access only, while at the same time releasing parts of the work for worldwide access. Parts of the work may also be completely withheld from access. You will be asked at a later point to specify the availability of each file you submit."]
]

retired_availabilities = [
  ["Available", "Release the entire work immediately for access worldwide."],
  ["Semi-Available", "Release the entire work for Virginia Tech access only."],
  ["Unavailable", "Secure the entire work for patent and/or proprietary purposes for a period of one year. During this period the copyright owner also agrees not to exercise their ownership rights, including public use in works, without prior authorization from Virginia Tech. At the end of the one year period, either they or Virginia Tech may request an automatic extension for one additional year. At the end of the one year secure period, or its extension, if such is requested, the work will be handled under option 1 above, unless we request option 2 or 4 in writing."]
]

for availability in availabilities do
  Availability.create(name: availability[0], description: availability[1], retired: false)
end

for availability in retired_availabilities do
  Availability.create(name: availability[0], description: availability[1], retired: true)
end

#Add your document types here.
doc_types = ["Dissertation", "Master's Thesis", "Major Paper", "Project", "Report", "Technical Report", "Special Report"]

retired_doc_types = ["Postcard"]

for doc_type in doc_types do
  DocumentType.create(name: doc_type, retired: false)
end

for doc_type in retired_doc_types do
  DocumentType.create(name: doc_type, retired: true)
end

# Add your copyright statements here.
copyrights = ["I hereby certify that, if appropriate, I have obtained and submitted with my ETD a written permission statemtn from the owner(s) of each third party copyrighted matter to be included in my thesis or dissertation, allowing distribution as specified above. I certify that the version I submitted is the same as that approved by my advisory committee."]

retired_copyrights = ["I hereby certify that copyright is a good idea, and support it."]

for copyright in copyrights do
  CopyrightStatement.create(statement: copyright, retired: false)
end

for copyright in retired_copyrights do
  CopyrightStatement.create(statement: copyright, retired: true)
end

# Add your privacy statements here.
privacies = ["I hereby grant to Virginia Tech and its agents the non-exclusive license to archive and make accessible, under the conditions specified above, my thesis or dissertation [in whole or in part in all forms of media], now or hereafter known. I retain all ownership rights to the copyright of the thesis or dissertation. I also retain the right to use in future works (such as articles or books) all or part of this thesis or dissertation."]

retired_privacies = ["I hereby certify that some people may show my work to other people."]

for privacy in privacies do
  PrivacyStatement.create(statement: privacy, retired: false)
end

for privacy in retired_privacies do
  PrivacyStatement.create(statement: privacy, retired: true)
end

#! Beyond this point, you should not need to edit this file.

roles = [
  ["Author", "Creators"],
  ["Committee Member", "Collaborators"],
  ["Committee Co-Chair", "Collaborators"],
  ["Committee Chair", "Collaborators"],
  ["Reviewer", "Graduate School"],
  ["Admin", "Administration"]
]

for role in roles do
  Role.create(name: role[0], group: role[1])
end

digital_objects = ["Etd", "Content", "Role", "Department", "Degree",
  "Availability", "CopyrightStatement", "PrivacyStatement", "Provenance"]

for object in digital_objects do
  DigitalObject.create(name: object)
end

user_actions = ["Create", "Read", "Update", "Delete"]
for action in user_actions do
  UserAction.create(name: action)
end

# Give Admin all permissions.
for action in UserAction.select(:id)
  for object in DigitalObject.select(:id)
    Permission.create(user_action: action, digital_object: object, role_id: Role.where(group: "Administration").first)
  end
end

# Make the super user an admin.
PeopleRole.create(person: Person.first, role: Role.where(group: "Administration").first)

#################################################
# TODO: Put in an external file.
# These are just for ease of use in development.

# Create an ETD for the super user.
Etd.create(title: "Test", abstract: "This is an abstract for an ETD.", availability: Availability.first, copyright_statement: CopyrightStatement.first, degree: Degree.first, document_type: DocumentType.first, privacy_statement: PrivacyStatement.first, bound: false, urn: "etd-20120101-00000001", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000001/", status: "Created")
Etd.first.departments = [Department.first, Department.last]
PeopleRole.create(person: Person.first, etd: Etd.first, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.first, action: "created", model: Etd.first)
Content.create(etd: Etd.first, availability: Availability.first, content: File.new('app/models/degree.rb'), bound: false, page_count: 0)
Provenance.create(person: Person.first, action: "created", model: Content.first)
Content.create(etd: Etd.first, availability: Availability.first, content: File.new('app/models/etd.rb'), bound: false, duration: 0)
Provenance.create(person: Person.first, action: "created", model: Content.last)

# Add Sung Hee to People, give him an ETD.
Person.create(first_name: "Sung Hee", last_name: "Park", pid: "shpark", email: "shpark@vt.edu", password: "123456789", password_confirmation: "123456789")
Etd.create(title: "Tesst", abstract: "This is another abstract.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000002", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000002/", status: "Created")
Etd.last.departments << Department.where(name: "Computer Science").first
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

# Add Kimberli to People, add her and Sung Hee to SU's ETD.
Person.create(first_name: "Kimberli", last_name: "Weeks", pid: "kdweeks", email: "kdweeks@vt.edu", password: "123456789", password_confirmation: "123456789")
PeopleRole.create(person: Person.last, etd: Etd.first, role: Role.where(group: "Collaborators").last)
Provenance.create(person: Person.first, action: "added to their committee.", model: PeopleRole.last)
PeopleRole.create(person: Person.where(pid: 'shpark').first, etd: Etd.first, role: Role.where(group: "Collaborators").first)
Provenance.create(person: Person.first, action: "added to their committee.", model: PeopleRole.last)

# Submit SU's ETD. Sung Hee Approves.
Etd.first.update_attributes(status: 'Submitted', submission_date: Time.now)
Provenance.create(person: Person.where(pid: 'suser').first, action: "submitted", model: Etd.first)
pr = PeopleRole.last
pr.vote = true
pr.save

# Make Kimberli a reviewer.
PeopleRole.create(person: Person.last, etd: Etd.first, role: Role.where(group: "Graduate School").first)
Provenance.create(person: Person.first, action: "made #{Person.last.name} a #{Role.where(group: "Graduate School").first.name}. See ", model: PeopleRole.last)

# Add nine more ETDs and eight more People, so their index pages will paginate.
Etd.create(title: "zLast", abstract: "This is another abstract.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000003", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000003/", status: "Created")
Etd.last.departments << Department.last
PeopleRole.create(person: Person.where(pid: 'suser').first, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.where(pid: 'suser').first, action: "created", model: Etd.last)

Person.create(first_name: "John", last_name: "Muir", pid: "trailhead", email: "trailhead@vt.edu", password: "123456", password_confirmation: "123456", show_email: false)
Etd.create(title: "The Origin of Yosemite's Valleys", abstract: "It's glaciers!", availability: Availability.first, copyright_statement: CopyrightStatement.last, degree: Degree.first, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000004", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000004/", status: "Created")
Etd.last.departments << Department.first
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)
Content.create(etd: Etd.last, availability: Availability.first, content: File.new('Gemfile'), bound: false)
Provenance.create(person: Person.last, action: "created", model: Content.last)
PeopleRole.create(person: Person.first, etd: Etd.last, role: Role.where(group: "Collaborators").first)
Provenance.create(person: Person.last, action: "added to their committee.", model: PeopleRole.last)
Etd.last.update_attributes(status: 'Submitted', submission_date: Time.now())
Provenance.create(person: Person.last, action: "submitted", model: Etd.last)

Person.create(first_name: "Stephen", last_name: "Mahler", pid: "npschief", email: "npschief@vt.edu", password: "123456", password_confirmation: "123456", show_email: false)
Etd.create(title: "A National Park Service", abstract: "Why we need one.", availability: Availability.first, copyright_statement: CopyrightStatement.last, degree: Degree.first, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000005", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000005/", status: "Created")
Etd.last.departments << Department.first
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

Person.create(first_name: "John", last_name: "Rockefeller", pid: "junior", email: "junior@vt.edu", password: "123456", password_confirmation: "123456", display_name: 'John T. Rockefeller, Jr.')
Etd.create(title: "How To Buy Land", abstract: "Two Words: Shell Company.", availability: Availability.first, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000006", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000006/", status: "Created")
Etd.last.departments = [Department.where(name: 'Business Administration').first, Department.first]
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

Person.create(first_name: "James", last_name: "Cameron", pid: "mycanyon", email: "mycanyon@vt.edu", password: "123456", password_confirmation: "123456")
Etd.create(title: "NPS Failures", abstract: "Oh, I guess there aren't any...", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000007", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000007/", status: "Created")
Etd.last.departments << Department.where(name: 'Numerology').first
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

Person.create(first_name: "TJ", last_name: "Rossmeissl", pid: "tallone", email: "tallone@vt.edu", password: "123456", password_confirmation: "123456")
Etd.create(title: "Tallness", abstract: "Is it important? Yes.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000008", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000008/", status: "Created")
Etd.last.departments << Department.where(name: 'Political Science').first
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

Person.create(first_name: "Christie", last_name: "Eickhoff", pid: "kendo", email: "kendo@vt.edu", password: "123456", password_confirmation: "123456")
Etd.create(title: "Kendo!", abstract: "It's great.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000009", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000009/", status: "Created")
Etd.last.departments << Department.where(name: 'Psychology').first
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

Person.create(first_name: "Jane", last_name: "Doe", pid: "jdoe", email: "jdoe@vt.edu", password: "123456", password_confirmation: "123456")
Etd.create(title: "zLast", abstract: "This is another abstract.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000010", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000010/", status: "Created")
Etd.last.departments << Department.last
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

Person.create(first_name: "John", last_name: "Smith", pid: "jsmith", email: "jsmith@vt.edu", password: "123456", password_confirmation: "123456")
Etd.create(title: "zLast", abstract: "This is ')other abstract.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: false, urn: "etd-20120101-00000011", url: "http://scholar.lib.vt.edu/theses/etd-20120101-00000011/", status: "Created")
Etd.last.departments << Department.last
PeopleRole.create(person: Person.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.last, action: "created", model: Etd.last)

# Create a BTD with a LegacyPerson
LegacyPerson.create(first_name: "Collin", last_name: "Brittle")
Provenance.create(person: Person.first, action: "created", model: LegacyPerson.last)
Etd.create(title: "Ye Olde BTD", abstract: "A Paper BTD.", availability: Availability.last, copyright_statement: CopyrightStatement.last, degree: Degree.last, document_type: DocumentType.last, privacy_statement: PrivacyStatement.last, bound: true, urn: "etd-19120101-00000012", url: "http://scholar.lib.vt.edu/theses/etd-19120101-00000012/", status: "Created")
Etd.last.departments << Department.where(name: "Information Technology").first
Provenance.create(person: Person.first, action: "created", model: Etd.last)
PeopleRole.create(person: LegacyPerson.last, etd: Etd.last, role: Role.where(group: "Creators").first)
Provenance.create(person: Person.first, action: "made #{LegacyPerson.last.name} a #{Role.where(group: "Creators").first.name}. See ", model: PeopleRole.last)
Etd.last.update_attributes(status: 'Submitted', submission_date: Time.now())
Provenance.create(person: Person.first, action: "submitted", model: Etd.last)
Etd.last.update_attributes(status: 'Approved', approval_date: Time.now())
Provenance.create(person: Person.first, action: "approved", model: Etd.last)

# Conversations and Messages
c = Conversation.new(subject: 'You Guys', model: Etd.where(title: 'A National Park Service').first)
c.participants << Person.where(last_name: 'Cameron').first
c.participants << Person.where(last_name: 'Mahler').first
c.participants << Person.where(last_name: 'Muir').first
c.save
Provenance.create(person: Person.where(last_name: 'Cameron').first, action: "started a", model: Conversation.last)
Message.create(conversation: c, sender: Person.where(last_name: 'Cameron').first, msg: 'I hate you.')
Provenance.create(person: Person.where(last_name: 'Cameron').first, action: "sent a", model: Message.last)
Message.create(conversation: c, sender: Person.where(last_name: 'Mahler').first, msg: 'Hahahaa, but seriously, get a life.')
Provenance.create(person: Person.where(last_name: 'Mahler').first, action: "sent a", model: Message.last)
Message.create(conversation: c, sender: Person.where(last_name: 'Muir').first, msg: 'So funny.')
Provenance.create(person: Person.where(last_name: 'Muir').first, action: "sent a", model: Message.last)
c.updated_at = Time.now
c.save
c.set_read(Person.where(last_name: 'Mahler').first)
c.set_read(Person.where(last_name: 'Muir').first)

c1 = Conversation.new(subject: 'This Guy', model: Person.where(last_name: 'Cameron').first)
c1.participants << Person.first
c1.participants << Person.where(last_name: 'Weeks').first
c1.save
Provenance.create(person: Person.first, action: "started a", model: Conversation.last)
Message.create(conversation: c1, sender: Person.first, msg: 'He is a problem.')
Provenance.create(person: Person.first, action: "sent a", model: Message.last)
c1.updated_at = Time.now
c1.save

c2 = Conversation.new(subject: 'Hey')
c2.participants << Person.first
c2.participants << Person.where(last_name: 'Park').first
c2.save
Provenance.create(person: Person.first, action: "started a", model: Conversation.last)
Message.create(conversation: c2, sender: Person.first, msg: 'How are you?')
Provenance.create(person: Person.first, action: "sent a", model: Message.last)
c2.set_read(Person.first)
c2.set_archived(Person.first)
c2.updated_at = Time.now
c2.save

Message.create(conversation: c1, sender: Person.first, msg: 'We should do something.')
Provenance.create(person: Person.first, action: "sent a", model: Message.last)
c1.set_read(Person.first)
c1.updated_at = Time.now
c1.save
