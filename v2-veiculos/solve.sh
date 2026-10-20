#!/bin/bash
# Resolve esta versao com o Metric-FF.
cd "$(dirname "$0")"
../scripts/solver.sh ff domain.pddl problem.pddl
