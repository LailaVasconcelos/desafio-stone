defmodule DesafioStoneTest do
  use ExUnit.Case
  doctest DesafioStone

  test "Verifica se a conversão de duas moedas conhecidas está correta" do
    assert DesafioStone.converte_moeda("BRL", "EUR", 55) == 12.1

  test "Verifica se retorna nulo para conversão não suportadas" do
    assert DesafioStone.converte_moeda("BRL", "ARS", 55) == nil  
  end
end
