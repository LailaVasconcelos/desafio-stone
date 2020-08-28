defmodule CambioTest do
  use ExUnit.Case
  doctest Cambio

  test "Verifica se a conversão de duas moedas conhecidas está correta" do
    assert Cambio.converte_moeda(:BRL, :EUR, Decimal.new("55")) == Decimal.new("12.10")
  end

  test "Verifica se retorna nulo para conversão não suportadas" do
    assert Cambio.converte_moeda(:BRL, :ARS, Decimal.new("55")) == nil  
  end
end
