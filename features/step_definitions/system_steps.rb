
When /^jobs are processed$/ do
  Delayed::Job.all.each do |job|
    job.payload_object.perform
    job.destroy
  end
end
