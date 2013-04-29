class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answer
      t.string :set
      t.integer :set_id
      t.string :ip
      t.timestamp :starttime

      t.timestamps
    end
  end
end
