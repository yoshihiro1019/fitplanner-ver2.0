class CreateTrainingLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :training_logs do |t|
      t.string :training_type
      t.integer :weight
      t.integer :reps
      t.integer :sets
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
