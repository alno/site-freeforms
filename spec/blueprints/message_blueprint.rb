
Message.blueprint do
  form
  user { form.user }
  data { [ Sham.email, Sham.name, Sham.title, Sham.body ] }
  token
end