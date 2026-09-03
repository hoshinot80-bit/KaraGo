class CreateWantToSings < ActiveRecord::Migration[7.2]
  def change
    create_table :want_to_sings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
