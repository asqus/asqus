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

describe OfficialTenuresController do

  # This should return the minimal set of attributes required to create a valid
  # OfficialTenure. As you add validations to OfficialTenure, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "official_id" => "1" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OfficialTenuresController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all official_tenures as @official_tenures" do
      official_tenure = OfficialTenure.create! valid_attributes
      get :index, {}, valid_session
      assigns(:official_tenures).should eq([official_tenure])
    end
  end

  describe "GET show" do
    it "assigns the requested official_tenure as @official_tenure" do
      official_tenure = OfficialTenure.create! valid_attributes
      get :show, {:id => official_tenure.to_param}, valid_session
      assigns(:official_tenure).should eq(official_tenure)
    end
  end

  describe "GET new" do
    it "assigns a new official_tenure as @official_tenure" do
      get :new, {}, valid_session
      assigns(:official_tenure).should be_a_new(OfficialTenure)
    end
  end

  describe "GET edit" do
    it "assigns the requested official_tenure as @official_tenure" do
      official_tenure = OfficialTenure.create! valid_attributes
      get :edit, {:id => official_tenure.to_param}, valid_session
      assigns(:official_tenure).should eq(official_tenure)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new OfficialTenure" do
        expect {
          post :create, {:official_tenure => valid_attributes}, valid_session
        }.to change(OfficialTenure, :count).by(1)
      end

      it "assigns a newly created official_tenure as @official_tenure" do
        post :create, {:official_tenure => valid_attributes}, valid_session
        assigns(:official_tenure).should be_a(OfficialTenure)
        assigns(:official_tenure).should be_persisted
      end

      it "redirects to the created official_tenure" do
        post :create, {:official_tenure => valid_attributes}, valid_session
        response.should redirect_to(OfficialTenure.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved official_tenure as @official_tenure" do
        # Trigger the behavior that occurs when invalid params are submitted
        OfficialTenure.any_instance.stub(:save).and_return(false)
        post :create, {:official_tenure => { "official_id" => "invalid value" }}, valid_session
        assigns(:official_tenure).should be_a_new(OfficialTenure)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        OfficialTenure.any_instance.stub(:save).and_return(false)
        post :create, {:official_tenure => { "official_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested official_tenure" do
        official_tenure = OfficialTenure.create! valid_attributes
        # Assuming there are no other official_tenures in the database, this
        # specifies that the OfficialTenure created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        OfficialTenure.any_instance.should_receive(:update_attributes).with({ "official_id" => "1" })
        put :update, {:id => official_tenure.to_param, :official_tenure => { "official_id" => "1" }}, valid_session
      end

      it "assigns the requested official_tenure as @official_tenure" do
        official_tenure = OfficialTenure.create! valid_attributes
        put :update, {:id => official_tenure.to_param, :official_tenure => valid_attributes}, valid_session
        assigns(:official_tenure).should eq(official_tenure)
      end

      it "redirects to the official_tenure" do
        official_tenure = OfficialTenure.create! valid_attributes
        put :update, {:id => official_tenure.to_param, :official_tenure => valid_attributes}, valid_session
        response.should redirect_to(official_tenure)
      end
    end

    describe "with invalid params" do
      it "assigns the official_tenure as @official_tenure" do
        official_tenure = OfficialTenure.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OfficialTenure.any_instance.stub(:save).and_return(false)
        put :update, {:id => official_tenure.to_param, :official_tenure => { "official_id" => "invalid value" }}, valid_session
        assigns(:official_tenure).should eq(official_tenure)
      end

      it "re-renders the 'edit' template" do
        official_tenure = OfficialTenure.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OfficialTenure.any_instance.stub(:save).and_return(false)
        put :update, {:id => official_tenure.to_param, :official_tenure => { "official_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested official_tenure" do
      official_tenure = OfficialTenure.create! valid_attributes
      expect {
        delete :destroy, {:id => official_tenure.to_param}, valid_session
      }.to change(OfficialTenure, :count).by(-1)
    end

    it "redirects to the official_tenures list" do
      official_tenure = OfficialTenure.create! valid_attributes
      delete :destroy, {:id => official_tenure.to_param}, valid_session
      response.should redirect_to(official_tenures_url)
    end
  end

end