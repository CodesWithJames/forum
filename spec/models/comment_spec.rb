  require 'rails_helper'

RSpec.describe Comment, type: :model do
  it_behaves_like 'buildable'
  it_behaves_like 'exceptional'

  describe "creating a new user" do
    describe "validating the required attributes" do
      context "when is not valid" do
        before { @user = Comment.new }
        subject { @user }
        it { should validate_presence_of(:body).with_message("não pode ficar em branco") }
        it { should validate_presence_of(:user_id).with_message("não pode ficar em branco") }
        it { should validate_presence_of(:topic_id).with_message("não pode ficar em branco") }
        it { expect(@user).not_to be_valid }
      end

      context "when is valid" do
        before { @user = Comment.build(attributes_for(:comment)) }
        subject { @user }

        its(:body) { should be_present }
        its(:user_id) { should be_present }
        its(:topic_id) { should be_present }
        it { should be_valid }
      end
    end
  end
end
