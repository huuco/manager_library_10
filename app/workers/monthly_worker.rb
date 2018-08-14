class MonthlyWorker
  include Sidekiq::Worker

  def perform
    BorrowMailer.monthly_report_email.deliver_later
  end
end
