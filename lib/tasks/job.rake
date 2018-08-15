namespace :job do
  desc "TODO"
  task mail_notify: :environment do
    DailyWorker.perform_async
  end

  task monthly_report: :environment do
    MonthlyWorker.perform_async
  end
end
