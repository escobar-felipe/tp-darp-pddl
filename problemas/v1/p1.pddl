; gerado por scripts/gerar.py -- nao editar a mao
; 1 pedidos, 1 veiculo(s), 3 lugares

(define (problem darp-v1-p1)
   (:domain darp-v1)

   (:objects van1                                     - vehicle
             ana                                      - passenger
             garagem centro america                   - place)

   (:init
          (vehicle-at van1 garagem)

          (passenger-at ana america)  (destination ana centro)

          (= (travel-time centro garagem) 13) (= (travel-time garagem centro) 13)
          (= (travel-time america garagem) 9) (= (travel-time garagem america) 9)
          (= (travel-time america centro) 6) (= (travel-time centro america) 6)

          (= (total-cost) 0)
   )

   (:goal (and (served ana)))

   (:metric minimize (total-cost))
)
