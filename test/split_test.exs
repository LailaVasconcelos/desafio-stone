defmodule DesafioStone.SplitTest do
  @moduledoc false
  
  use ExUnit.Case
  doctest DesafioStone.Split

  test "Testa os valores do resultado do split para 3 pessoas" do
    lista_pessoas_split = [
      %{:nome => "Maria", :peso => Decimal.new(5)},
      %{:nome => "Joaquim", :peso => Decimal.new(3)},
      %{:nome => "Marina", :peso => Decimal.new(10)}
    ]

    resultado_esperado = [
      %{:nome => "Maria", :peso => Decimal.new(5), :valor => Decimal.new("138.89")},
      %{:nome => "Joaquim", :peso => Decimal.new(3), :valor => Decimal.new("83.33")},
      %{:nome => "Marina", :peso => Decimal.new(10), :valor => Decimal.new("277.78")}
    ]

    assert DesafioStone.Split.operacao_split(lista_pessoas_split, Decimal.new("500")) ==
             resultado_esperado
  end

  test "Verifica se o split está com problemas de arrendodamento" do
    valor_original = Decimal.new("500.00")

    lista_pessoas_split = [
      %{:nome => "Maria", :peso => Decimal.new(5)},
      %{:nome => "Joaquim", :peso => Decimal.new(3)},
      %{:nome => "Marina", :peso => Decimal.new(10)}
    ]

    resultado = DesafioStone.Split.operacao_split(lista_pessoas_split, valor_original)

    valor_total =
      resultado
      |> Enum.map(fn item -> item[:valor] end)
      |> Enum.reduce(Decimal.new("0"), fn a, b -> Decimal.add(a, b) end)

    assert valor_total == valor_original
  end
end
