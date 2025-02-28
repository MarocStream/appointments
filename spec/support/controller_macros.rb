module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryBot.create(:user)
      sign_in @user
    end
  end

  def log_out
    before(:each) do
      sign_out :user
    end
  end
end
