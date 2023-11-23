class CreateStudyRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :study_records do |t|
      t.string :title
      t.text :body
      t.float :num_of_session
      t.integer :user_id
      t.timestamps
    end
  end
end
