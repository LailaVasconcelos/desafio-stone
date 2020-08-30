defmodule Split do
  @moduledoc """
  Documentation para Split.
  """

  def operacao_split(lista_pessoas, valor) do
    alias Decimal, as: D

    total_pesos = Enum.map(lista_pessoas, fn item -> item[:peso] end) 
    |> Enum.reduce(D.new("0"), fn (a, b) -> D.add(a, b) end)
    
    divisao = D.div(valor, total_pesos)

    item_valor_inserido = Enum.map(lista_pessoas, fn item -> Map.put(item, :valor, D.round(D.mult(divisao, item[:peso]), 2)) end)     
    
  end
end
