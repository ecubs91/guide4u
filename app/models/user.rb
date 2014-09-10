class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  acts_as_messageable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true  

  has_one :tutor_profile, dependent: :destroy
  has_many :enquiries, dependent: :destroy
  has_many :questions
  



  # User can be a student, a tutor or both and can have both the tuition and tutorial request records 
  # foreign key tells Rails to use the tutor_ID to figure out which user was the tutor for this tutorial request
  has_many :tutors, class_name: "Tutorship", foreign_key: "tutor_id"
  has_many :students, class_name: "Tutorship", foreign_key: "student_id"  
  has_many :reviews, dependent: :destroy

  def name
    email
  end

  def mailboxer_email(object)
    email
  end
end
