
Message.blueprint do
  sender_name { Sham.name }
  sender_email { Sham.email }
  form { Form.make }
  user { form.user }
  data { [ Sham.title, Sham.body ] }
  token
end