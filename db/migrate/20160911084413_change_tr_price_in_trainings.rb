class ChangeTrPriceInTrainings < ActiveRecord::Migration[5.0]
  def up
    change_column :trainings, :tr_price, :decimal, precision: 5, scale: 2
  end

  def down
    change_column :trainings, :tr_price, :integer
  end
end
