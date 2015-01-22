class RenamePhonesTypeToKind < ActiveRecord::Migration
  def change
    rename_column :phones, :type, :kind
  end
end
