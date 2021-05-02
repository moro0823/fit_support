require 'rails_helper'

RSpec.describe Admin::CustomersController, type: :controller do
  describe "正常なレスポンスか？" do
    before do
      @customer = FactoryBot.create(:customer)
    end

    it "ユーザー一覧の表示" do
      get :index
      expect(response).to be_success
    end

    it "ユーザー詳細（マイページ）の表示" do
      get :show, params: {id: @customer.id}
      expect(response).to be_success
    end
  end
end