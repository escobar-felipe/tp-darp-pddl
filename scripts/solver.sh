#!/bin/bash
# Roda UM solver sobre um par (dominio, problema) e imprime a saida dele.
#
# Uso:  scripts/solver.sh ff|lama|opt|optic <dominio.pddl> <problema.pddl> [limite_s]
#
# Solvers, nas mesmas imagens Docker usadas nos exemplos da disciplina:
#   ff      Metric-FF                            numerico, para no primeiro plano bom
#   lama    Fast Downward, alias lama-first      so custos, para no primeiro plano bom
#   opt     Fast Downward, alias seq-opt-lmcut   so custos, devolve o plano de menor custo
#   optic   OPTIC                                numerico e temporal
#
# O limite padrao e 300s. Em Mac com chip ARM as imagens sao x86 e rodam
# emuladas, por isso o --platform. O projeto inteiro vai montado em /x.

set -u

RAIZ=$(cd "$(dirname "$0")/.." && pwd)
LIMITE=${4:-300}

abs() { echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"; }

SOLVER=$1
DOM=$(abs "$2"); DOM=${DOM#"$RAIZ/"}
PRB=$(abs "$3"); PRB=${PRB#"$RAIZ/"}

PLAT="--platform linux/amd64"

case $SOLVER in
  ff)
    BUSCA="-s 0"
    grep -q ":metric" "$RAIZ/$PRB" && BUSCA="-s 5"   # -s 5 otimiza, mas exige :metric
    exec docker run --rm $PLAT --entrypoint timeout -v "$RAIZ":/x azathoth/pddl \
         "$LIMITE" /root/planners/Metric-FF/ff -o "/x/$DOM" -f "/x/$PRB" $BUSCA
    ;;
  lama)
    exec docker run --rm $PLAT --entrypoint timeout -v "$RAIZ":/x aibasel/downward \
         "$LIMITE" /workspace/downward/fast-downward.py --alias lama-first "/x/$DOM" "/x/$PRB"
    ;;
  opt)
    exec docker run --rm $PLAT --entrypoint timeout -v "$RAIZ":/x aibasel/downward \
         "$LIMITE" /workspace/downward/fast-downward.py --alias seq-opt-lmcut "/x/$DOM" "/x/$PRB"
    ;;
  optic)
    exec docker run --rm $PLAT --entrypoint timeout -v "$RAIZ":/x azathoth/pddl \
         "$LIMITE" /root/planners/optic-clp "/x/$DOM" "/x/$PRB"
    ;;
  *)
    echo "uso: $0 ff|lama|opt|optic <dominio.pddl> <problema.pddl> [limite_s]" >&2
    exit 2
    ;;
esac
