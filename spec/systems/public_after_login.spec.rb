require 'rails_helper'

RSpec.describe Public::CustomersController, type: :controller do

  describe 'ユーザログイン後のテスト' do
    let(:customer) { create(:customer) }
    let!(:other_customer) { create(:customer) }
    let!(:true_customer) { create(:true_customer) }
    # other_customer_id = 1 true_customer_id = 2 customer_id = 3
    let!(:post) { create(:post, customer: customer) }
    let!(:eat_post) { create(:eat_post, customer: other_customer) }
    let!(:info_post) { create(:info_post, customer: other_customer) }

    before do
        visit new_customer_session_path
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      #.customer(id:3)でログインしている状態
    end

   describe 'マイページのテスト' do
      before do
        visit customer_path(customer)
      end

      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/customers/' + customer.id.to_s
        end
        it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい' do
          expect(page).to have_link post.title, href: post_path(post)
        end
        it '投稿一覧に自分の投稿の本文が表示される' do
          expect(page).to have_content post.body
        end
        it '投稿の編集リンクが表示される' do
          expect(page).to have_link '編集', href: edit_post_path(post)
        end
        it '投稿の削除リンクが表示される' do
          expect(page).to have_link '削除', href: post_path(post)
        end
        it 'コメント数が表示され、投稿詳細へのリンク先が正しい' do
          expect(page).to have_link post.post_comments.count,href: post_path(post)
        end
        it  'いいね数が表示され,いいねしたユーザー一覧へのリンクが正しい' do
          expect(page).to have_link post.favorites.count,href: from_favorite_path(post)
        end
        it  '投稿時間が表示される' do
          expect(page).to have_content post.created_at.strftime("%Y/%m/%d %H:%M")
        end
        it '他人の投稿は表示されない' do
          expect(page).not_to have_link '', href: customer_path(other_customer)
          expect(page).not_to have_content eat_post.title
          expect(page).not_to have_content eat_post.body
        end
      end

      context 'サイドバーの確認' do
        it '自分のユーザー名と紹介文,BodyDataが表示される' do
          expect(page).to have_content customer.username
          expect(page).to have_content customer.introduction
          expect(page).to have_content customer.height
          expect(page).to have_content customer.weight
          expect(page).to have_content customer.fat_percentage
          expect(page).to have_content customer.age
          expect(page).to have_content customer.sex
        end
        it '自分のユーザ編集画面へのリンクが存在する' do
          expect(page).to have_link 'ユーザー情報編集', href: edit_customer_path(customer)
        end
        it 'フォローした人一覧のリンクが存在する' do
          expect(page).to have_link 'フォローした人', href: customer_follower_path(customer)
        end
        it 'フォローされた人のリンクが存在する' do
          expect(page).to have_link 'フォローされた人', href: customer_followed_path(customer)
        end
        it 'いいねした投稿一覧のリンクが存在する' do
          expect(page).to have_link 'いいねした投稿一覧', href: customer_favorite_path
        end
      end
    end


    describe '自分のユーザ情報編集画面のテスト' do
      before do
        visit edit_customer_path(customer)
      end

      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/customers/' + customer.id.to_s + '/edit'
        end
        it '名前編集フォームに自分の名前が表示される' do
          expect(page).to have_field 'customer[username]', with: customer.username
        end
        it '画像編集フォームが表示される' do
          expect(page).to have_field 'customer[profile_image]'
        end
        it '自己紹介編集フォームに自分の自己紹介文が表示される' do
          expect(page).to have_field 'customer[introduction]', with: customer.introduction
        end
        it '自己紹介編集フォームに自分のBodyDataが表示される' do
          expect(page).to have_field 'customer[height]', with: customer.height
          expect(page).to have_field 'customer[weight]', with: customer.weight
          expect(page).to have_field 'customer[fat_percentage]', with: customer.fat_percentage
          expect(page).to have_field 'customer[age]', with: customer.age
          expect(page).to have_field 'customer[sex]', with: customer.sex
        end
        it '更新ボタンが表示される' do
          expect(page).to have_button 'プロフィールを変更する'
        end
      end

      context '更新成功のテスト' do
        before do
          @customer_old_username = customer.username
          @customer_old_introduction = customer.introduction
          @customer_old_age = customer.age
          @post_sex_status = choose "customer_sex_男性"
          @customer_is_show = choose "customer_is_show_false"
          @customer_old_height = customer.height
          @customer_old_weight = customer.weight
          @customer_old_fat_pacentage = customer.fat_percentage
          fill_in 'customer[username]', with: Faker::Lorem.characters(number: 9)
          fill_in 'customer[introduction]', with: Faker::Lorem.characters(number: 19)
          fill_in 'customer[age]', with: "20"
          choose "customer_sex_女性"
          choose "customer_is_show_true"
          fill_in 'customer[height]', with: "165"
          fill_in 'customer[weight]', with: "55"
          fill_in 'customer[fat_percentage]',with: "30"
          click_button 'プロフィールを変更する'
        end

        it 'ユーザー名が正しく更新される' do
          expect(customer.reload.username).not_to eq @customer_old_username
        end
        it '自己紹介文が正しく更新される' do
          expect(customer.reload.introduction).not_to eq @customer_old_introduction
        end
        it '年齢が正しく更新される' do
          expect(customer.reload.age).not_to eq @customer_old_age
        end
        it '性別が正しく更新される' do
          expect(customer.reload.sex).not_to eq @customer_old_sex
        end
        it '身長が正しく更新される' do
          expect(customer.reload.height).not_to eq @customer_old_height
        end
        it '体重が正しく更新される' do
          expect(customer.reload.weight).not_to eq @customer_old_weight
        end
        it '体脂肪率が正しく更新される' do
          expect(customer.reload.fat_percentage).not_to eq @customer_old_fat_pacentage
        end
        it '公開ステータスが正しく更新される' do
          expect(customer.reload.is_show).not_to eq @customer_old_is_show
        end
        it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
          expect(current_path).to eq '/customers/' + customer.id.to_s
        end
      end
    end #ユーザー情報更新のテスト

  describe 'ヘッダーのテスト: ログインしている場合' do
      context 'リンクの内容を確認: ※ログアウトは『ユーザログアウトのテスト』でテスト済み' do
        subject { current_path }

        it 'スポーツクラブからの情報を押すと、トップページに遷移する' do
          admin_posts_link = find_all('a')[1].native.inner_text
          admin_posts_link = admin_posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link admin_posts_link
          is_expected.to eq '/public/admin_posts'
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
    end #ヘッダーのテスト: ログインしている場


    describe '投稿一覧画面のテスト' do
      let!(:post_comment) { create(:post_comment, post: post, customer: customer) }
      let!(:other_post_comment) { create(:other_post_comment, post: eat_post, customer: other_customer) }

      before do
        visit posts_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/posts'
        end
        it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
          expect(page).to have_link post.title, href: post_path(post)
          expect(page).to have_link eat_post.title, href: post_path(eat_post)
        end
        it   '自分の投稿と他人の投稿の本文が表示される' do
          expect(page).to have_content post.body
          expect(page).to have_content eat_post.body
        end
        it   '自分の投稿と他人の投稿の投稿時間が表示される' do
          expect(page).to have_content post.updated_at.strftime("%Y/%m/%d %H:%M")
          expect(page).to have_content eat_post.updated_at.strftime("%Y/%m/%d %H:%M")
        end
        it '自分の投稿と他人のマイページのリンク先がそれぞれ正しい' do
          expect(page).to have_link post.customer.username, href: customer_path(post.customer)
          expect(page).to have_link eat_post.customer.username, href: customer_path(eat_post.customer)
        end
        it   'トレーニングの投稿一覧へのリンクが表示され、リンク先が正しい' do
          expect(page).to have_link post.status, href: posts_training_path
        end
        it   '食事の投稿一覧へのリンクが表示され、リンク先が正しい' do
          expect(page).to have_link eat_post.status, href: posts_eat_path
        end
        it   '情報の共有の投稿一覧へのリンクが表示され、リンク先が正しい' do
          expect(page).to have_link info_post.status, href: posts_info_path
        end
        it   'コメント数が表示され、投稿詳細へのリンク先が正しい' do
          expect(page).to have_link post.post_comments.count,href: post_path(post)
        end
        it   'いいね数が表示され、いいねが押せる' do
          expect(page).to have_link post.favorites.count,href: post_favorites_path(post)
        end
      end

      context '投稿成功のテスト' do
        before do
          visit new_post_path
          choose "post_status_食事"
          fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
          fill_in 'post[body]', with: Faker::Lorem.characters(number: 30)
        end

        it '自分の新しい投稿が正しく保存される' do
          expect { click_button '投稿する' }.to change(customer.posts, :count).by(1)
        end
        it 'リダイレクト先が、マイページになっている' do
          click_button '投稿する'
          expect(current_path).to eq '/customers/' + post.customer.id.to_s
        end
      end
    end #投稿一覧のテスト

    describe '自分の投稿詳細画面のテスト' do
      before do
        visit post_path(post)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/posts/' + post.id.to_s
        end
        it '名前のリンク先が正しい' do
          expect(page).to have_link post.customer.username, href: customer_path(post.customer)
        end
        it '投稿のtitleが表示される' do
          expect(page).to have_content post.title
        end
        it '投稿の本文が表示される' do
          expect(page).to have_content post.body
        end
      end
    end  #投稿詳細ページのテスト

    describe '自分の投稿編集画面のテスト' do
      before do
        visit edit_post_path(post)
      end

      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
        end
        it 'title編集フォームが表示される' do
          expect(page).to have_field 'post[title]', with: post.title
        end
        it '本文編集フォームが表示される' do
          expect(page).to have_field 'post[body]', with: post.body
        end
        it 'ステータス編集フォームが表示される' do
          expect(page).to have_field 'post[status]', with: post.status
        end
        it '変更するボタンが表示される' do
          expect(page).to have_button '変更する'
        end
      end

      context '編集成功のテスト' do
        before do
          @post_old_title = post.title
          @post_old_body = post.body
          @post_old_status = choose "post_status_食事"
          fill_in 'post[title]', with: Faker::Lorem.characters(number: 4)
          fill_in 'post[body]', with: Faker::Lorem.characters(number: 19)
          choose "post_status_情報の共有"
          click_button '変更する'
        end

        it 'titleが正しく更新される' do
          expect(post.reload.title).not_to eq @post_old_title
        end
        it '本文が正しく更新される' do
          expect(post.reload.body).not_to eq @post_old_body
        end
        it 'ステータスが正しく更新される' do
          expect(post.reload.status).not_to eq @post_old_status
        end
        it 'リダイレクト先が,マイページになっている' do
         expect(current_path).to eq '/customers/' + post.customer.id.to_s
        end
      end
    end #投稿編集のテスト

  describe '自分のマイページの公開ステータスに対するテスト' do
      before do
        #公開ステータスを公開中に変更
        visit edit_customer_path(customer)
        @customer_old_is_show = choose "customer_is_show_false"
        choose "customer_is_show_true"
        click_button 'プロフィールを変更する'
      end
      it '公開ステータスが正しく更新される' do
        expect(customer.reload.is_show).not_to eq @customer_old_is_show
      end

      context '自分のマイページの表示の確認' do
        before do
          visit customer_path(customer)
        end
        #未公開の場合はデフォルトで設定しているのでマイページの表示の確認でテスト済み
        it '公開中でも自分のマイページではBodyDataが表示される' do
          expect(page).to have_content customer.height
          expect(page).to have_content customer.weight
          expect(page).to have_content customer.fat_percentage
          expect(page).to have_content customer.age
          expect(page).to have_content customer.sex
        end
      end
    end #自分のマイページの公開ステータスに対するテスト

    describe '他人のマイページに対するテスト BodyDataが未公開の場合' do
      before do
        visit customer_path(other_customer)
      end
      context '他人のマイページの表示の確認' do
        it 'ユーザー情報編集のリンクは表示されない' do
          expect(page).not_to have_link 'ユーザー情報編集', href: edit_customer_path(other_customer)
        end
        it 'BodyDataが未公開の場合、BodyDataが表示されない' do
          expect(page).not_to have_content other_customer.weight
          expect(page).not_to have_content other_customer.height
          expect(page).not_to have_content other_customer.fat_percentage
          expect(page).not_to have_content other_customer.age
          expect(page).not_to have_content other_customer.sex
        end
      end
    end #他人のマイページの表示の確認 BodyDataが未公開の場合

    describe '他人のマイページに対するテスト BodyDataが公開の場合 ' do
      before do
        visit customer_path(true_customer)
        #STDOUT.puts "@@@@@@@@@@@@@@"
        #STDOUT.puts  true_customer.is_show
        #STDOUT.puts "@@@@@@@@@@@@@@".      true_customerの公開ステータス確認時にコメントアウトを外して使用
      end

      context '他人のマイページの表示の確認' do
        it 'ユーザー情報編集のリンクは表示されない' do
          expect(page).not_to have_link 'ユーザー情報編集', href: edit_customer_path(true_customer)
        end

        it 'BodyDataは公開の場合、BodyDataが表示される' do
          expect(page).to have_content true_customer.weight
          expect(page).to have_content true_customer.height
          expect(page).to have_content true_customer.fat_percentage
          expect(page).to have_content true_customer.age
          expect(page).to have_content true_customer.sex
        end
      end
    end  #他人のマイページの表示の確認

  end # ログイン,投稿が作られた状態している状態
end