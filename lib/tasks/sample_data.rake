namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    make_quotes
  end
end

def make_users
  admin = User.create!( fname: "Dev",
                        lname: "Singh",
                        email: "dev@madebydna.com",
                        password: "password",
                        admin: true)
  20.times do |n|
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    email = "keanu-#{n+1}@kinfonet.org"
    password  = "password"
    User.create!( fname:    fname,
                  lname:    last_name,
                  email:    email,
                  password: password)
  end 

end
def make_quotes
  99.times do |n|
    phrase = Faker::Lorem.sentence(rand(2..20))
    content = Faker::Lorem.paragraphs(rand(2..8)).join('<br><br>')
    source_location = Faker::Address.city + ", " + Faker::Address.country
    source_detail =   (30..80).to_a.sample.years.ago.strftime("%B %-d, %Y")
    Quote.create!(phrase: phrase,
                  content: content,
                  source_location: source_location,
                  source_detail: source_detail)
  end
end



