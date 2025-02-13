class Ability
  include CanCan::Ability

  def initialize(user = nil)
    # Liberar acesso para qualquer pessoa
    can :create, Visita
    can :read, Visita
    
    return unless user

    case user.role.to_sym
    when :administrador
      can :manage, :all
    when :atendente
      can :create, Visitante
      can :read, Visitante
      can :create, Visita
      can :read, Visita
    when :funcionario
      can :read, Visita
      can :update, Visita
    end
  end
end
