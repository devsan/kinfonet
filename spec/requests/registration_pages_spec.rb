require 'spec_helper'

describe "RegistrationPages" do
  subject { page }

  describe "signup page" do
    before { visit sign_up_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

end
