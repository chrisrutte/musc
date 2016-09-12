class AddTimeToThrills < ActiveRecord::Migration[5.0]
  def change
    add_column :thrills, :time, :time
  end
end
