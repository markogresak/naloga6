class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :age
      t.string :gender
      t.string :occupation
      t.string :zip_code
      t.string :label

      t.timestamps null: false
    end
  end
end
