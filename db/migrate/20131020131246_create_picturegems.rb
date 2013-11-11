class CreatePicturegems < ActiveRecord::Migration
  def change
    create_table :picturegems do |t|
      t.string :title
      t.string :gemimage
      t.references :picture

      t.timestamps
    end
  end
end
