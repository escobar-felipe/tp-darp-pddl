#!/usr/bin/env python3
"""Roda cada solver em cada instancia e guarda tempo, custo e tamanho do plano.

Uso:  python3 scripts/avaliar.py                 tudo, 60s por execucao
      python3 scripts/avaliar.py --limite 30     muda o limite de tempo
      python3 scripts/avaliar.py --paralelo 2    execucoes ao mesmo tempo

Gera results/avaliacao.csv, uma linha por (versao, instancia, solver), com o
status em ok, timeout, recusado (o solver nao aceita o dominio) ou sem-plano.
"""
import argparse
import csv
import os
import re
import subprocess
import time
from concurrent.futures import ThreadPoolExecutor

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# o Fast Downward (lama e opt) so aceita :action-costs, entao nao entra em v2 e v3
SOLVERS = {
    "v1": ["ff", "lama", "opt", "optic"],
    "v2": ["ff", "optic"],
    "v3": ["ff", "optic"],
}

PASTA = {"v1": "v1-pedidos", "v2": "v2-veiculos", "v3": "v3-horarios"}


def ler_saida(solver, texto):
    """Tira custo e numero de passos da saida do solver."""
    if solver == "ff":
        custo = re.search(r"plan cost:\s*([\d.]+)", texto)
        passos = re.findall(r"^\s*(?:step)?\s*\d+:\s+\S+", texto, re.M)
        if custo:
            return float(custo.group(1)), len(passos)
        if "found legal plan" in texto:   # sem :metric nao imprime o custo
            return None, len(passos)

    elif solver in ("lama", "opt"):
        custo = re.search(r"Plan cost:\s*(\d+)", texto)
        passos = re.search(r"Plan length:\s*(\d+)", texto)
        if custo and passos:
            return float(custo.group(1)), int(passos.group(1))

    elif solver == "optic":   # imprime "; Cost: N" e uma linha por acao
        custo = re.findall(r";\s*Cost:\s*([\d.]+)", texto)
        passos = re.findall(r"^\d+\.\d+:\s+\(", texto, re.M)
        if passos:
            return (float(custo[-1]) if custo else None), len(passos)

    return None, None


def recusado(texto):
    return ("Invalid requirement" in texto
            or "has to terminate" in texto
            or "Syntax error" in texto)


def rodar(versao, instancia, solver, limite):
    dominio = os.path.join(PASTA[versao], "domain.pddl")
    problema = os.path.join("problemas", versao, instancia + ".pddl")

    inicio = time.time()
    r = subprocess.run([os.path.join(RAIZ, "scripts", "solver.sh"),
                        solver, dominio, problema, str(limite)],
                       cwd=RAIZ, capture_output=True, text=True,
                       timeout=limite + 120)
    gasto = time.time() - inicio
    saida = r.stdout + r.stderr

    custo, passos = ler_saida(solver, saida)
    if recusado(saida):
        status = "recusado"
    elif passos is not None:
        status = "ok"
    elif gasto >= limite:
        status = "timeout"
    else:
        status = "sem-plano"

    print(f"{versao} {instancia:<3} {solver:<6} {status:<9} "
          f"{gasto:6.1f}s  custo={custo}  passos={passos}", flush=True)

    return dict(versao=versao, instancia=instancia, solver=solver, status=status,
                segundos=round(gasto, 2), custo=custo, passos=passos)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--limite", type=int, default=60)
    ap.add_argument("--paralelo", type=int, default=3)
    ap.add_argument("--versoes", nargs="*", default=["v1", "v2", "v3"])
    args = ap.parse_args()

    tarefas = []
    for versao in args.versoes:
        pasta = os.path.join(RAIZ, "problemas", versao)
        for arq in sorted(os.listdir(pasta)):
            instancia = arq.removesuffix(".pddl")
            for solver in SOLVERS[versao]:
                tarefas.append((versao, instancia, solver, args.limite))

    with ThreadPoolExecutor(max_workers=args.paralelo) as pool:
        linhas = list(pool.map(lambda t: rodar(*t), tarefas))

    os.makedirs(os.path.join(RAIZ, "results"), exist_ok=True)
    destino = os.path.join(RAIZ, "results", "avaliacao.csv")
    with open(destino, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(linhas[0]))
        w.writeheader()
        w.writerows(linhas)
    print("\n->", destino)


if __name__ == "__main__":
    main()
