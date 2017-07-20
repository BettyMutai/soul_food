class CreateKitchens < ActiveRecord::Migration[5.1]
  def change
    create_table(:kitchens) do |t|
      t.column(:recipe_id, :integer)
      t.column(:tag_id, :integer)
      t.column(:ingredients, :string)
      t.column(:instructions, :string)
      t.timestamps
    end
  end
end
