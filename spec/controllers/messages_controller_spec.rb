require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe MessagesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.

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

  describe "GET #show" do
    it "returns a success response" do
      message = Message.create! message_attributes
      get :show, params: {id: message.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
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
        expect(response).to redirect_to(Message.last)
      end
    end

    context "with invalid params" do
      before { sign_in user }
      it "returns a success response" do
        post :create, params: {message: invalid_attributes}, session: valid_session
        expect(response).to be_success
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
        expect(response).to redirect_to(message)
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
