class VerificationMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def verification_code_email
    @user = params[:user]
    @verification_code = params[:verification_code]
    
    mail(
      to: @user.email,
      subject: 'Soon - Email Verification Code'
    )
  end
end 