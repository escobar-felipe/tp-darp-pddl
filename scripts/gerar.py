#!/usr/bin/env python3
"""Gera as instancias do DARP em PDDL, da mais facil a mais dificil.

Uso:  python3 scripts/gerar.py          escreve tudo em problemas/
      python3 scripts/gerar.py --lista  so mostra a tabela de instancias

Cada instancia e sorteada uma vez e escrita nos tres formatos (v1, v2 e v3),
com os mesmos lugares, tempos e pedidos, para o custo ser comparavel tambem
entre as modelagens.
"""
import argparse
import math
import os
import random

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

BAIRROS = ["centro", "america", "bucarein", "iririu", "costa-e-silva", "boa-vista",
           "gloria", "atiradores", "saguacu", "floresta", "aventureiro", "santo-antonio"]

NOMES = ["ana", "bruno", "carla", "diego", "elena", "fabio", "gisele", "heitor",
         "irene", "joao", "karen", "lucas"]

# pedidos, veiculos, lugares (sem contar a garagem)
MATRIZ = [
    ("p1",  1, 1,  2),
    ("p2",  2, 1,  3),
    ("p3",  3, 1,  4),
    ("p4",  4, 2,  5),
    ("p5",  5, 2,  6),
    ("p6",  6, 2,  7),
    ("p7",  8, 3,  9),
    ("p8", 10, 3, 11),
]


def sortear(pedidos, veiculos, lugares, semente):
    """Monta os dados da instancia: lugares, tempos, veiculos e pedidos."""
    rnd = random.Random(semente)

    # coordenadas num mapa 20x20: a distancia garante a desigualdade triangular
    locais = ["garagem"] + BAIRROS[:lugares]
    coord = {l: (rnd.randint(0, 20), rnd.randint(0, 20)) for l in locais}

    tempo = {}
    for a in locais:
        for b in locais:
            if a != b:
                dx = coord[a][0] - coord[b][0]
                dy = coord[a][1] - coord[b][1]
                tempo[(a, b)] = max(1, round(math.hypot(dx, dy)))

    for a, b in list(tempo):   # simetrico
        tempo[(b, a)] = tempo[(a, b)]

    bairros = locais[1:]
    pessoas = []
    for k in range(pedidos):
        origem, destino = rnd.sample(bairros, 2)
        pessoas.append((NOMES[k], origem, destino, rnd.randrange(0, 60, 5)))

    frota = [(f"van{k + 1}", [3, 1, 2][k % 3]) for k in range(veiculos)]

    return locais, tempo, frota, pessoas


def escrever(versao, nome, locais, tempo, frota, pessoas):
    """Escreve a instancia no formato de uma das versoes do dominio."""
    if versao == "v1":   # v1 nao tem capacidade nem varios veiculos
        frota = frota[:1]

    objetos = [
        f"{' '.join(v for v, _ in frota):<40} - vehicle",
        f"{' '.join(p[0] for p in pessoas):<40} - passenger",
        f"{' '.join(locais):<40} - place",
    ]

    ini = []
    for v, cap in frota:
        linha = f"(vehicle-at {v} garagem)"
        if versao in ("v2", "v3"):
            linha += f"  (= (capacity {v}) {cap})  (= (seats-used {v}) 0)"
        if versao == "v3":
            linha += f"  (= (time {v}) 0)"
        ini.append(linha)
    ini.append("")

    for nome_p, origem, destino, hora in pessoas:
        linha = f"(passenger-at {nome_p} {origem})  (destination {nome_p} {destino})"
        if versao == "v3":
            linha += f"  (= (ready-at {nome_p}) {hora})"
        ini.append(linha)
    ini.append("")

    for a in locais:
        for b in locais:
            if a < b:
                ini.append(f"(= (travel-time {a} {b}) {tempo[(a, b)]})"
                           f" (= (travel-time {b} {a}) {tempo[(a, b)]})")
    ini.append("")
    ini.append("(= (total-cost) 0)")

    corpo = "\n".join("          " + l if l else "" for l in ini)
    meta = " ".join(f"(served {p[0]})" for p in pessoas)

    return (f"; gerado por scripts/gerar.py -- nao editar a mao\n"
            f"; {len(pessoas)} pedidos, {len(frota)} veiculo(s), {len(locais)} lugares\n\n"
            f"(define (problem darp-{versao}-{nome})\n"
            f"   (:domain darp-{versao})\n\n"
            f"   (:objects " + "\n             ".join(objetos) + ")\n\n"
            f"   (:init\n{corpo}\n   )\n\n"
            f"   (:goal (and {meta}))\n\n"
            f"   (:metric minimize (total-cost))\n)\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lista", action="store_true", help="so mostra a tabela")
    args = ap.parse_args()

    if args.lista:
        print("instancia  pedidos  veiculos  lugares")
        for nome, ped, vei, lug in MATRIZ:
            print(f"{nome:<10} {ped:>7} {vei:>9} {lug + 1:>8}")
        return

    for i, (nome, ped, vei, lug) in enumerate(MATRIZ):
        dados = sortear(ped, vei, lug, semente=100 + i)
        for versao in ("v1", "v2", "v3"):
            pasta = os.path.join(RAIZ, "problemas", versao)
            os.makedirs(pasta, exist_ok=True)
            with open(os.path.join(pasta, nome + ".pddl"), "w") as f:
                f.write(escrever(versao, nome, *dados))
        print(f"{nome}: {ped} pedidos, {vei} veiculo(s), {lug + 1} lugares")


if __name__ == "__main__":
    main()
