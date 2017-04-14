class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@jungle.com"

  def send_receipt(order)
    body = 'A test email'
    mail(to: order.email, subject: order.id, body: body).deliver
  end

  def send_test_email
    body = 'A test email'
    mail(to: 'borishaw@gmail.com', subject: 'Test email', body: body).deliver
  end
end
