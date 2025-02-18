require 'faker'
Faker::Config.locale = 'pt-BR'

User.delete_all
Setor.delete_all
Unidade.delete_all

# --- Criação de Unidades ---
unidades = []
5.times do |i|
  unidades << Unidade.create!(
    nome: "Unidade #{Faker::Company.name} #{i+1}",
    descricao: Faker::Company.catch_phrase
  )
end

# --- Criação de Setores para cada Unidade ---
setores = []
unidades.each do |unidade|
  3.times do |j|
    setores << Setor.create!(
      nome: "Setor #{Faker::Commerce.department(max: 1, fixed_amount: true)} - #{unidade.nome} #{j+1}",
      descricao: Faker::Company.bs,
      unidade_id: unidade.id
    )
  end
end

# --- Criação de Usuários ---

# Criar Administradores (não possuem unidade ou setor)
5.times do
  User.create!(
    nome: Faker::Name.name,
    cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
    telefone: Faker::PhoneNumber.cell_phone_in_e164,
    email: Faker::Internet.unique.email,
    password: 'senha123',
    role: 0, # 0 = Administrador
    unidade_id: nil,
    setor_id: nil
  )
end

# Criar Atendentes (devem informar a unidade)
10.times do
  unidade = unidades.sample
  User.create!(
    nome: Faker::Name.name,
    cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
    telefone: Faker::PhoneNumber.cell_phone_in_e164,
    email: Faker::Internet.unique.email,
    password: 'senha123',
    role: 2, # 2 = Atendente
    unidade_id: unidade.id,
    setor_id: nil
  )
end

# Criar Funcionários (devem informar a unidade e o setor)
20.times do
  unidade = unidades.sample
  setor = setores.select { |s| s.unidade_id == unidade.id }.sample
  User.create!(
    nome: Faker::Name.name,
    cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
    telefone: Faker::PhoneNumber.cell_phone_in_e164,
    email: Faker::Internet.unique.email,
    password: 'senha123',
    role: 1, # 1 = Funcionário
    unidade_id: unidade.id,
    setor_id: setor.id
  )
end

# Criar Administradores fixos
User.create!(
  nome: "Administrador",
  cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
  telefone: Faker::PhoneNumber.cell_phone_in_e164,
  email: "admin@gmail.com",
  password: 'senha123', # Senha fixa
  role: 0, # 0 = Administrador
  unidade_id: nil,
  setor_id: nil
)

# Criar Atendentes fixos (devem informar a unidade)
atendente_unidade = unidades.sample
User.create!(
  nome: "Atendente",
  cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
  telefone: Faker::PhoneNumber.cell_phone_in_e164,
  email: "atendente@gmail.com",
  password: 'senha123', # Senha fixa
  role: 2, # 2 = Atendente
  unidade_id: atendente_unidade.id,
  setor_id: nil
)

# Criar Funcionários fixos (devem informar a unidade e o setor)
funcionario_unidade = unidades.sample
funcionario_setor = setores.select { |s| s.unidade_id == funcionario_unidade.id }.sample
User.create!(
  nome: "Funcionário",
  cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
  telefone: Faker::PhoneNumber.cell_phone_in_e164,
  email: "funcionario@gmail.com",
  password: 'senha123', # Senha fixa
  role: 1, # 1 = Funcionário
  unidade_id: funcionario_unidade.id,
  setor_id: funcionario_setor.id
)


puts "Seeds criados com sucesso!"
