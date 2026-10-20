; Os mesmos quatro pedidos do v2, agora com hora de saida.
; Tempo em minutos a partir das 7h: 0 = 7h00, 40 = 7h40.
;
;   ana    america  -> centro     7h10
;   bruno  bucarein -> iririu     7h00
;   carla  iririu   -> centro     7h40
;   diego  centro   -> america    7h25

(define (problem darp-v3-4pedidos)
   (:domain darp-v3)

   (:objects van carro                              - vehicle
             ana bruno carla diego                  - passenger
             garagem centro america bucarein iririu - place)

   (:init (vehicle-at van   garagem)
          (vehicle-at carro garagem)
          (= (capacity van) 3)    (= (seats-used van) 0)    (= (time van) 0)
          (= (capacity carro) 1)  (= (seats-used carro) 0)  (= (time carro) 0)

          (passenger-at ana   america)   (destination ana   centro)   (= (ready-at ana)   10)
          (passenger-at bruno bucarein)  (destination bruno iririu)   (= (ready-at bruno)  0)
          (passenger-at carla iririu)    (destination carla centro)   (= (ready-at carla) 40)
          (passenger-at diego centro)    (destination diego america)  (= (ready-at diego) 25)

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

; Metric-FF: custo 60 (da a volta em vez de esperar; o plano com wait custa 41)
