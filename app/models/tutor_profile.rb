class TutorProfile < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "default.jpg", 
  					:storage => :dropbox,
   					:dropbox_credentials => Rails.root.join("config/dropbox.yml")
  validates :university, presence: true 
  validates :terms_of_service, acceptance: true

  belongs_to :user, dependent: :delete
  has_many :tutorships
  has_many :reviews
  
      # agreed tutorships where this user is the tutor
  has_many  :tutorships_as_tutor,
              ->{ Tutorship.accepted },
              class_name: "Tutorship",
  foreign_key: :tutor_profile_id

  # invites asking this user to be a tutor
  has_many  :pending_invites_to_be_a_tutor,
              ->{ Tutorship.pending_invites_from_student },
              class_name: "Tutorship",
  foreign_key: :tutor_profile_id

  # rejected invites asking this user to be a tutor
  has_many  :rejected_invites_to_be_a_tutor,
              ->{ Tutorship.rejected_invites_from_student },
              class_name: "Tutorship",
  foreign_key: :tutor_profile_id
end
