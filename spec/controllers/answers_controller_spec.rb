require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      subject { post :create, params: { answer: attributes_for(:answer), question_id: question.id } }

      it 'create answer' do
        expect{ subject }.to change(Answer, :count).to be(1)
      end

      it 'redirect to answer' do
        subject
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      subject { post :create, params: { answer: attributes_for(:answer, :invalid_ans), question_id: question.id } }

      it 'doesnot create answer' do
        expect{ subject }.to_not change(question.answers, :count)
      end

      it 'should not save answer' do
        subject
        expect(response).to render_template('questions/show')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, user: user, question: question) }
    subject { delete :destroy, params: { id: answer.id } }

    context 'when author tries delete his answer' do
      it 'should delete answer' do
        expect { subject }.to change{ user.answers.count }.by(-1)
      end
    end

    context 'another user tries delete answer' do
      let(:another_user) { create(:user) }

      it 'should not delete answer' do
        login(another_user)
        expect { subject }.to_not change{ user.answers.count }
      end
    end
  end
end
