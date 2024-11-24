class AddCodeToBodyParts < ActiveRecord::Migration[7.2]
  def change
    add_column :body_parts, :code, :string
  end
end
