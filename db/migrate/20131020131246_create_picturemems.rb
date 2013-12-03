class CreatePicturemems < ActiveRecord::Migration
  def change
    create_table :picturemems do |t|
      t.string :title
      t.string :memimage
      t.references :picture

      t.timestamps
    end
  end
end
