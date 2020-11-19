# ルート
crumb :root do
  link "FURIMA", root_path
end
# マイページ
crumb :mypage do
  link "マイページ", user_path
end
# 商品出品ページ
crumb :item_new do
  link "出品する ", items_sell_path
end
# カテゴリー一覧
crumb :category do
  link "カテゴリー一覧", categories_path
end
# 親カテゴリー
crumb :parent do |category|
  category = Category.find(params[:id]).root
  link "#{category.name}", category_path(category)
  parent :category
end
# 子カテゴリー
crumb :child do |category|
  category = Category.find(params[:id])
  # 子カテゴリーか確認する
  if category.has_children?
    link "#{category.name}", category_path(Category)
    parent :parent
  else
    link "#{category.parent.name}", category_path(category.parent)
    parent :parent
  end
end
# 孫カテゴリー
crumb :grandchild do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(category)
  parent :child
end
# アイテム
crumb :item do |item|
  link "商品の詳細", item_path
  parent :mypage
end

crumb :edit_item do |item|
  link "商品を編集する", edit_item_path
  parent :item
end

crumb :buy_item do |item|
  link "商品を購入する", buy_item_path
  parent :item
end

crumb :sign_in do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :registration do
  link "新規会員登録", new_user_registration_path
  parent :root
end
# crumb :item do |item|
#   item = Item.find(params[:id])
#   link "#{item.name}", item_path
#   parent :grandchild
# end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).