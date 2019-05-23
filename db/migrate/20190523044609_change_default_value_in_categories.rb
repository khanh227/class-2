class ChangeDefaultValueInCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :name, :string, null: false
    change_column :categories, :enabled, :boolean, default: true
  end
end
