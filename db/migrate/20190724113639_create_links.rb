class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url_hash, index: true, unique: true
      t.string :url

      t.timestamps
    end
  end
end
