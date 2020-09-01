# DesafioStone

A aplicação realiza split de transações financeiras entre diferentes indivíduos.
A aplicação realiza câmbio entre moedas distintas. O sistema está em conformidade com a ISO 4217.

## Como instalar e compilar

```sh
mix deps.get
mkdir -p .git/hooks
mix git_hooks.install
mix compile --warnings-as-errors
```

## Como executar os testes

```sh
mix test
```

## Como buildar

```sh
mix escript.build
```

## Como executar a aplicação

### Para realizar uma operação de câmbio

```sh
./desafio_stone -c 500.00 --origem EUR --destino BRL
```

### Para realizar uma operação de câmbio

```sh
./desafio_stone -s 300.00 joaquim=34 joana=67
```

## Como gerar a documentação

```sh
mix deps.get
mix docs
```
