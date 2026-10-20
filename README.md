# Dial-a-Ride Problem em PDDL

Modelagem do transporte porta a porta agendado (DARP) como problema de planejamento automático, em quatro versões que vão do caso mais simples ao mais completo, e avaliação de quatro solvers sobre as mesmas instâncias.

O problema: a prefeitura precisa atender pedidos de transporte feitos na véspera por pessoas com deficiência e mobilidade reduzida. Cada pedido tem nome, endereço de saída, endereço de destino e hora de saída. A solução é a rota de cada veículo.

## Requisitos

Docker. As imagens dos solvers são as mesmas usadas nos exemplos da disciplina:

- `azathoth/pddl` — Metric-FF e OPTIC
- `aibasel/downward` — Fast Downward

Em Mac com chip ARM as duas são x86 e rodam emuladas, o que o `scripts/solver.sh` resolve com `--platform`.

## Como rodar

Cada versão tem o seu `solve.sh`, que resolve o exemplo daquela pasta com o Metric-FF:

```sh
./v1-pedidos/solve.sh
```

Para escolher o solver:

```sh
scripts/solver.sh ff    v1-pedidos/domain.pddl v1-pedidos/problem.pddl   # Metric-FF
scripts/solver.sh lama  v1-pedidos/domain.pddl v1-pedidos/problem.pddl   # Fast Downward, satisfatório
scripts/solver.sh opt   v1-pedidos/domain.pddl v1-pedidos/problem.pddl   # Fast Downward, ótimo
scripts/solver.sh optic v1-pedidos/domain.pddl v1-pedidos/problem.pddl   # OPTIC
```

## As quatro versões

| Pasta | O que acrescenta |
|---|---|
| `v0-basico` | um veículo, um passageiro, sem custo |
| `v1-pedidos` | vários pedidos e custo igual ao tempo de deslocamento |
| `v2-veiculos` | vários veículos, com capacidades diferentes |
| `v3-horarios` | hora de saída do pedido e espera do veículo |

As ações são sempre as mesmas três: `drive`, `pickup` e `dropoff`, mais `wait` na v3. O estado diz onde está cada veículo, onde está cada passageiro, quem já está a bordo e quem já foi atendido.

## Avaliação dos solvers

```sh
python3 scripts/gerar.py     # instâncias de 1 a 10 pedidos em problemas/
python3 scripts/avaliar.py   # roda os solvers e grava results/avaliacao.csv
```

O gerador escreve a mesma instância nos três formatos (v1, v2 e v3), então o custo é comparável entre as modelagens, e não só entre os solvers.

## Estrutura

```
v0-basico/ ... v3-horarios/   domínio, exemplo e solve.sh de cada versão
problemas/                    instâncias geradas para a avaliação
scripts/                      gerador, wrapper dos solvers e avaliação
relatorio/                    relatório do trabalho
```

## Relatório

`relatorio/relatorio.tex` é a fonte e `relatorio/relatorio.pdf` a versão para entrega:

```sh
cd relatorio && tectonic -X compile relatorio.tex
```

`relatorio/relatorio.md` é o mesmo texto em markdown, para ler direto no GitHub.
