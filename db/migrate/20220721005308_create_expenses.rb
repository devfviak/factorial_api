class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :concept, null: false
      t.decimal :subtotal_cents, null: false
      t.decimal :total_cents, null: false
      t.string :currency, null: false
      t.string :processor, null: false
      t.json :processor_info

      t.references :user

      t.timestamps
    end
  end
end
