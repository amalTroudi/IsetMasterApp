class Createmotif < ActiveRecord::Migration[5.2]
  def change
    create_table :motifs do |t|
      t.string :reason
      t.timestamps
    end
  end
end
