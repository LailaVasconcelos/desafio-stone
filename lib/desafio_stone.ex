defmodule DesafioStone do
  @moduledoc """
  Documentation para DesafioStone.
  """

  @conversoes %{"BRL" => %{"EUR" => 0.22, "USD" => 0.17}, "EUR" => %{"BRL" => 6.3}}

  @doc """
  Faz a conversão de valores entre moedas

  ## Examples

      iex> DesafioStone.converte_moeda("BRL", "EUR", 100)
      22.0 # Valor convertido de reais brasileiros (BRL) para euros (EUR)
      

  """
  def converte_moeda(moeda1, moeda2, valor) do
    if Map.has_key?(@conversoes, moeda1) do
      if Map.has_key?(@conversoes[moeda1], moeda2) do
          valor * @conversoes[moeda1][moeda2]
      else
        nil
      end
    else
      nil
    end
  end
end
