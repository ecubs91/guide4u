ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.etsydemo-2016.herokuapp.com",
:port => 587,
:domain => "etsydemo-2016.herokuapp.com",
:user_name => "youngtutors12300@gmail.com",
:password => "14l7ee95h1an",
:authentication => "plain",
:enable_starttls_auto => true
}