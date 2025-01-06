class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.string :key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
