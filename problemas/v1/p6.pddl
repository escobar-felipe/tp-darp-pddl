; gerado por scripts/gerar.py -- nao editar a mao
; 6 pedidos, 1 veiculo(s), 8 lugares

(define (problem darp-v1-p6)
   (:domain darp-v1)

   (:objects van1                                     - vehicle
             ana bruno carla diego elena fabio        - passenger
             garagem centro america bucarein iririu costa-e-silva boa-vista gloria - place)

   (:init
          (vehicle-at van1 garagem)

          (passenger-at ana bucarein)  (destination ana america)
          (passenger-at bruno costa-e-silva)  (destination bruno iririu)
          (passenger-at carla iririu)  (destination carla boa-vista)
          (passenger-at diego boa-vista)  (destination diego america)
          (passenger-at elena bucarein)  (destination elena costa-e-silva)
          (passenger-at fabio centro)  (destination fabio bucarein)

          (= (travel-time garagem iririu) 8) (= (travel-time iririu garagem) 8)
          (= (travel-time garagem gloria) 15) (= (travel-time gloria garagem) 15)
          (= (travel-time centro garagem) 8) (= (travel-time garagem centro) 8)
          (= (travel-time centro iririu) 10) (= (travel-time iririu centro) 10)
          (= (travel-time centro costa-e-silva) 15) (= (travel-time costa-e-silva centro) 15)
          (= (travel-time centro gloria) 17) (= (travel-time gloria centro) 17)
          (= (travel-time america garagem) 18) (= (travel-time garagem america) 18)
          (= (travel-time america centro) 19) (= (travel-time centro america) 19)
          (= (travel-time america bucarein) 18) (= (travel-time bucarein america) 18)
          (= (travel-time america iririu) 10) (= (travel-time iririu america) 10)
          (= (travel-time america costa-e-silva) 5) (= (travel-time costa-e-silva america) 5)
          (= (travel-time america boa-vista) 7) (= (travel-time boa-vista america) 7)
          (= (travel-time america gloria) 4) (= (travel-time gloria america) 4)
          (= (travel-time bucarein garagem) 7) (= (travel-time garagem bucarein) 7)
          (= (travel-time bucarein centro) 15) (= (travel-time centro bucarein) 15)
          (= (travel-time bucarein iririu) 11) (= (travel-time iririu bucarein) 11)
          (= (travel-time bucarein costa-e-silva) 13) (= (travel-time costa-e-silva bucarein) 13)
          (= (travel-time bucarein gloria) 14) (= (travel-time gloria bucarein) 14)
          (= (travel-time costa-e-silva garagem) 13) (= (travel-time garagem costa-e-silva) 13)
          (= (travel-time costa-e-silva iririu) 5) (= (travel-time iririu costa-e-silva) 5)
          (= (travel-time costa-e-silva gloria) 2) (= (travel-time gloria costa-e-silva) 2)
          (= (travel-time boa-vista garagem) 15) (= (travel-time garagem boa-vista) 15)
          (= (travel-time boa-vista centro) 13) (= (travel-time centro boa-vista) 13)
          (= (travel-time boa-vista bucarein) 18) (= (travel-time bucarein boa-vista) 18)
          (= (travel-time boa-vista iririu) 7) (= (travel-time iririu boa-vista) 7)
          (= (travel-time boa-vista costa-e-silva) 7) (= (travel-time costa-e-silva boa-vista) 7)
          (= (travel-time boa-vista gloria) 8) (= (travel-time gloria boa-vista) 8)
          (= (travel-time gloria iririu) 8) (= (travel-time iririu gloria) 8)

          (= (total-cost) 0)
   )

   (:goal (and (served ana) (served bruno) (served carla) (served diego) (served elena) (served fabio)))

   (:metric minimize (total-cost))
)
