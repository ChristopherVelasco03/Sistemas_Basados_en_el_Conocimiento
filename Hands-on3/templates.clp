;; Template para representar un smartphone
(deftemplate smartphone
   (slot marca)   ;; Marca del smartphone
   (slot modelo)  ;; Modelo del smartphone
   (slot color)   ;; Color del smartphone
   (slot precio)  ;; Precio del smartphone
   (slot stock)   ;; Stock disponible del smartphone
)

;; Template para representar una computadora
(deftemplate computadora
   (slot marca)   ;; Marca de la computadora
   (slot modelo)  ;; Modelo de la computadora
   (slot color)   ;; Color de la computadora
   (slot precio)  ;; Precio de la computadora
   (slot stock)   ;; Stock disponible de la computadora
)

;; Template para representar un accesorio
(deftemplate accesorio
   (slot tipo)    ;; Tipo de accesorio
   (slot marca)   ;; Marca del accesorio
   (slot precio)  ;; Precio del accesorio
   (slot stock)   ;; Stock disponible del accesorio
)

;; Template para representar un cliente
(deftemplate cliente
   (slot nombre)  ;; Nombre del cliente
)

;; Template para representar una tarjeta de crédito
(deftemplate tarjetacred
   (slot banco)    ;; Banco emisor de la tarjeta
   (slot grupo)    ;; Grupo o tipo de tarjeta
   (slot exp-date) ;; Fecha de expiración de la tarjeta
)

;; Template para representar un vale
(deftemplate vale
   (slot cliente) ;; Cliente asociado al vale
   (slot monto)   ;; Monto del vale
)

;; Template para representar un producto genérico
(deftemplate producto
   (slot tipo)    ;; Tipo de producto
   (slot marca)   ;; Marca del producto
   (slot modelo)  ;; Modelo del producto
   (slot color)   ;; Color del producto
   (slot precio)  ;; Precio del producto
)

;; Template para representar una orden de compra
(deftemplate orden
   (slot cliente)         ;; Cliente que realiza la orden
   (slot tipo-pago)       ;; Tipo de pago utilizado
   (slot banco) ;; Banco de la tarjeta usada si aplica
   (multislot productos)  ;; Lista de productos en la orden
   (multislot cantidades) ;; Lista de cantidades correspondientes a los productos
)   