class AddDetailsToTrainingSuggestions < ActiveRecord::Migration[7.2]
  def change
    add_column :training_suggestions, :age, :integer
    add_column :training_suggestions, :experience, :string
    add_column :training_suggestions, :focus_area, :string
  end
end
