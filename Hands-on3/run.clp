(deffunction iniciar-market ()
  (load "C:/Users/procr/Desktop/market/templates.clp")
  (load "C:/Users/procr/Desktop/market/rules.clp")
  (load "C:/Users/procr/Desktop/market/facts.clp")
  (reset)
  
  ;; Encabezado visual
  (printout t crlf "==============================" crlf)
  (printout t "   MARKET RECOMMENDER SYSTEM   " crlf)
  (printout t "==============================" crlf crlf)
  
  ;; Mensaje de datos cargados
  (printout t "=== Datos de mercado cargados ===" crlf)
  (printout t "Sistema listo para analizar órdenes de compra..." crlf crlf)
  
  ;; Mostrar hechos iniciales
  (printout t "=== HECHOS INICIALES ===" crlf)
  (facts)
  (printout t crlf "========================" crlf)
  
  ;; Iniciar análisis
  (printout t crlf "=== INICIANDO ANÁLISIS ===" crlf)
  (run)
  
  ;; Finalización del análisis
  (printout t crlf "=== ANÁLISIS FINALIZADO ===" crlf)
  (printout t "Gracias por usar el Market Recommender System." crlf)
)