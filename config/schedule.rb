set :environment, "development"
set :output, ".../log.log"

every "0 0 1 * *"  do
  rake "job:mail_notify"
end

every :day, at: "00:00" do
  rake "job:monthly_report"
end
