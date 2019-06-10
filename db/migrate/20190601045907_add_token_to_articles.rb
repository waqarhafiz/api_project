class AddTokenToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :token, :integer
  end
end
