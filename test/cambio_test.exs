defmodule DesafioStone.CambioTest do
  @moduledoc false

  use ExUnit.Case
  doctest DesafioStone.Cambio

  test "Verifica se a conversão de duas moedas conhecidas está correta" do
    assert DesafioStone.Cambio.converte_moeda(:BRL, :EUR, Decimal.new("55")) ==
             {:ok, Decimal.new("12.10")}
  end

  test "Verifica se retorna erro para moeda de origem não suportadas" do
    assert DesafioStone.Cambio.converte_moeda(:LSV, :EUR, Decimal.new("55")) ==
             {:error, :moeda_nao_suportada}
  end

  test "Verifica se retorna erro para moeda de destino não suportadas" do
    assert DesafioStone.Cambio.converte_moeda(:EUR, :LSV, Decimal.new("55")) ==
             {:error, :moeda_nao_suportada}
  end
end
