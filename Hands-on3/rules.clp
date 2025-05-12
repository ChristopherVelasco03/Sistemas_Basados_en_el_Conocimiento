; 1. Regla que detecta si un cliente compró un combo de MacBook Air e iPhone 16.
(defrule combo-macbookair-iphone16
    (orden (cliente ?cname) (tipo-pago contado) (productos $?productos))
    (test (and (member$ macbookair ?productos) (member$ iphone16 ?productos)))
    =>
    (printout t "Combo detectado: MacBook Air + iPhone 16 para " ?cname "." crlf)
)

; 2. Regla que recomienda accesorios para clientes que compran un iPhone 16.
(defrule recomienda-accesorios-iphone16
    (orden (cliente ?cname) (productos $?productos))
    (test (member$ iphone16 ?productos))
    =>
    (printout t "Recomendación para " ?cname ": Agrega mica, funda o cargador para tu iPhone 16." crlf)
)

; 3. Regla que detecta si algún producto en la orden está sin stock.
(defrule sin-stock
    (orden (cliente ?cname) (productos $?productos))
    (or
        (not (smartphone (marca apple) (modelo iphone16) (stock ?s&:(> ?s 0))))
        (not (computadora (marca apple) (modelo macbookair) (stock ?s&:(> ?s 0)))))
    =>
    (printout t "Cliente " ?cname ", uno o más productos en su orden están sin stock." crlf)
)

; 4. Regla que detecta si un cliente realizó su compra con tarjeta Banamex.
(defrule descuento-banamex
   (orden (cliente ?cname) (tipo-pago tarjeta) (banco banamex))
   =>
   (printout t "Cliente " ?cname " recibe un 10% de descuento por pagar con tarjeta Banamex." crlf)
)

; 5. Regla que detecta si un cliente realizó su compra con tarjeta BBVA.
(defrule descuento-bbva
   (orden (cliente ?cname) (tipo-pago tarjeta) (banco bbva))
   =>
   (printout t "Cliente " ?cname " recibe un 10% de descuento por pagar con tarjeta BBVA." crlf)
)

; 6. Regla que informa si un cliente tiene un vale activo.
(defrule cliente-con-vale
    (vale (cliente ?cname) (monto ?m))
    =>
    (printout t "Cliente " ?cname " tiene un vale activo de $" ?m "." crlf)
)

; 7. Regla que clasifica una orden como costosa si incluye una MacBook Pro.
(defrule orden-costosa
    (orden (cliente ?cname) (productos $?productos))
    (test (member$ macbookpro ?productos))
    =>
    (printout t "Orden de " ?cname " es considerada de alto valor." crlf)
)

; 8. Regla que otorga un cargador gratis si se compra un iPhone 16 y una MacBook Air.
(defrule promo-cargador-gratis
    (orden (cliente ?cname) (productos $?productos))
    (test (and (member$ iphone16 ?productos) (member$ macbookair ?productos)))
    =>
    (printout t "¡Promoción! Cliente " ?cname " recibe un cargador gratis por comprar iPhone y MacBook." crlf)
    
    ;; Buscar y modificar el stock del cargador
    (do-for-fact ((?a accesorio)) 
        (eq ?a:tipo cargador)
        =>
        (bind ?nuevo-stock (- ?a:stock 1)) ; Reducir el stock en 1
        (modify ?a (stock ?nuevo-stock))
        (printout t "Nuevo stock para accesorio cargador: " ?nuevo-stock crlf)
    )
)

; 9. Regla que alerta si una tarjeta está vencida o por vencer.
(defrule tarjeta-vencida
    (tarjetacred (banco ?banco) (exp-date ?exp))
    (test (or (eq ?exp "10-11-24") (eq ?exp "01-01-24")))
    =>
    (printout t "Alerta: La tarjeta de " ?banco " está vencida o por vencer." crlf)
)

; 10. Regla que detecta si un cliente realizó una compra masiva (más de 2 productos).
(defrule compra-masiva
    (orden (cliente ?cname) (productos $?productos))
    (test (> (length$ ?productos) 2))
    =>
    (printout t "Cliente " ?cname " realizó una compra de varios productos." crlf)
)

; 11. Regla que recomienda adquirir seguro para clientes que compran una MacBook Pro.
(defrule recomienda-seguro
    (orden (cliente ?cname) (productos $?productos))
    (test (member$ macbookpro ?productos))
    =>
    (printout t "Recomendación para " ?cname ": considera adquirir seguro para tu MacBook Pro." crlf)
)

; 12. Regla que detecta si un cliente es frecuente (ha realizado 2 o más órdenes).
(defrule cliente-frecuente
    (declare (salience -10))
    (cliente (nombre ?cname))
    (orden (cliente ?cname))
    (test (>= (length$ (find-all-facts ((?o orden)) (eq ?o:cliente ?cname))) 2))
    =>
    (printout t "Cliente " ?cname " es cliente frecuente." crlf)
)

