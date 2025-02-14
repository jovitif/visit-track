class CreateSetors < ActiveRecord::Migration[7.0]
  def change
    create_table :setors do |t|
      t.string :nome, null: false
      t.text :descricao

      t.timestamps
    end

    # Tabela de relacionamento entre Setor e Funcionários (Usuários com role: funcionario)
    create_table :setores_funcionarios, id: false do |t|
      t.references :setor, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
