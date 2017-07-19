class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:price, :decimal, :precision => 8, :scale => 2)
    end
  end
end
