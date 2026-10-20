; gerado por scripts/gerar.py -- nao editar a mao
; 4 pedidos, 2 veiculo(s), 6 lugares

(define (problem darp-v2-p4)
   (:domain darp-v2)

   (:objects van1 van2                                - vehicle
             ana bruno carla diego                    - passenger
             garagem centro america bucarein iririu costa-e-silva - place)

   (:init
          (vehicle-at van1 garagem)  (= (capacity van1) 3)  (= (seats-used van1) 0)
          (vehicle-at van2 garagem)  (= (capacity van2) 1)  (= (seats-used van2) 0)

          (passenger-at ana america)  (destination ana costa-e-silva)
          (passenger-at bruno centro)  (destination bruno costa-e-silva)
          (passenger-at carla centro)  (destination carla america)
          (passenger-at diego costa-e-silva)  (destination diego bucarein)

          (= (travel-time garagem iririu) 5) (= (travel-time iririu garagem) 5)
          (= (travel-time centro garagem) 18) (= (travel-time garagem centro) 18)
          (= (travel-time centro iririu) 18) (= (travel-time iririu centro) 18)
          (= (travel-time centro costa-e-silva) 21) (= (travel-time costa-e-silva centro) 21)
          (= (travel-time america garagem) 18) (= (travel-time garagem america) 18)
          (= (travel-time america centro) 1) (= (travel-time centro america) 1)
          (= (travel-time america bucarein) 11) (= (travel-time bucarein america) 11)
          (= (travel-time america iririu) 18) (= (travel-time iririu america) 18)
          (= (travel-time america costa-e-silva) 22) (= (travel-time costa-e-silva america) 22)
          (= (travel-time bucarein garagem) 8) (= (travel-time garagem bucarein) 8)
          (= (travel-time bucarein centro) 11) (= (travel-time centro bucarein) 11)
          (= (travel-time bucarein iririu) 11) (= (travel-time iririu bucarein) 11)
          (= (travel-time bucarein costa-e-silva) 12) (= (travel-time costa-e-silva bucarein) 12)
          (= (travel-time costa-e-silva garagem) 4) (= (travel-time garagem costa-e-silva) 4)
          (= (travel-time costa-e-silva iririu) 5) (= (travel-time iririu costa-e-silva) 5)

          (= (total-cost) 0)
   )

   (:goal (and (served ana) (served bruno) (served carla) (served diego)))

   (:metric minimize (total-cost))
)
