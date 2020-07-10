class ChangeNullOnPolColumnOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :political_affiliation, true
  end
end
