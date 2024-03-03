class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @questions = Question.all
  end

  def show
    @question = Question.with_attached_files.find(params[:id])
    @answer = question.answers.build
  end

  def new
  end

  def edit;end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to question_path(@question), notice: 'Your question successfully created'
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    if current_user.author_of?(question)
      question.destroy
      redirect_to questions_path
      flash[:notice] = 'Question was deleted.'
    else
      redirect_to question_path(question)
      flash[:alert] = 'You are not an author'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question
end
