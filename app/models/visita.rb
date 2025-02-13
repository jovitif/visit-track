class Visita < ApplicationRecord
    belongs_to :funcionario, class_name: 'User', foreign_key: 'idfuncionario'
    belongs_to :visitante, class_name: 'User', foreign_key: 'idvisitante'
    validates :foto, presence: true
end
