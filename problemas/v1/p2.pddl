; gerado por scripts/gerar.py -- nao editar a mao
; 2 pedidos, 1 veiculo(s), 4 lugares

(define (problem darp-v1-p2)
   (:domain darp-v1)

   (:objects van1                                     - vehicle
             ana bruno                                - passenger
             garagem centro america bucarein          - place)

   (:init
          (vehicle-at van1 garagem)

          (passenger-at ana bucarein)  (destination ana centro)
          (passenger-at bruno america)  (destination bruno centro)

          (= (travel-time centro garagem) 5) (= (travel-time garagem centro) 5)
          (= (travel-time america garagem) 6) (= (travel-time garagem america) 6)
          (= (travel-time america centro) 10) (= (travel-time centro america) 10)
          (= (travel-time america bucarein) 5) (= (travel-time bucarein america) 5)
          (= (travel-time bucarein garagem) 2) (= (travel-time garagem bucarein) 2)
          (= (travel-time bucarein centro) 5) (= (travel-time centro bucarein) 5)

          (= (total-cost) 0)
   )

   (:goal (and (served ana) (served bruno)))

   (:metric minimize (total-cost))
)
