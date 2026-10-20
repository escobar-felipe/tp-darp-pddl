; Quatro pedidos e dois veiculos: a van leva tres pessoas, o carro leva uma.
;
;   ana    america  -> centro
;   bruno  bucarein -> iririu
;   carla  iririu   -> centro
;   diego  centro   -> america

(define (problem darp-v2-4pedidos)
   (:domain darp-v2)

   (:objects van carro                              - vehicle
             ana bruno carla diego                  - passenger
             garagem centro america bucarein iririu - place)

   (:init (vehicle-at van   garagem)
          (vehicle-at carro garagem)
          (= (capacity van) 3)    (= (seats-used van) 0)
          (= (capacity carro) 1)  (= (seats-used carro) 0)

          (passenger-at ana   america)   (destination ana   centro)
          (passenger-at bruno bucarein)  (destination bruno iririu)
          (passenger-at carla iririu)    (destination carla centro)
          (passenger-at diego centro)    (destination diego america)

          (= (travel-time garagem  centro)   10) (= (travel-time centro   garagem)  10)
          (= (travel-time garagem  america)  12) (= (travel-time america  garagem)  12)
          (= (travel-time garagem  bucarein)  8) (= (travel-time bucarein garagem)   8)
          (= (travel-time garagem  iririu)   15) (= (travel-time iririu   garagem)  15)
          (= (travel-time centro   america)   5) (= (travel-time america  centro)    5)
          (= (travel-time centro   bucarein)  4) (= (travel-time bucarein centro)    4)
          (= (travel-time centro   iririu)   12) (= (travel-time iririu   centro)   12)
          (= (travel-time america  bucarein)  7) (= (travel-time bucarein america)   7)
          (= (travel-time america  iririu)    9) (= (travel-time iririu   america)   9)
          (= (travel-time bucarein iririu)   14) (= (travel-time iririu   bucarein) 14)

          (= (total-cost) 0)
   )

   (:goal (and (served ana) (served bruno) (served carla) (served diego)))

   (:metric minimize (total-cost))
)
