defmodule DesafioStone.Cambio do
  @moduledoc """
  Documentation para Cambio.
  """

  @conversoes %{
    :BRL => %{:EUR => Decimal.new("0.22"), :USD => Decimal.new("0.17")},
    :EUR => %{:BRL => Decimal.new("6.3")}
  }

  @doc """
  Faz a conversão de valores entre moedas

  ## Examples

      iex> DesafioStone.Cambio.converte_moeda(:BRL, :EUR, Decimal.new("100"))
      #Decimal<22.00>

  """
  def converte_moeda(moeda1, moeda2, valor) do
    if Map.has_key?(@conversoes, moeda1) do
      if Map.has_key?(@conversoes[moeda1], moeda2) do
        Decimal.mult(valor, @conversoes[moeda1][moeda2])
      else
        nil
      end
    else
      nil
    end
  end
end
