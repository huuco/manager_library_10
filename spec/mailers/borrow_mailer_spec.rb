require "rails_helper"

RSpec.describe BorrowMailer, :type => :mailer do
  let(:borrow) {FactoryBot.create :borrow}
  subject {borrow}

  let(:mail) {BorrowMailer.update_borrow_email subject.user, subject }

  describe "update_borrow_email" do
    it "renders the subject" do
      expect(mail.subject).to eq I18n.t("borrow_mailer.update_borrow_email.subject_mail")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq [subject.user.email]
    end

    it "renders the sender email" do
      expect(mail.from).to eq ["tuannguyenk60@gmail.com"]
    end
  end
end
