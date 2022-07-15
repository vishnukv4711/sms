class Academics < ActiveRecord::Migration[5.2]
  def change
    create_table :academics do |t|
      t.string :exam_type
      t.float :english
      t.float :maths
      t.float :science
      t.float :social
      t.float :computer
      t.float :total
      t.float :percentage
      t.string :remarks
      t.integer :student_id
      t.timestamps
    end
  end
end
