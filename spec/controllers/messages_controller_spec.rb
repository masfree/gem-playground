require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:user) { create(:user) }

  let(:valid_attributes) {
    { text: "Hello" }
  }

  let(:invalid_attributes) {
    { text: "" }
  }

  let(:message_attributes) {
    { user: user, text: "Hello" }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      message = Message.create! message_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      message = Message.create! message_attributes
      get :edit, params: {id: message.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before { sign_in user }

      it "creates a new Message" do
        expect {
          post :create, params: {message: valid_attributes}, session: valid_session
        }.to change(Message, :count).by(1)
      end

      it "redirects to the created message" do 
        post :create, params: {message: valid_attributes}, session: valid_session
        expect(response).to redirect_to(messages_url)
      end
    end

    context "with invalid params" do
      before { sign_in user }
      it "returns a success response" do
        post :create, params: {message: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(messages_url)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:old_attributes) {
        { user: user, text: "Hello" }
      }

      let(:new_attributes) {
        { text: "Hello again" }
      }

      it "updates the requested message" do
        message = Message.create! old_attributes
        put :update, params: {id: message.to_param, message: new_attributes}, session: valid_session
        message.reload
        expect(message.text).to eq("Hello again")
      end

      it "redirects to the message" do
        message = Message.create! old_attributes
        put :update, params: {id: message.to_param, message: new_attributes}, session: valid_session
        expect(response).to redirect_to(messages_url)
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        message = Message.create! message_attributes
        put :update, params: {id: message.to_param, message: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested message" do
      message = Message.create! message_attributes
      expect {
        delete :destroy, params: {id: message.to_param}, session: valid_session
      }.to change(Message, :count).by(-1)
    end

    it "redirects to the messages list" do
      message = Message.create! message_attributes
      delete :destroy, params: {id: message.to_param}, session: valid_session
      expect(response).to redirect_to(messages_url)
    end
  end
end
