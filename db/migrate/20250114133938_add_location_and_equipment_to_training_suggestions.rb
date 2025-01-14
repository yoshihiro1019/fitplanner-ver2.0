class AddLocationAndEquipmentToTrainingSuggestions < ActiveRecord::Migration[7.2]
  def change
    add_column :training_suggestions, :training_location, :string
    add_column :training_suggestions, :home_equipment, :string
  end
end