; 13. Regla que detecta si un cliente incluyó accesorios en su compra.
(defrule contiene-accesorio
    (orden (cliente ?cname) (productos $?productos))
    (test (or (member$ funda ?productos) (member$ mica ?productos) (member$ cargador ?productos)))
    =>
    (printout t "Cliente " ?cname " incluyó accesorios en su compra." crlf)
)

; 14. Regla que actualiza el stock de productos después de una compra.
(defrule actualizar-stock
   ?orden <- (orden (cliente ?nombre) (productos $?productos) (cantidades $?cantidades))
   =>
   (bind ?i 1)
   (while (and (> (length$ ?productos) 0) (> (length$ ?cantidades) 0)) do
      (bind ?producto (nth$ 1 ?productos))
      (bind ?cantidad (nth$ 1 ?cantidades))

      ;; Buscar y modificar smartphones
      (do-for-fact ((?s smartphone)) 
         (eq ?s:modelo ?producto)
         => 
         (bind ?nuevo-stock (- ?s:stock ?cantidad))
         (modify ?s (stock ?nuevo-stock))
         (printout t "Nuevo stock para smartphone " ?producto ": " ?nuevo-stock crlf)
      )

      ;; Buscar y modificar computadoras
      (do-for-fact ((?c computadora)) 
         (eq ?c:modelo ?producto)
         => 
         (bind ?nuevo-stock (- ?c:stock ?cantidad))
         (modify ?c (stock ?nuevo-stock))
         (printout t "Nuevo stock para computadora " ?producto ": " ?nuevo-stock crlf)
      )
        ;; Buscar y modificar accesorios
        (do-for-fact ((?a accesorio)) 
             (eq ?a:tipo ?producto)
             => 
             (bind ?nuevo-stock (- ?a:stock ?cantidad))
             (modify ?a (stock ?nuevo-stock))
             (printout t "Nuevo stock para accesorio " ?producto ": " ?nuevo-stock crlf)
        )

      ;; Avanzar listas
      (bind ?productos (rest$ ?productos))
      (bind ?cantidades (rest$ ?cantidades))
   )
)

; 15. Regla que imprime los productos comprados por un cliente.
(defrule imprimir-productos-comprados
   (orden (cliente ?cname) (productos $?productos) (cantidades $?cantidades))
   =>
   (printout t "Cliente " ?cname " compró:" crlf)
   (bind ?num (length$ ?productos))
   (loop-for-count (?i 1 ?num)
      (bind ?prod (nth$ ?i ?productos))
      (bind ?cant (nth$ ?i ?cantidades))
      (printout t "- " ?cant " unidad(es) de " ?prod crlf)
   )
)

; 16. Regla que clasifica a un cliente como menudista si compró 10 o menos productos en total.
(defrule cliente-menudista
    (orden (cliente ?cname) (productos $?productos) (cantidades $?cantidades))
    =>
    (bind ?total 0)
    (foreach ?cantidad ?cantidades
        (bind ?total (+ ?total ?cantidad))
    )
    (if (<= ?total 10) then
        (printout t "Cliente " ?cname " es menudista." crlf)
    )
)

; 17. Regla que clasifica a un cliente como mayorista si compró más de 10 productos en total.
(defrule cliente-mayorista
    (orden (cliente ?cname) (productos $?productos) (cantidades $?cantidades))
    =>
    (bind ?total 0)
    (foreach ?cantidad ?cantidades
        (bind ?total (+ ?total ?cantidad))
    )
    (if (> ?total 10) then
        (printout t "Cliente " ?cname " es mayorista." crlf)
    )
)

; 18. Regla compra-unica que detecta si un cliente compró un solo producto.
(defrule compra-unica
    (orden (cliente ?cname) (productos $?productos))
    (test (= (length$ ?productos) 1))
    =>
    (printout t "Cliente " ?cname " realizó una compra de un solo producto." crlf)
)

; 19. Regla que no incluye accesorios en la compra.
(defrule no-contiene-accesorio
    (orden (cliente ?cname) (productos $?productos))
    (test (not (or (member$ funda ?productos) (member$ mica ?productos) (member$ cargador ?productos))))
    =>
    (printout t "Cliente " ?cname " no incluyó accesorios en su compra." crlf)
)

; 20. Regla que menciona el tipo de pago utilizado por el cliente.
(defrule pago-en-efectivo
    (orden (cliente ?cname) (tipo-pago efectivo))
    =>
    (printout t "Cliente " ?cname " realizó su compra con pago en efectivo." crlf)
)