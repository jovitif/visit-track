# Visit Track - Desafio de Estágio

Este é o projeto **Visit Track**, um sistema desenvolvido em **Ruby on Rails** para gestão de usuários, unidades e setores. Ele usa o banco de dados **PostgreSQL** e inclui funcionalidades de autenticação e diferentes tipos de usuários (Administrador, Atendente e Funcionário).

## Pré-requisitos

Antes de começar, você precisa ter o seguinte instalado em sua máquina:

- [Ruby 3.x](https://www.ruby-lang.org/)
- [Rails 7.x](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Bundler](https://bundler.io/)

## Passos para rodar o projeto

### 1. Clonar o repositório

Clone o repositório para sua máquina local:

```bash
git clone https://github.com/jovitif/visit-track.git

```
```bash
cd visit-track
```


### 2. Instalar as dependências

Instale as dependências do Ruby utilizando o Bundler:

```bash
bundle install
```

### 3. Configurar o banco de dados

Crie o banco de dados e rode as migrações:

```bash
rails db:create
```

```bash
rails db:migrate
```

### 4. Carregar os dados iniciais

Carregue os dados iniciais (com usuários fixos) utilizando o comando de seed:

```bash
rails db:seed
```

Isso irá criar o banco de dados com alguns registros fixos para facilitar os testes:

### 5. Iniciar o servidor

Inicie o servidor Rails:

```bash
rails server
```

Isso iniciará a aplicação no endereço http://localhost:3000.

### 6. Acessar a aplicação

Agora você pode acessar a aplicação e fazer login com os seguintes usuários:

Administrador

Email: admin@gmail.com

Senha: senha123

Atendente

Email: atendente@gmail.com

Senha: senha123

Funcionário

Email: funcionario@gmail.com

Senha: senha123
