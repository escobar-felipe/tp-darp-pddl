; Tres pedidos para o mesmo veiculo. Bairros de Joinville, tempos em minutos.
;
;   ana    america  -> centro
;   bruno  bucarein -> iririu
;   carla  iririu   -> centro

(define (problem darp-v1-3pedidos)
   (:domain darp-v1)

   (:objects van1                                   - vehicle
             ana bruno carla                        - passenger
             garagem centro america bucarein iririu - place)

   (:init (vehicle-at van1 garagem)

          (passenger-at ana   america)   (destination ana   centro)
          (passenger-at bruno bucarein)  (destination bruno iririu)
          (passenger-at carla iririu)    (destination carla centro)

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

   (:goal (and (served ana) (served bruno) (served carla)))

   (:metric minimize (total-cost))
)

; Os tres solvers dao respostas diferentes neste problema:
;   Metric-FF      custo 45
;   lama-first     custo 47
;   seq-opt-lmcut  custo 36  (otimo: garagem, bucarein, america, iririu, centro)
