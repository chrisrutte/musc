class AddNameToTrainings < ActiveRecord::Migration[5.0]
  def change
    add_column :trainings, :tr_name, :string
  end
end
