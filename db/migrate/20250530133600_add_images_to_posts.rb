class AddImagesToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :images, :json
  end
end
