; gerado por scripts/gerar.py -- nao editar a mao
; 3 pedidos, 1 veiculo(s), 5 lugares

(define (problem darp-v3-p3)
   (:domain darp-v3)

   (:objects van1                                     - vehicle
             ana bruno carla                          - passenger
             garagem centro america bucarein iririu   - place)

   (:init
          (vehicle-at van1 garagem)  (= (capacity van1) 3)  (= (seats-used van1) 0)  (= (time van1) 0)

          (passenger-at ana iririu)  (destination ana bucarein)  (= (ready-at ana) 45)
          (passenger-at bruno centro)  (destination bruno bucarein)  (= (ready-at bruno) 40)
          (passenger-at carla america)  (destination carla bucarein)  (= (ready-at carla) 30)

          (= (travel-time garagem iririu) 5) (= (travel-time iririu garagem) 5)
          (= (travel-time centro garagem) 16) (= (travel-time garagem centro) 16)
          (= (travel-time centro iririu) 14) (= (travel-time iririu centro) 14)
          (= (travel-time america garagem) 13) (= (travel-time garagem america) 13)
          (= (travel-time america centro) 15) (= (travel-time centro america) 15)
          (= (travel-time america bucarein) 14) (= (travel-time bucarein america) 14)
          (= (travel-time america iririu) 8) (= (travel-time iririu america) 8)
          (= (travel-time bucarein garagem) 7) (= (travel-time garagem bucarein) 7)
          (= (travel-time bucarein centro) 9) (= (travel-time centro bucarein) 9)
          (= (travel-time bucarein iririu) 8) (= (travel-time iririu bucarein) 8)

          (= (total-cost) 0)
   )

   (:goal (and (served ana) (served bruno) (served carla)))

   (:metric minimize (total-cost))
)
