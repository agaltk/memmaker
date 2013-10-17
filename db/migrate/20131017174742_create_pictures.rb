class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :title
      t.date :added
      t.string :image
      t.boolean :private

      t.timestamps
    end
  end
end
