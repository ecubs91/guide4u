class Enquiry < ActiveRecord::Base
	validates :subject, :level, presence: true

  belongs_to :user
  
 # after_create :send_message
  
  def send_message(user_id)
    subject = self.subject
    level = self.level
    location = self.location
    tuition_fee = self.tuition_fee
    note = self.note
    name = self.user.name
    
  # message = 'Enquiry for: "#{subjrails s =ect}", "#{level}", "#{location}", "#{tuition_fee}", "#{note}" '
    message  = subject , level, location
    # self.user.send_message(user_id,  message  , 'hi')
  end 
	
end
