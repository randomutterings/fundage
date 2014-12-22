class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :type, index: true
      t.timestamps
    end

    create_table :wallets do |t|
      t.references :owner, index: true
      t.string :type, index: true
      t.timestamps
    end

    create_table :entries do |t|
      t.timestamps
    end

    create_table :amounts do |t|
      t.string :type, index: true
      t.references :wallet, index: true
      t.references :entry, index: true
      t.decimal :amount, precision: 20, scale: 10
      t.timestamps
    end
  end
end
