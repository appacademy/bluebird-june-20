class RemoveIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :likes, :chirp_id
    remove_index :likes, :liker_id
    add_index :likes, :chirp_id
    add_index :likes, :liker_id
  end
end
