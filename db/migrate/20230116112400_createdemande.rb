class Createdemande < ActiveRecord::Migration[5.2]
  def change
  
    create_table :demandes do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.string :commentaire
    end
  end
end
