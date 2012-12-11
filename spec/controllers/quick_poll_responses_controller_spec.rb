require 'spec_helper'

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

describe QuickPollResponsesController do

  # This should return the minimal set of attributes required to create a valid
  # QuickPollResponse. As you add validations to QuickPollResponse, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "quick_poll_id" => "1" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuickPollResponsesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all quick_poll_responses as @quick_poll_responses" do
      quick_poll_response = QuickPollResponse.create! valid_attributes
      get :index, {}, valid_session
      assigns(:quick_poll_responses).should eq([quick_poll_response])
    end
  end

  describe "GET show" do
    it "assigns the requested quick_poll_response as @quick_poll_response" do
      quick_poll_response = QuickPollResponse.create! valid_attributes
      get :show, {:id => quick_poll_response.to_param}, valid_session
      assigns(:quick_poll_response).should eq(quick_poll_response)
    end
  end

  describe "GET new" do
    it "assigns a new quick_poll_response as @quick_poll_response" do
      get :new, {}, valid_session
      assigns(:quick_poll_response).should be_a_new(QuickPollResponse)
    end
  end

  describe "GET edit" do
    it "assigns the requested quick_poll_response as @quick_poll_response" do
      quick_poll_response = QuickPollResponse.create! valid_attributes
      get :edit, {:id => quick_poll_response.to_param}, valid_session
      assigns(:quick_poll_response).should eq(quick_poll_response)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new QuickPollResponse" do
        expect {
          post :create, {:quick_poll_response => valid_attributes}, valid_session
        }.to change(QuickPollResponse, :count).by(1)
      end

      it "assigns a newly created quick_poll_response as @quick_poll_response" do
        post :create, {:quick_poll_response => valid_attributes}, valid_session
        assigns(:quick_poll_response).should be_a(QuickPollResponse)
        assigns(:quick_poll_response).should be_persisted
      end

      it "redirects to the created quick_poll_response" do
        post :create, {:quick_poll_response => valid_attributes}, valid_session
        response.should redirect_to(QuickPollResponse.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved quick_poll_response as @quick_poll_response" do
        # Trigger the behavior that occurs when invalid params are submitted
        QuickPollResponse.any_instance.stub(:save).and_return(false)
        post :create, {:quick_poll_response => { "quick_poll_id" => "invalid value" }}, valid_session
        assigns(:quick_poll_response).should be_a_new(QuickPollResponse)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        QuickPollResponse.any_instance.stub(:save).and_return(false)
        post :create, {:quick_poll_response => { "quick_poll_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested quick_poll_response" do
        quick_poll_response = QuickPollResponse.create! valid_attributes
        # Assuming there are no other quick_poll_responses in the database, this
        # specifies that the QuickPollResponse created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        QuickPollResponse.any_instance.should_receive(:update_attributes).with({ "quick_poll_id" => "1" })
        put :update, {:id => quick_poll_response.to_param, :quick_poll_response => { "quick_poll_id" => "1" }}, valid_session
      end

      it "assigns the requested quick_poll_response as @quick_poll_response" do
        quick_poll_response = QuickPollResponse.create! valid_attributes
        put :update, {:id => quick_poll_response.to_param, :quick_poll_response => valid_attributes}, valid_session
        assigns(:quick_poll_response).should eq(quick_poll_response)
      end

      it "redirects to the quick_poll_response" do
        quick_poll_response = QuickPollResponse.create! valid_attributes
        put :update, {:id => quick_poll_response.to_param, :quick_poll_response => valid_attributes}, valid_session
        response.should redirect_to(quick_poll_response)
      end
    end

    describe "with invalid params" do
      it "assigns the quick_poll_response as @quick_poll_response" do
        quick_poll_response = QuickPollResponse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        QuickPollResponse.any_instance.stub(:save).and_return(false)
        put :update, {:id => quick_poll_response.to_param, :quick_poll_response => { "quick_poll_id" => "invalid value" }}, valid_session
        assigns(:quick_poll_response).should eq(quick_poll_response)
      end

      it "re-renders the 'edit' template" do
        quick_poll_response = QuickPollResponse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        QuickPollResponse.any_instance.stub(:save).and_return(false)
        put :update, {:id => quick_poll_response.to_param, :quick_poll_response => { "quick_poll_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested quick_poll_response" do
      quick_poll_response = QuickPollResponse.create! valid_attributes
      expect {
        delete :destroy, {:id => quick_poll_response.to_param}, valid_session
      }.to change(QuickPollResponse, :count).by(-1)
    end

    it "redirects to the quick_poll_responses list" do
      quick_poll_response = QuickPollResponse.create! valid_attributes
      delete :destroy, {:id => quick_poll_response.to_param}, valid_session
      response.should redirect_to(quick_poll_responses_url)
    end
  end

end