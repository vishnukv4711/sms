class RenameColumnInStudents < ActiveRecord::Migration[5.2]
  def change
    rename_column :students, :standrd_id, :standard_id
  end
end
