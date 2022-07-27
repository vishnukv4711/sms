class RemoveStandardFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :standard
  end
end
