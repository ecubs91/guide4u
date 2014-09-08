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
  
    # agreed tutorships where this user is the tutor
  has_many  :tutorships_as_tutor,
              ->{ Tutorship.accepted },
              class_name: "Tutorship",
  foreign_key: :user_id

  # invites asking this user to be a tutor
  has_many  :pending_invites_to_be_a_tutor,
              ->{ Tutorship.pending_invites_from_student },
              class_name: "Tutorship",
  foreign_key: :user_id

  # rejected invites asking this user to be a tutor
  has_many  :rejected_invites_to_be_a_tutor,
              ->{ Tutorship.rejected_invites_from_student },
              class_name: "Tutorship",
  foreign_key: :user_id


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
