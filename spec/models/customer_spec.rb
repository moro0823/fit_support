require 'rails_helper'

RSpec.describe Customer, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
	  it "ユーザー名とメールアドレスとパスワードがあれば登録できる" do
      expect(FactoryBot.create(:customer)).to be_valid
    end

	   it "ユーザー名がなければ登録できない" do
      expect(FactoryBot.build(:customer, username: "")).to be_invalid
    end

    it "メールアドレスがなければ登録できない" do
      expect(FactoryBot.build(:customer, email: "")).to be_invalid
    end

    it "メールアドレスが重複していたら登録できない" do
      customer1 = FactoryBot.create(:customer,username: "moro", email: "moro@example.com")
      expect(FactoryBot.build(:customer, username: "morooka", email: customer1.email)).to be_invalid
    end

    it "パスワードが暗号化されているか" do
      customer = FactoryBot.create(:customer)
      expect(customer.encrypted_password).to_not eq "password"
      # encrypted_password => deviseで作成した暗号化されたパスワードを保存するカラム
    end
	 end
	end
