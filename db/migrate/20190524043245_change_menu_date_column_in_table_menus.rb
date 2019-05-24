class ChangeMenuDateColumnInTableMenus < ActiveRecord::Migration[5.2]
  def change
    change_column :menus, :menu_date, :date
  end
end
