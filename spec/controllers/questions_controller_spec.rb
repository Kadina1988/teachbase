require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3, user: user) }

    before { get :index }
    it 'populates an array of all questions' do

      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question.id } }

    it 'renders show view' do
      expect(response).to render_template :show
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns new link for answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'render new view' do
      expect(response).to render_template :new
    end

    it 'should be Question new @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'should be new question.link' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end
  end

  describe 'GET #edit' do
    before { login(user) }

    before { get :edit, params: { id: question.id } }

    it 'renders show view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attr' do
      it 'saves a new quest in the database' do
        expect{
          post :create, params: { question: attributes_for(:question), user_id: user.id }
        }.to change(Question, :count).to be(1)
      end

      it 'redirect to show view' do
        post :create, params: { question: attributes_for(:question), user_id: user.id }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attr' do
      it 'does not save the question' do
        expect{
          post :create, params: { question: attributes_for(:question, :invalid) }
        }.to_not change(Question, :count)
      end

      it 'render new' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'valid attr' do
      before {
        patch :update, params: { user_id: user.id, id: question.id,
        question: attributes_for(:question) }
      }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question.id, question: { title: 'new', body: 'new'} }
        question.reload

        expect(question.title).to eq('new')
        expect(question.body).to eq('new')
      end

      it 'redirect to updated question' do
        expect(response).to redirect_to question
      end
    end

    context 'invalid attr' do
      it 'does not change question' do
        patch :update, params: {
          user_id: user.id, id: question, question: attributes_for(:question, :invalid)
        }
        question.reload

        expect(question.title).to eq('MyString')
        expect(question.body).to eq('MyText')
      end

      it 'render edit' do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:question) { create(:question, user: user) }

    context 'user own the question' do
      it 'deletes the question' do
        expect {
          delete :destroy, params: { id: question }
        }.to change{ user.questions.count }.by(-1)
      end

      it 'redirect ' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'another user tries to delete question' do
      let(:another_user) { create(:user) }
      before { login(another_user) }
      subject { delete :destroy, params: { id: question.id} }

      it 'should not delete' do
        expect { subject }.to_not change{ user.questions.count}
      end

      it 'should redirect to question page' do
        subject
        expect(response).to redirect_to(question_path(question))
      end
    end
  end
end
