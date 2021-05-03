require 'rails_helper'

RSpec.describe Admin::CustomersController, type: :controller do

  describe 'ユーザログイン' do
    let(:admin_user) { create(:admin_user) }

    before do
      visit new_admin_user_session_path
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin_user[email]', with: admin_user.email
        fill_in 'admin_user[password]', with: admin_user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が トップページになっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin_user[email]', with: ""
        fill_in 'admin_user[password]', with: ""
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/admin_users/sign_in'
      end
    end
  end


  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:admin_user) { create(:admin_user) }

    before do
      visit new_admin_user_session_path
        fill_in 'admin_user[email]', with: admin_user.email
        fill_in 'admin_user[password]', with: admin_user.password
        click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it '左上から1番目のリンクが「ユーザー一覧」である' do
        customer_index_link = find_all('a')[1].native.inner_text
        expect(customer_index_link).to match("ユーザー一覧")
      end

      it '左上から2番目のリンクが「ユーザー投稿一覧」である' do
        customer_post_link = find_all('a')[2].native.inner_text
        expect(customer_post_link).to match("ユーザー投稿一覧")
      end
      
      it ' 左上から3番目のリンクが「管理者投稿作成」である' do
        admin_post_new_link = find_all('a')[3].native.inner_text
        expect(admin_post_new_link).to match("管理者用投稿作成")
      end
      
      it ' 左上から4番目のリンクが「管理者用投稿一覧」である' do
        admin_post_index_link = find_all('a')[4].native.inner_text
        expect(admin_post_index_link).to match("管理者用投稿一覧")
      end
      
      it ' 左上から5番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match("ログアウト")
      end
    end
  end
end