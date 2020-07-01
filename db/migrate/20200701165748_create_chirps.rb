class CreateChirps < ActiveRecord::Migration[5.2]
  def change
    create_table :chirps do |t|
      t.text :body, null: false # t.text vs t.string, string is smaller number of chars
      # use string if you arent expecting big strings
      t.integer :author_id, null: false
      
      t.timestamps
    end

    add_index :chirps, :author_id # indexes for things that are searched a lot/or unique
  end
end
