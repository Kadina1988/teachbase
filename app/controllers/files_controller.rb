class FilesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    file = ActiveStorage::Attachment.find(params[:id])
    file.purge if current_user.author_of?(file.record)
    redirect_to question_path(file.record)
  end
end
