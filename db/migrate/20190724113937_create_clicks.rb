class CreateClicks < ActiveRecord::Migration[5.2]
  def change
    create_table :clicks do |t|
      t.string :country
      t.string :country_code
      t.datetime :occurred_at, default: DateTime.now
      t.references :link, foreign_key: true

      t.timestamps
    end
  end
end
