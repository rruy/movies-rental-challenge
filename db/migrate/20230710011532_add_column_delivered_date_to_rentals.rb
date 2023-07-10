class AddColumnDeliveredDateToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :delivered_date, :datetime
  end
end
