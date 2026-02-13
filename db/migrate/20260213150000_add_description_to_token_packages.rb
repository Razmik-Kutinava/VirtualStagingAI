class AddDescriptionToTokenPackages < ActiveRecord::Migration[8.1]
  def change
    add_column :token_packages, :description, :text
  end
end
