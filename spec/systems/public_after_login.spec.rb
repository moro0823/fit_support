require 'rails_helper'

RSpec.describe Admin::CustomersController, type: :controller do

  describe 'ユーザログイン後のテスト' do
    let(:customer) { create(:customer) }
    let!(:other_customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end
  
  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※ログアウトは『ユーザログアウトのテスト』でテスト済み' do
      subject { current_path }

      it 'Toppageを押すと、トップページに遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it 'マイページを押すと、マイページに遷移する' do
        mypage_link = find_all('a')[2].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/customers/' + customer.id.to_s
      end
      it '投稿一覧を押すと、投稿一覧に遷移する' do
      end
      
      it '投稿を作成を押すと、新規投稿画面に遷移する' do
      end
    end
  end
    
  end # ログインしている状態
end