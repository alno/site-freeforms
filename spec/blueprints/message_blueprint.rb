
Message.blueprint do
  form
  data { [ Faker::Internet.email, Faker::Name.name, Faker::Lorem.sentence, Faker::Lorem.paragraph ] }
  token { Faker::Lorem.sentence }
end
