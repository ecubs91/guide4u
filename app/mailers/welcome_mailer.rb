class WelcomeMailer < ActionMailer::Base
  default from: "youngtutors1230@gmail.com"

  def registration_confirmation(user)
    @user = user
  	mail(:to => @user.email, :subject => "Thank you for signing up with Young Tutors")
  end

end
