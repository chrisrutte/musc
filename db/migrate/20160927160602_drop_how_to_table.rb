class DropHowToTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :add_new_fields_to_reviews
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end