module ApplicationHelper
  require "uri"
  #uriライブラリを呼び出し、extractメソッドを使うことができるする（extractメソッドは、文字列からURIを抽出するメソッド）

  def text_url_to_link(text)
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      #引数の[“http”, “https”].uniqは引数のtextが「httpかhttps」のいずれかで始まるテキスト要素を重複を削除した形で配列を生成。
     text.gsub!(url, "<a href=\"#{url}\" target=\"_blank\">#{url}</a>")
      #gsub! textを変更するメソッド →　< a href=”#{url}”target=”_blank”>#{url}</a>”に置換する
      #"target="_blank"　=>新しいウィンドウにURLのリンク先ページを表示させる。 これがないとブラウザから一つ前の画面に戻るという操作をしないと、リンクする前のページに戻れない。
    end
      text
  end

end