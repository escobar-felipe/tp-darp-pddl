; gerado por scripts/gerar.py -- nao editar a mao
; 5 pedidos, 2 veiculo(s), 7 lugares

(define (problem darp-v2-p5)
   (:domain darp-v2)

   (:objects van1 van2                                - vehicle
             ana bruno carla diego elena              - passenger
             garagem centro america bucarein iririu costa-e-silva boa-vista - place)

   (:init
          (vehicle-at van1 garagem)  (= (capacity van1) 3)  (= (seats-used van1) 0)
          (vehicle-at van2 garagem)  (= (capacity van2) 1)  (= (seats-used van2) 0)

          (passenger-at ana bucarein)  (destination ana boa-vista)
          (passenger-at bruno centro)  (destination bruno america)
          (passenger-at carla bucarein)  (destination carla iririu)
          (passenger-at diego costa-e-silva)  (destination diego america)
          (passenger-at elena bucarein)  (destination elena iririu)

          (= (travel-time garagem iririu) 6) (= (travel-time iririu garagem) 6)
          (= (travel-time centro garagem) 9) (= (travel-time garagem centro) 9)
          (= (travel-time centro iririu) 9) (= (travel-time iririu centro) 9)
          (= (travel-time centro costa-e-silva) 9) (= (travel-time costa-e-silva centro) 9)
          (= (travel-time america garagem) 12) (= (travel-time garagem america) 12)
          (= (travel-time america centro) 12) (= (travel-time centro america) 12)
          (= (travel-time america bucarein) 6) (= (travel-time bucarein america) 6)
          (= (travel-time america iririu) 6) (= (travel-time iririu america) 6)
          (= (travel-time america costa-e-silva) 7) (= (travel-time costa-e-silva america) 7)
          (= (travel-time america boa-vista) 22) (= (travel-time boa-vista america) 22)
          (= (travel-time bucarein garagem) 7) (= (travel-time garagem bucarein) 7)
          (= (travel-time bucarein centro) 12) (= (travel-time centro bucarein) 12)
          (= (travel-time bucarein iririu) 3) (= (travel-time iririu bucarein) 3)
          (= (travel-time bucarein costa-e-silva) 3) (= (travel-time costa-e-silva bucarein) 3)
          (= (travel-time costa-e-silva garagem) 5) (= (travel-time garagem costa-e-silva) 5)
          (= (travel-time costa-e-silva iririu) 1) (= (travel-time iririu costa-e-silva) 1)
          (= (travel-time boa-vista garagem) 14) (= (travel-time garagem boa-vista) 14)
          (= (travel-time boa-vista centro) 9) (= (travel-time centro boa-vista) 9)
          (= (travel-time boa-vista bucarein) 20) (= (travel-time bucarein boa-vista) 20)
          (= (travel-time boa-vista iririu) 17) (= (travel-time iririu boa-vista) 17)
          (= (travel-time boa-vista costa-e-silva) 17) (= (travel-time costa-e-silva boa-vista) 17)

          (= (total-cost) 0)
   )

   (:goal (and (served ana) (served bruno) (served carla) (served diego) (served elena)))

   (:metric minimize (total-cost))
)
