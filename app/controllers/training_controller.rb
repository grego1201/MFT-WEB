class TrainingController < ApplicationController

  ACTIONS = [
    "Finta y pase", "Contra de sexta", "Batir, avanzada", "Tocado al pie",
    "Contra-ataque", "Contra-tiempo", "Directo", "Provocar cuerpo a cerpo",
    "Ligamento", "Flecha", "Finta, Flecha", "Fondo", "Marcha fondo", "Flecha
    provocando su cuarta y tocar en remix", "Flecha provocando su sexta
    y tocar en remix", "Tocado en fin de pista", "Tocado en inicio de pista",
    "Finta y flecha"
  ].freeze

  def index
    @actions = ACTIONS
  end

  def show_random
    @actions = ACTIONS
    @generated_actions = ACTIONS.sample(params[:actions_number].to_i)
  end

end
