require 'rails_helper'

RSpec.describe Admin::CustomersController, type: :controller do
  describe 'ログイン後のテスト' do
    let(:admin_user) { create(:admin_user) }
    let!(:customer) { create(:customer) }
    let!(:post) { create(:post, customer: customer) }
    let!(:eat_post) { create(:eat_post, customer: customer) }
    let!(:genre) { create(:genre,name:"NEWプログラム") }
    let!(:other_genre) { create(:genre,name:"営業情報") }
    let!(:admin_post) { create(:admin_post,is_show:"未公開", genre: genre )}
    let!(:true_admin_post) { create(:true_admin_post,is_show:"公開中", genre: genre ) }
    #admin_post_id = 1 true_admin_post_id = 2

    before do
      visit new_admin_user_session_path
      fill_in 'admin_user[email]', with: admin_user.email
      fill_in 'admin_user[password]', with: admin_user.password
      click_button 'ログイン'
    end

    describe 'ヘッダーのテスト: ログインしている場合' do
      context 'リンクの内容を確認: ※ログアウトは『ログアウトのテスト』でテスト済み' do
        subject { current_path }

        it 'ユーザーを探すを押すと、ユーザー検索画面に遷移する' do
          search_link = find_all('a')[1].native.inner_text
          click_link search_link
          is_expected.to eq '/admin/customers'
        end
        it 'ユーザー投稿一覧を押すと、ユーザーの投稿一覧に遷移する' do
          user_post_link = find_all('a')[2].native.inner_text
          click_link user_post_link
          is_expected.to eq '/admin/customer/post'
        end
        it '管理者用情報作成を押すと、管理者の投稿作成画面に遷移する' do
          new_admin_post_link = find_all('a')[3].native.inner_text
          click_link new_admin_post_link
          is_expected.to eq "/admin_posts/new"
        end
        it '情報一覧を押すと、管理者の投稿一覧画面に遷移する' do
          admin_posts_link = find_all('a')[4].native.inner_text
          click_link admin_posts_link
          is_expected.to eq "/admin_posts"
        end
        it '情報ジャンルを追加すると押すと情報一覧画面へ遷移する' do
          genre_link = find_all('a')[5].native.inner_text
          click_link genre_link
          is_expected.to eq "/admin/genres"
        end
      end
    end #ヘッダーのテスト: ログインしている場


    describe "ユーザー投稿一覧のテスト" do
      before do
        visit admin_customer_post_path
      end
      context "表示の確認" do
        it 'URLが正しい' do
          expect(current_path).to eq '/admin/customer/post'
        end
        it '投稿一覧に投稿の本文が表示される' do
          expect(page).to have_content post.body
        end
        it '投稿ジャンル毎の一覧ページへ遷移するリンクが表示される' do
          expect(page).to have_link eat_post.status, href: posts_eat_path
        end
      end
    end # ユーザー投稿一覧のテスト

    describe '新規投稿画面のテスト' do
      context '投稿成功のテスト' do
        before do
          visit new_admin_post_path
          select "NEWプログラム",  from: "admin_post[genre_id]"
          fill_in 'admin_post[title]', with: Faker::Lorem.characters(number: 10)
          fill_in 'admin_post[body]', with: Faker::Lorem.characters(number: 30)
        end

        it '自分の新しい投稿が正しく保存される' do
          expect { click_button '編集画面に進む' }.to change(genre.admin_posts, :count).by(1)
        end
        it 'リダイレクト先が、編集画面になっている' do
          click_button '編集画面に進む'
          expect(current_path).to eq edit_admin_post_path(3)
        end
      end
    end #投稿成功のテスト

    describe '管理者の投稿詳細画面のテスト' do
      before do
        visit admin_post_path(admin_post)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/admin_posts/' + admin_post.id.to_s
        end
        it '投稿のtitleが表示される' do
          expect(page).to have_content admin_post.title
        end
        it '投稿の本文が表示される' do
          expect(page).to have_content admin_post.body
        end
        it '編集ボタンが表示される' do
          expect(page).to have_link "編集", href: edit_admin_post_path(admin_post)
        end
        it '削除ボタンが表示される' do
          expect(page).to have_link "削除", href: admin_post_path(admin_post)
        end
        it  '投稿時間が表示される' do
          expect(page).to have_content admin_post.updated_at.strftime("%Y/%m/%d %H:%M")
        end
      end
    end  #投稿詳細ページのテスト

    describe '管理者の投稿編集画面のテスト' do
      before do
        visit edit_admin_post_path(admin_post)

      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/admin_posts/' + admin_post.id.to_s + '/edit'
        end
        it '投稿のtitleが表示される' do
          expect(page).to have_field 'admin_post[title]'
        end
        it '投稿の本文が表示される' do
          expect(page).to have_field 'admin_post[body]'
        end
        it '画像編集フォームが表示される' do
          expect(page).to have_field 'admin_post[image]'
        end
        it 'YouTube投稿フォームが表示される' do
          expect(page).to have_field 'admin_post[youtube_url]'
        end
        it '公開ステータスの変更ボタンが表示される' do
          expect(page).to have_field 'admin_post_is_show_false'
          expect(page).to have_field 'admin_post_is_show_true'
        end
      end

      context '更新成功のテスト' do
        before do
          @admin_post_title = admin_post.title
          @admin_post_body = admin_post.body
          @admin_post_youtube_url = admin_post.youtube_url
          @admin_post_is_show = choose "admin_post_is_show_false"
          @admin_post_genre = admin_post.genre.name
          select "営業情報",  from: "admin_post[genre_id]"
          fill_in 'admin_post[title]', with: Faker::Lorem.characters(number: 9)
          fill_in 'admin_post[body]', with: Faker::Lorem.characters(number: 19)
          fill_in 'admin_post[youtube_url]', with: Faker::Lorem.characters(number: 10)
          choose "admin_post_is_show_true"
          click_button '更新する'
        end

        it '投稿ジャンルが正しく更新される' do
          expect(admin_post.reload.genre.name).not_to eq @admin_post_genre
        end
        it 'タイトルが正しく更新される' do
          expect(admin_post.reload.title).not_to eq @admin_post_title
        end
        it '本文が正しく更新される' do
          expect(admin_post.reload.body).not_to eq @admin_post_body
        end
        it 'YouTube動画が正しく更新される' do
          expect(admin_post.reload.youtube_url).not_to eq @admin_post_youtube_url
        end
        it '性別が正しく更新される' do
          expect(admin_post.reload.is_show).not_to eq @admin_post_is_show
        end

        it 'リダイレクト先が、管理者の投稿一覧画面になっている' do
          expect(current_path).to eq "/admin_posts"
        end
      end
    end  #投稿更新のテスト

    describe '管理者の投稿一覧画面のテスト' do

      before do
        visit admin_posts_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/admin_posts'
        end
        it '管理者の投稿とタイトルのリンク先がそれぞれ正しい' do
          expect(page).to have_link admin_post.title, href: admin_post_path(admin_post)
        end
        it  '管理者の投稿の本文が表示される' do
          expect(page).to have_content admin_post.body
        end
        it  '投稿ジャンルの一覧へのリンクが表示される' do
          expect(page).to have_link genre.name, href: admin_genre_path(genre)
        end
      end
    end #管理者の投稿一覧のテスト
  end #ログインした状態
end