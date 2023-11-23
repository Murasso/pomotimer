class StudyRecordsController < ApplicationController
  def index
    @study_records=StudyRecord.all
  end
  
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
end
