class ChangePhonesExtensionAndNumberToString < ActiveRecord::Migration
  def change
    change_table :phones do |t|
      t.change :country, :string
      t.change :number, :string
      t.change :extension, :string
    end
  end
end
