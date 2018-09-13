class BorrowMailer < ApplicationMailer
  def update_borrow_email user, borrow
    @user = user
    @borrow = borrow
    mail to: @user.email, subject: t(".subject_mail")
  end

  def return_late_email user, borrow
    @user = user
    @borrow = borrow
    mail to: @user.email, subject: t(".expired_borrow")
  end

  def monthly_report_email
    mail to: "nguyen.anh.tuanc@framgia.com", subject: t(".mothly_report")
  end
end
