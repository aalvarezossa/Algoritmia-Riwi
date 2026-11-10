Algoritmo FacturaRestaurante
	Definir subtotal, impuesto, propina Como Real
	subtotal <- LeerPedido
	impuesto <- CalcularPorcentaje(subtotal, 8)
	propina <- CalcularPorcentaje(subtotal, 10)
	ImprimirFactura(subtotal, impuesto, propina)
FinAlgoritmo

SubProceso totalPedido <- LeerPedido
	Definir precio, cantidad, totalPedido Como Real
	totalPedido <- 0
	Escribir "Ingrese el precio del plato (0 para terminar):"
	Leer precio
	Mientras precio <> 0 Hacer
		Escribir "Ingrese la cantidad:"
		Leer cantidad
		totalPedido <- totalPedido + (precio * cantidad)
		Escribir "Ingrese el siguiente precio del plato (0 para terminar):"
		Leer precio
	FinMientras
FinSubProceso

SubProceso resultado <- CalcularPorcentaje(base, porcentaje)
	Definir resultado Como Real
	resultado <- (base * porcentaje) / 100
FinSubProceso

SubProceso ImprimirFactura(subtotal, impuesto, propina)
	Definir totalFinal Como Real
	totalFinal <- subtotal + impuesto + propina
	Escribir "Subtotal: $", subtotal
	Escribir "Impuesto (8%): $", impuesto
	Escribir "Propina (10%): $", propina
	Escribir "TOTAL A PAGAR: $", totalFinal
FinSubProceso
