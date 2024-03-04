class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer =  @question.answers.build(answer_params.merge(user_id: current_user.id))

    if @answer.save
      redirect_to question_path(@answer.question), notice: 'Answer successfully created'
    else
      render 'questions/show'
    end
  end

  def destroy

    if current_user.author_of?(answer)
      answer.destroy
      flash[:alert] = 'Answer was removed'
    else
      redirect_to question_path(@answer.question)
    end
  end

  private

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
  end

  def answer_params
    params.require(:answer).permit(:body, links_attributes: [:name, :url])
  end

  helper_method :answer
end
