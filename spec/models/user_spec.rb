require 'rails_helper'

describe User do
  describe 'validation' do
    before :each do
      expect(subject).to be_invalid
    end

    it 'needs a first_name' do
      expect(subject.errors[:first_name]).to include("can't be blank")
    end

    it 'needs a screen_name' do
      expect(subject.errors[:screen_name]).to include("can't be blank")
    end

    it 'needs a unique screen_name' do
      Fabricate(:user, screen_name: 'bobby')
      subject.screen_name = 'bobby'
      subject.valid?
      expect(subject.errors[:screen_name]).to include("has already been taken")
    end

    it 'needs an email' do
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it 'needs a unique email' do
      Fabricate(:user, email: 'bobby@example.com')
      subject.email = 'bobby@example.com'
      subject.valid?
      expect(subject.errors[:email]).to include("has already been taken")
    end

    it 'downcases the email before validating' do
      subject.email = 'Bobby@example.com'
      subject.valid?
      expect(subject.email).to eql('bobby@example.com')
    end

    context 'needs a valid email' do
      let(:user) { Fabricate.build(:user) }

      it "needs an @" do
        user.email = 'bobby'
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("is invalid")
      end

      it "needs a domain" do
        user.email = 'bobby@'
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("is invalid")
      end

      it "needs a TLD" do
        user.email = 'bobby@example'
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("is invalid")
      end

      it "is valid with valid email address" do
        user.email = 'bobby@example.com'
        expect(user).to be_valid
      end
    end

    context "if password has not yet been set" do
      context "and password has not been given" do
        it 'must have at least 3 characters' do
          subject.password = ''
          subject.valid?
          expect(subject.errors[:password]).to include("is too short (minimum is 3 characters)")
        end
      end

      context "and password has been given" do
        it 'must have at least 3 characters' do
          subject.password = 'oo'
          subject.valid?
          expect(subject.errors[:password]).to include("is too short (minimum is 3 characters)")
        end

        it 'must match confirmation' do
          user = User.new(password: 'foo', password_confirmation: 'bar')
          user.valid?
          expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        end
      end
    end

    context "if password has been set" do
      let(:user) { Fabricate(:user) }

      context "and password has been changed" do
        it 'must have at least 3 characters' do
          user.password = 'oo'
          user.valid?
          expect(user.errors[:password]).to include("is too short (minimum is 3 characters)")
        end

        it 'must match confirmation' do
          user.password = 'foo'
          user.password_confirmation = 'bar'
          user.valid?
          expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        end
      end

      context "and password has not been changed" do
        let(:user) { Fabricate(:user) }

        it 'does not check password length' do
          user.valid?
          expect(user.errors[:password]).to be_empty
        end

        it 'does not check password confirmation' do
          user.valid?
          expect(user.errors[:password_confirmation]).to be_empty
        end
      end
    end
  end

  describe 'activation' do
    context 'when a new user is created' do
      let(:stub_mailer) { double('mailer', deliver: true) }

      before :each do
        allow(AuthenticationMailer).to receive(:activation_needed_email).and_return(stub_mailer)
        @user = Fabricate(:user)
      end

      it 'has an activation state of "pending"' do
        expect(@user.activation_state).to eql('pending')
      end

      it 'builds an activation needed email' do
        expect(AuthenticationMailer).to have_received(:activation_needed_email)
      end

      it 'sends the activation needed email' do
        expect(stub_mailer).to have_received(:deliver)
      end
    end

    context 'when an existing user changes their email' do
      let(:stub_mailer) { double('mailer', deliver: true) }

      before :each do
        @user = Fabricate(:active_user)
        allow(AuthenticationMailer).to receive(:activation_needed_email).and_return(stub_mailer)
        @user.update_attribute(:email, 'mary@example.com')
      end

      it 'changes the activation state to "pending"' do
        expect(@user.activation_state).to eql('pending')
      end

      it 'builds an activation needed email' do
        expect(AuthenticationMailer).to have_received(:activation_needed_email)
      end

      it 'sends the activation needed email' do
        expect(stub_mailer).to have_received(:deliver)
      end
    end

    context 'when an existing user changes something other than their email' do
      let(:stub_mailer) { double('mailer', deliver: true) }

      before :each do
        @user = Fabricate(:active_user)
        allow(AuthenticationMailer).to receive(:activation_needed_email).and_return(stub_mailer)
        @user.update_attribute(:first_name, 'mary')
      end

      it 'does not change the activation state to "pending"' do
        expect(@user.activation_state).not_to eql('pending')
      end

      it 'does not build an activation needed email' do
        expect(AuthenticationMailer).not_to have_received(:activation_needed_email)
      end

      it 'does not send the activation needed email' do
        expect(stub_mailer).not_to have_received(:deliver)
      end
    end
  end

  describe 'find_by_email' do
    let!(:user) { Fabricate(:user, email: 'bobby@example.com') }

    it 'provides the user if a lower case email is given' do
      email = 'bobby@example.com'
      expect(User.find_by_email(email)).to eql(user)
    end

    it 'provides the user if a capitalised email is given' do
      email = 'Bobby@example.com'
      expect(User.find_by_email(email)).to eql(user)
    end

    it 'provides the user if an upper case email is given' do
      email = 'BOBBY@EXAMPLE.COM'
      expect(User.find_by_email(email)).to eql(user)
    end

    it 'does not provide the user if an incorrect email is given' do
      email = 'mary@example.com'
      expect(User.find_by_email(email)).to be_nil
    end

    it 'does not provide the user if no email is given' do
      email = ''
      expect(User.find_by_email(email)).to be_nil
    end
  end
end
