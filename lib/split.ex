defmodule DesafioStone.Split do
  @moduledoc """
  Documentation para Split.
  """

  @doc """
  Faz rateio de valores monetários entre vários indivíduos.

  ## Parâmetros

  - lista_pessoas: list Lista de pessoas com seus pesos.
  - valor: Decimal O valor da operação que será dividido.

  ## Exemplos

  iex> DesafioStone.Split.operacao_split([
  ...> %{:nome => "João", :peso => Decimal.new(3)}, 
  ...> %{:nome => "Maria", :peso => Decimal.new(5)}, 
  ...> %{:nome => "Marina", :peso => Decimal.new(10)}, 
  ...>], Decimal.new("500"))
  [
  %{:nome => "João", :peso => Decimal.new(3), :valor => Decimal.new("83.33")}, 
  %{:nome => "Maria", :peso => Decimal.new(5), :valor => Decimal.new("138.89")}, 
  %{:nome => "Marina", :peso => Decimal.new(10), :valor => Decimal.new("277.78")}, 
  ]

  """
  
  def operacao_split(lista_pessoas, valor) do
    alias Decimal, as: D

    total_pesos =
      Enum.map(lista_pessoas, fn item -> item[:peso] end)
      |> Enum.reduce(D.new("0"), fn a, b -> D.add(a, b) end)

    divisao = D.div(valor, total_pesos)

    Enum.map(lista_pessoas, fn item ->
      Map.put(item, :valor, D.round(D.mult(divisao, item[:peso]), 2))
    end)
  end
end
