class AddStandardIdToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :standrd_id, :integer
  end
end
