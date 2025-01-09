class CreateTrainingSuggestions < ActiveRecord::Migration[7.2]
  def change
    create_table :training_suggestions do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
