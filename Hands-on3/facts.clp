; Definición de los hechos iniciales del inventario
(deffacts inventario-inicial
   ; Smartphones disponibles en el inventario
   (smartphone (marca apple) (modelo iphone16) (color rojo) (precio 27000) (stock 50))
   (smartphone (marca samsung) (modelo note21) (color negro) (precio 23000) (stock 30))
   (smartphone (marca xiaomi) (modelo mi12) (color blanco) (precio 15000) (stock 40))
   
   ; Computadoras disponibles en el inventario
   (computadora (marca apple) (modelo macbookair) (color gris) (precio 27000) (stock 15))
   (computadora (marca apple) (modelo macbookpro) (color gris) (precio 47000) (stock 10))
   (computadora (marca dell) (modelo inspiron15) (color negro) (precio 19000) (stock 25))
   
   ; Accesorios disponibles en el inventario
   (accesorio (tipo funda) (marca apple) (precio 500) (stock 100))
   (accesorio (tipo mica) (marca apple) (precio 300) (stock 80))
   (accesorio (tipo cargador) (marca universal) (precio 600) (stock 60))
   
   ; Clientes registrados
   (cliente (nombre juan))
   (cliente (nombre ana))
   (cliente (nombre pedro))
   (cliente (nombre tania))
   
   ; Tarjetas de crédito registradas
   (tarjetacred (banco banamex) (grupo mastercard) (exp-date 01-12-25))
   (tarjetacred (banco bbva) (grupo visa) (exp-date 10-11-24))
   (tarjetacred (banco liverpool) (grupo visa) (exp-date 22-08-26))
   
   ; Vales disponibles para clientes
   (vale (cliente ana) (monto 300))
   
   ; Órdenes realizadas por los clientes
   (orden (cliente juan) (tipo-pago tarjeta) (banco bbva) (productos iphone16 macbookair) (cantidades 1 1))
   (orden (cliente ana) (tipo-pago efectivo) (productos note21 funda) (cantidades 12 3))
   (orden (cliente pedro) (tipo-pago vale) (productos mi12 cargador) (cantidades 1 1))
   (orden (cliente tania) (tipo-pago tarjeta) (banco banamex) (productos macbookpro) (cantidades 1))
)