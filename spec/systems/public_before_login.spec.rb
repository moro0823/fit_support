require 'rails_helper'

RSpec.describe Public::CustomersController, type: :controller do

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end

      it 'アカウント作成済みの方はこちらの内容が正しい' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(page).to have_link log_in_link, href: new_customer_session_path
      end

      it 'アカウント作成のリンクの内容が正しい' do
        sign_up_link = find_all('a')[3]
        expect(page).to have_link sign_up_link.native.inner_text, href: new_customer_registration_path
      end
    end
  end

  describe 'アプリ紹介画面のテスト' do
    before do
      visit '/home/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/home/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do

    before do
      visit root_path
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'アプリ紹介を押すとaboutページにリンクする' do
        about_link = find_all('a')[1].native.inner_text
        click_link about_link
        is_expected.to eq '/home/about'
      end

      it '投稿を見てみるを押すと、投稿一覧に遷移する' do
      end

      it 'アカウント作成を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[3].native.inner_text
        click_link signup_link
        is_expected.to eq '/customers/sign_up'
      end

      it 'アカウント作成済みの方はこちらを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4].native.inner_text
        click_link login_link
        is_expected.to eq '/customers/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[username]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'アカウント作成' }.to change(Customer.all, :count).by(1)
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザのマイページになっている' do
        click_button 'アカウント作成'
        expect(current_path).to eq '/customers/' + Customer.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ""
        fill_in 'customer[password]', with: ""
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it '左上から1番目のリンクが「TopPage」である' do
        top_link = find_all('a')[1].native.inner_text
        expect(top_link).to match("TopPage")
      end

      it '左上から2番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[2].native.inner_text
        expect(mypage_link).to match("マイページ")
      end

      it '左上から3番目のリンクが「投稿一覧」である' do
        posts_link = find_all('a')[3].native.inner_text
        expect(posts_link).to match("投稿一覧")
      end

      it '左上から4番目のリンクが「投稿を作成」である' do
        post_new_link = find_all('a')[4].native.inner_text
        expect(post_new_link).to match("投稿を作成")
      end

      it '左上から5番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match("ログアウト")
      end
    end
  end



end #一番上のend