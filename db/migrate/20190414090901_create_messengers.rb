class CreateMessengers < ActiveRecord::Migration[5.2]
  def change
    create_table :messengers do |t|
      t.text :content

      t.timestamps
    end
  end
end
