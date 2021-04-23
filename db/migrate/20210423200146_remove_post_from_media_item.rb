class RemovePostFromMediaItem < ActiveRecord::Migration[6.1]
  def up
    remove_column :media_items, :post_id
  end
end
