class CreateStandard < ActiveRecord::Migration[5.2]
  def change
    create_table :standards do |t|
      t.string :standard
    end
  end
end
