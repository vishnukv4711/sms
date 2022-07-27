class CreateStandardUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :standard_users do |t|
      t.integer :user_id
      t.integer :standard_id
    end
  end
end
