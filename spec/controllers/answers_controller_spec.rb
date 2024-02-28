require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'with valid attributes' do
      it 'create answer' do
        expect{
          post :create, params: { answer: attributes_for(:answer), question_id: question.id }
        }.to change(question.answers, :count).to be(1)
      end

      it 'redirect to answer' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'doesnot create answer' do
        expect{
          post :create, params: { answer: attributes_for(:answer, :invalid_ans), question_id: question.id }
        }.to_not change(question.answers, :count)
      end

      it 'render new' do
        post :create, params: { answer: attributes_for(:answer, :invalid_ans), question_id: question.id }
        expect(response).to render_template(:new)
      end
    end
  end
end
