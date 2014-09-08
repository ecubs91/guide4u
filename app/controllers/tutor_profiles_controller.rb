class TutorProfilesController < ApplicationController
  autocomplete :tutor_profile, :teaching_subject
  before_action :set_tutor_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /tutor_profiles
  # GET /tutor_profiles.json
  def search
      @filters = params.slice(:university)

      if params[:search].present?
       
        @tutor_profiles = TutorProfile.where("teaching_subject LIKE :teaching_subject or degree_subject LIKE :teaching_subject",  {teaching_subject: "%#{params[:search]}%"}).where(@filters)
      else
    @tutor_profiles = TutorProfile.where(@filters).paginate(:page => params[:page], :per_page => 10)
      end
  end
  
  def autocomplete
    render json: TutorProfile.where("teaching_subject LIKE :teaching_subject",  {teaching_subject: "%#{params[:search]}%"}).where(@filters)
  end

  def index
    @tutor_profiles = TutorProfile.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /tutor_profiles/1
  # GET /tutor_profiles/1.json
  def show
    @reviews = Review.where(tutor_profile_id: @tutor_profile.id).order("created_at DESC")
    if @reviews.blank?
      avg_rating = 0 
    else
      @avg_rating = @reviews.average(:rating).round(2) 
    end
  end

  # GET /tutor_profiles/new
  def new
    @tutor_profile = TutorProfile.new
  end

  # GET /tutor_profiles/1/edit
  def edit
  end

  # POST /tutor_profiles
  # POST /tutor_profiles.json
  def create
    @tutor_profile = TutorProfile.new(tutor_profile_params)
    @tutor_profile.user_id = current_user.id

    respond_to do |format|
      if @tutor_profile.save
        format.html { redirect_to @tutor_profile, notice: 'Tutor profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tutor_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @tutor_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutor_profiles/1
  # PATCH/PUT /tutor_profiles/1.json
  def update
    respond_to do |format|
      if @tutor_profile.update(tutor_profile_params)
        format.html { redirect_to @tutor_profile, notice: 'Tutor profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tutor_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutor_profiles/1
  # DELETE /tutor_profiles/1.json
  def destroy
    @tutor_profile.destroy
    respond_to do |format|
      format.html { redirect_to tutor_profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor_profile
      @tutor_profile = TutorProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_profile_params
      params.require(:tutor_profile).permit(:user_id, :university, :degree_subject, :teaching_subject, :location, :about_myself, :tutoring_approach, :teaching_experience, :extracurricular_interests, :image, :tutor_profile_id)
    end
  
    def check_user
      if current_user != @tutor_profile.user
        redirect_to root_url, alert: "Sorry this profile belongs to someone else"
      end
    end
end
