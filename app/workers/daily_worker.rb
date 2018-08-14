class DailyWorker
  include Sidekiq::Worker

  def perform
    Borrow.get_by_status(:active).each do |borrow|
      if (borrow.date_borrow + borrow.borrow_days ) < Date.today
        BorrowMailer.return_late_email(borrow.user, borrow).deliver_later
        borrow.update_attributes status: :lated
      end
    end
  end
end
