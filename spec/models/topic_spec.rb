  require 'rails_helper'

RSpec.describe Topic, type: :model do
  it_behaves_like 'buildable'
  it_behaves_like 'exceptional'
  # it_behaves_like 'identification'

  describe "creating a new topic" do
    describe "validating the required attributes" do
      context "when is not valid" do
        before { @user = Topic.new }
        subject { @user }
        it { should validate_presence_of(:subject).with_message("não pode ficar em branco") }
        it { should validate_presence_of(:body).with_message("não pode ficar em branco") }
        it { should validate_presence_of(:user_id).with_message("não pode ficar em branco") }
        it { expect(@user).not_to be_valid }
      end

      context "when is valid" do
        before { @user = Topic.build(attributes_for(:topic)) }
        subject { @user }

        its(:subject) { should be_present }
        its(:body) { should be_present }
        its(:user_id) { should be_present }
        it { should be_valid }
      end
    end
  end
end
