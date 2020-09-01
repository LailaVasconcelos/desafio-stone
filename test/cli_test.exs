defmodule DesafioStone.CliTest do
  @moduledoc false
  use ExUnit.Case
  doctest DesafioStone.Cli

  import Mock

  test_with_mock "Verifica se exibe o help corretamente", IO, [:passthrough], [] do
    DesafioStone.Cli.main(["--help"])

    assert_called(
      IO.puts(:meck.is(fn texto -> String.starts_with?(texto, "Uso: ./minhapp [OPCOES]") end))
    )
  end

  # Resultado do call_history(IO):
  # [
  #  {#PID<0.206.0>, {IO, :puts, ["Resultado da operação de split: \n\n"]}, :ok},
  #  {#PID<0.206.0>, {IO, :puts, ["maria ficou com 100.00"]}, :ok},
  #  {#PID<0.206.0>, {IO, :puts, ["joana ficou com 50.00"]}, :ok},
  #  {#PID<0.206.0>, {IO, :puts, ["joao ficou com 50.00"]}, :ok}
  # ]
  test_with_mock "Verifica se faz o split corretamente", IO, [:passthrough], [] do
    DesafioStone.Cli.main(["--split", "200", "maria=2", "joana=1", "joao=1"])

    historico_chamadas =
      Enum.map(call_history(IO), fn {_, {IO, :puts, [texto]}, :ok} -> texto end)

    assert historico_chamadas == [
             "Resultado da operação de split: \n\n",
             "maria ficou com 100.00",
             "joana ficou com 50.00",
             "joao ficou com 50.00"
           ]
  end

  test_with_mock "Verifica se faz o cambio corretamente", IO, [:passthrough], [] do
    DesafioStone.Cli.main(["--cambio", "10", "--origem", "BRL", "--destino", "EUR"])
    assert_called(IO.puts("Resultado da operação de cambio: 2.20"))
  end
end
