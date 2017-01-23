class AddPayidToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :payid, :string
  end
end
