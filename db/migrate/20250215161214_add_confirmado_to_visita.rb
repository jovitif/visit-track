class AddConfirmadoToVisita < ActiveRecord::Migration[7.2]
  def change
    add_column :visita, :confirmado, :boolean
  end
end
