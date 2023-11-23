class StudyRecordsController < ApplicationController
  before_action :is_matching_login_user, only: [:show]
  
  def new
    @study_record = StudyRecord.new
  end
  
  def create
    @study_record = StudyRecord.new(study_record_params)
    @study_record.user_id = current_user.id
    @study_record.save
    redirect_to study_record_path(current_user.id)
  end
  def show
    @user = User.find(params[:id])
    @study_records=@user.study_records.all
  end
  private

  def study_record_params
    params.require(:study_record).permit(:title, :body, :num_of_session)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to study_record_path(current_user.id)
    end
  end
end
