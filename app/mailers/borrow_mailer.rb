class BorrowMailer < ApplicationMailer
  default from: "tuannguyenk60@gmail.com"

  def update_borrow_email user, borrow
    @user = user
    @borrow = borrow
    mail to: @user.email, subject: t(".subject_mail")
  end
end
