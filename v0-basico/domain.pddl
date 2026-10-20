; DARP v0: um veiculo, um passageiro, sem custo.

(define (domain darp-v0)
(:requirements :strips :typing)

; ========================== Tipos ===========================

(:types vehicle passenger place)

; ======================== Predicados ========================

(:predicates (vehicle-at   ?v - vehicle   ?l - place)
             (passenger-at ?p - passenger ?l - place)
             (onboard      ?p - passenger ?v - vehicle)
             (served       ?p - passenger)
             (destination  ?p - passenger ?l - place)
)

; ========================== Ações ===========================

(:action drive
  :parameters   (?v - vehicle ?from ?to - place)
  :precondition (vehicle-at ?v ?from)
  :effect       (and (not (vehicle-at ?v ?from))
                     (vehicle-at ?v ?to))
)

(:action pickup
  :parameters   (?p - passenger ?v - vehicle ?l - place)
  :precondition (and (passenger-at ?p ?l)
                     (vehicle-at ?v ?l))
  :effect       (and (not (passenger-at ?p ?l))
                     (onboard ?p ?v))
)

(:action dropoff
  :parameters   (?p - passenger ?v - vehicle ?l - place)
  :precondition (and (onboard ?p ?v)
                     (vehicle-at ?v ?l)
                     (destination ?p ?l))
  :effect       (and (not (onboard ?p ?v))
                     (passenger-at ?p ?l)
                     (served ?p))
)

)
