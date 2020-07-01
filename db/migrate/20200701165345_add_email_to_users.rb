class AddEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string, null: false # :null => false, cant have a null value in this column
              # tablename, columnname, datatype, optional constraints
    add_index :users, :email, unique: true
              # tablename, columnname, optional constraints
  end
end
