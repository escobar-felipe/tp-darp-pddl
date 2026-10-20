; DARP v3: hora de saida do pedido, com espera do veiculo.

(define (domain darp-v3)
(:requirements :strips :typing :fluents :equality)

; ========================== Tipos ===========================

(:types vehicle passenger place)

; ======================== Predicados ========================

(:predicates (vehicle-at   ?v - vehicle   ?l - place)
             (passenger-at ?p - passenger ?l - place)
             (onboard      ?p - passenger ?v - vehicle)
             (served       ?p - passenger)
             (destination  ?p - passenger ?l - place)
)

; ========================= Funções ==========================

(:functions (travel-time ?from ?to - place)
            (capacity    ?v - vehicle)
            (seats-used  ?v - vehicle)
            (time        ?v - vehicle)
            (ready-at    ?p - passenger)
            (total-cost)
            - number
)

; ========================== Ações ===========================

(:action drive
  :parameters   (?v - vehicle ?from ?to - place)
  :precondition (and (vehicle-at ?v ?from)
                     (not (= ?from ?to)))
  :effect       (and (not (vehicle-at ?v ?from))
                     (vehicle-at ?v ?to)
                     (increase (time ?v) (travel-time ?from ?to))
                     (increase (total-cost) (travel-time ?from ?to)))
)

(:action wait
  :parameters   (?v - vehicle ?p - passenger ?l - place)
  :precondition (and (vehicle-at ?v ?l)
                     (passenger-at ?p ?l)
                     (< (time ?v) (ready-at ?p)))
  :effect       (assign (time ?v) (ready-at ?p))
)

(:action pickup
  :parameters   (?p - passenger ?v - vehicle ?l - place)
  :precondition (and (passenger-at ?p ?l)
                     (vehicle-at ?v ?l)
                     (< (seats-used ?v) (capacity ?v))
                     (>= (time ?v) (ready-at ?p)))
  :effect       (and (not (passenger-at ?p ?l))
                     (onboard ?p ?v)
                     (increase (seats-used ?v) 1))
)

(:action dropoff
  :parameters   (?p - passenger ?v - vehicle ?l - place)
  :precondition (and (onboard ?p ?v)
                     (vehicle-at ?v ?l)
                     (destination ?p ?l))
  :effect       (and (not (onboard ?p ?v))
                     (passenger-at ?p ?l)
                     (served ?p)
                     (decrease (seats-used ?v) 1))
)

)
