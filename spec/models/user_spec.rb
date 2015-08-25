  require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like 'exceptional'
  it_behaves_like 'buildable'
  # it_behaves_like 'identification'

  describe "creating a new user" do
    describe "validating the required attributes" do
      context "when is not valid" do
        before { @user = User.new }
        subject { @user }
        it { should validate_presence_of(:name).with_message("não pode ficar em branco") }
        it { should validate_presence_of(:email).with_message("não pode ficar em branco") }
        it { should_not allow_value('not.valid.com').for(:email) }
        it { expect(@user).not_to be_valid }
      end

      context "when is valid" do
        before { @user = User.build(attributes_for(:user)) }
        subject { @user }

        its(:name) { should be_present }
        its(:email) { should be_present }
        its(:email) { should match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) }
        it { should be_valid }
      end
    end
  end
end
