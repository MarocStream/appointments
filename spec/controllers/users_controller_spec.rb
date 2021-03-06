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

describe UsersController do

  login_user

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET index" do
    it "disallows non-admins" do
      get :index
      response.should_not be_ok
    end
    context "admins" do
      login_admin
      it "assigns users to @users" do
        get :index
        assigns(:users).size.should == 2
        response.should be_ok
      end
    end
  end

  describe "GET show" do
    it "disallows non-admins" do
      get :show, {:id => subject.current_user.to_param}
      response.should_not be_ok
    end
    context "admins" do
      login_admin
      it "assigns the requested user as @user" do
        get :show, {:id => subject.current_user.to_param}
        assigns(:user).should eq(subject.current_user)
      end
    end
  end

  describe "GET profile" do
    context "anonymous users" do
      log_out
      it "requires login" do
        get :profile
        response.should_not be_ok
      end
    end
    it "allows non-admins" do
      get :profile
      assigns(:user).should eq(subject.current_user)
    end
    context "admins" do
      login_admin
      it "assigns the requested user as @user" do
        get :profile
        assigns(:user).should eq(subject.current_user)
      end
    end
  end

  describe "PUT update" do
    it "disallows non-admins" do
      put :update, {:id => User.first.to_param, :user => {"first" => "name"}}
      response.should_not be_ok
    end
    context "admins" do
      login_admin
      describe "with valid params" do
        let(:user_attributes) { { 'email' => 'updated@example.com' } }

        it "updates the requested user" do
          user = create(:user)
          # Assuming there are no other users in the database, this
          # specifies that the User created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          User.any_instance.should_receive(:update_without_password).with(user_attributes).and_return(true)
          put :update, {:id => user.to_param, :user => user_attributes}
          response.should redirect_to(admin_user_url(user))
        end

        it "assigns the requested user as @user" do
          user = create(:user)
          put :update, {:id => user.to_param, :user => user_attributes}
          assigns(:user).should eq(user)
        end

        it "redirects to the user" do
          user = create(:user)
          put :update, {:id => user.to_param, :user => user_attributes}
          response.should redirect_to(admin_user_path(user))
        end
      end

      describe "with invalid params" do
        let(:user_attributes) { { 'email' => User.first.email } }

        it "assigns the user as @user" do
          user = create(:user)
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => user.to_param, :user => user_attributes}
          assigns(:user).should eq(user)
        end
      end
    end
  end

  describe "DELETE destroy" do
    it 'disallows non-admins' do
      delete :destroy, {:id => User.first}
      response.should_not be_ok
    end

    context "admins" do
      login_admin
      it "destroys the requested user" do
        user = create(:user)
        expect {
          delete :destroy, {:id => user.to_param}
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = create(:user)
        delete :destroy, {:id => user.to_param}
        response.should redirect_to(admin_users_url)
      end
    end
  end

end
