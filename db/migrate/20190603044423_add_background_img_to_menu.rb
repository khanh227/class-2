class AddBackgroundImgToMenu < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :background_img, :string
  end
end
