defmodule DesafioStone.Cli do
  @moduledoc """

  Esse módulo possui as funções necessarias para parsear os argumentos e chamar as operações.
  """

  @doc """
  Esse método é chamado quando a aplicação é executada

  ## Parâmetros

    - argv: list Lista de argumentos passados na linha comando.

  """
  def main(argv) do
    argv
    |> parse_args
    |> run
  end

  defp parse_args(args) do
    parsed_args =
      OptionParser.parse(args,
        switches: [split: :string, cambio: :string, origem: :string, destino: :string],
        aliases: [h: :help, s: :split, c: :cambio, o: :origem, d: :destino]
      )

    case parsed_args do
      {[help: true], _, _} ->
        :help

      {[split: valor], individuos, _} ->
        {:split, valor, individuos}

      {[cambio: valor, origem: moeda1, destino: moeda2], _, _} ->
        {:cambio, valor, moeda1, moeda2}

      _ ->
        :uso_invalido
    end
  end

  defp str_para_individuo(individuo_str) do
    valores = String.split(individuo_str, "=")

    if length(valores) == 2 do
      {:ok, %{:nome => Enum.at(valores, 0), :peso => Decimal.new(Enum.at(valores, 1))}}
    else
      {:error, :formato_invalido}
    end
  end

  defp run(:help) do
    Bunt.puts("""
    Uso: ./desafio_stone [OPCOES] 
    [--help|-h]                                               - Mostra esse help

    Opções:
    [--split|-s] <valor> individuo=peso [individuo=peso ...]  - Faz o split do valor entre os indivíduos
    [--cambio|-c] <valor> --origem EUR --destino BRL          - Executa o câmbio de valores
    """)
  end

  defp run(:uso_invalido) do
    IO.puts("Uso incorreto! Favor checar a documentação.\n\n")
    run(:help)
    exit(1)
  end

  defp run({:split, valor_str, individuos}) do
    pre_lista_individuos = Enum.map(individuos, fn ind -> str_para_individuo(ind) end)

    if length(Enum.filter(pre_lista_individuos, fn {status, _} -> status == :error end)) > 0 do
      run(:uso_invalido)
    end

    lista_individuos = Enum.map(pre_lista_individuos, fn {_, ind} -> ind end)
    valor = Decimal.new(valor_str)
    lista_individuos_com_valor = DesafioStone.Split.operacao_split(lista_individuos, valor)

    IO.puts("Resultado da operação de split: \n\n")

    Enum.each(lista_individuos_com_valor, fn ind ->
      IO.puts("#{ind[:nome]} ficou com #{Decimal.to_string(ind[:valor], :normal)}")
    end)
  end

  defp run({:cambio, valor_str, moeda1_str, moeda2_str}) do
    moeda1 = String.to_atom(moeda1_str)
    moeda2 = String.to_atom(moeda2_str)
    valor = Decimal.new(valor_str)
    resultado_op = DesafioStone.Cambio.converte_moeda(moeda1, moeda2, valor)

    case resultado_op do
      {:ok, valor_final} ->
        IO.puts("Resultado da operação de cambio: #{Decimal.to_string(valor_final, :normal)}")

      {:error, :moeda_nao_suportada} ->
        IO.puts("Combinação de moedas não suportada!\n")
        exit(1)
    end
  end
end
