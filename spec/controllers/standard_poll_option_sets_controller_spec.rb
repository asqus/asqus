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

describe StandardPollOptionSetsController do

  # This should return the minimal set of attributes required to create a valid
  # StandardPollOptionSet. As you add validations to StandardPollOptionSet, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StandardPollOptionSetsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all standard_poll_option_sets as @standard_poll_option_sets" do
      standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
      get :index, {}, valid_session
      assigns(:standard_poll_option_sets).should eq([standard_poll_option_set])
    end
  end

  describe "GET show" do
    it "assigns the requested standard_poll_option_set as @standard_poll_option_set" do
      standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
      get :show, {:id => standard_poll_option_set.to_param}, valid_session
      assigns(:standard_poll_option_set).should eq(standard_poll_option_set)
    end
  end

  describe "GET new" do
    it "assigns a new standard_poll_option_set as @standard_poll_option_set" do
      get :new, {}, valid_session
      assigns(:standard_poll_option_set).should be_a_new(StandardPollOptionSet)
    end
  end

  describe "GET edit" do
    it "assigns the requested standard_poll_option_set as @standard_poll_option_set" do
      standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
      get :edit, {:id => standard_poll_option_set.to_param}, valid_session
      assigns(:standard_poll_option_set).should eq(standard_poll_option_set)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new StandardPollOptionSet" do
        expect {
          post :create, {:standard_poll_option_set => valid_attributes}, valid_session
        }.to change(StandardPollOptionSet, :count).by(1)
      end

      it "assigns a newly created standard_poll_option_set as @standard_poll_option_set" do
        post :create, {:standard_poll_option_set => valid_attributes}, valid_session
        assigns(:standard_poll_option_set).should be_a(StandardPollOptionSet)
        assigns(:standard_poll_option_set).should be_persisted
      end

      it "redirects to the created standard_poll_option_set" do
        post :create, {:standard_poll_option_set => valid_attributes}, valid_session
        response.should redirect_to(StandardPollOptionSet.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved standard_poll_option_set as @standard_poll_option_set" do
        # Trigger the behavior that occurs when invalid params are submitted
        StandardPollOptionSet.any_instance.stub(:save).and_return(false)
        post :create, {:standard_poll_option_set => { "name" => "invalid value" }}, valid_session
        assigns(:standard_poll_option_set).should be_a_new(StandardPollOptionSet)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        StandardPollOptionSet.any_instance.stub(:save).and_return(false)
        post :create, {:standard_poll_option_set => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested standard_poll_option_set" do
        standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
        # Assuming there are no other standard_poll_option_sets in the database, this
        # specifies that the StandardPollOptionSet created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        StandardPollOptionSet.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => standard_poll_option_set.to_param, :standard_poll_option_set => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested standard_poll_option_set as @standard_poll_option_set" do
        standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
        put :update, {:id => standard_poll_option_set.to_param, :standard_poll_option_set => valid_attributes}, valid_session
        assigns(:standard_poll_option_set).should eq(standard_poll_option_set)
      end

      it "redirects to the standard_poll_option_set" do
        standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
        put :update, {:id => standard_poll_option_set.to_param, :standard_poll_option_set => valid_attributes}, valid_session
        response.should redirect_to(standard_poll_option_set)
      end
    end

    describe "with invalid params" do
      it "assigns the standard_poll_option_set as @standard_poll_option_set" do
        standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StandardPollOptionSet.any_instance.stub(:save).and_return(false)
        put :update, {:id => standard_poll_option_set.to_param, :standard_poll_option_set => { "name" => "invalid value" }}, valid_session
        assigns(:standard_poll_option_set).should eq(standard_poll_option_set)
      end

      it "re-renders the 'edit' template" do
        standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StandardPollOptionSet.any_instance.stub(:save).and_return(false)
        put :update, {:id => standard_poll_option_set.to_param, :standard_poll_option_set => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested standard_poll_option_set" do
      standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
      expect {
        delete :destroy, {:id => standard_poll_option_set.to_param}, valid_session
      }.to change(StandardPollOptionSet, :count).by(-1)
    end

    it "redirects to the standard_poll_option_sets list" do
      standard_poll_option_set = StandardPollOptionSet.create! valid_attributes
      delete :destroy, {:id => standard_poll_option_set.to_param}, valid_session
      response.should redirect_to(standard_poll_option_sets_url)
    end
  end

end
