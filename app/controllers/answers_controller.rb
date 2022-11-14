class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  expose :question
  expose :answer

  def create
    @answer = question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to question_path(question), notice: 'Your answer was successfully created.'
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user == answer.user
      @question = answer.question
      answer.destroy
      redirect_to @question, notice: 'Your Answer successfully deleted!'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end

