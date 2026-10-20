; Um pedido: ana sai do america e vai para o centro.
; O veiculo comeca na garagem.

(define (problem darp-v0-1)
   (:domain darp-v0)

   (:objects van1                        - vehicle
             ana                         - passenger
             garagem america centro      - place)

   (:init (vehicle-at van1 garagem)
          (passenger-at ana america)
          (destination ana centro)
   )

   (:goal (served ana))
)

; Metric-FF:
; step    0: DRIVE VAN1 GARAGEM AMERICA
;         1: PICKUP ANA VAN1 AMERICA
;         2: DRIVE VAN1 AMERICA CENTRO
;         3: DROPOFF ANA VAN1 CENTRO
