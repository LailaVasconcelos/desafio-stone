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
      {:ok, Decimal.new("22.00")}

  """
  def converte_moeda(moeda_origem, moeda_destino, valor) do
    if Map.has_key?(@conversoes, moeda_origem) do
      if Map.has_key?(@conversoes[moeda_origem], moeda_destino) do
        {:ok, Decimal.new(Decimal.mult(valor, @conversoes[moeda_origem][moeda_destino]))}
      else
        {:error, :moeda_nao_suportada}
      end
    else
      {:error, :moeda_nao_suportada}
    end
  end
end
