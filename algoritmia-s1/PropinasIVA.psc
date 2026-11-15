Algoritmo Propinas
	
	Definir Personas Como Entero
	Definir  Total, PorcPropina, Propina, Subtotal, CadaUno, IVA, TotalNeto Como Real
	
	Escribir '¿Cuál fue el total de la cuenta?'
	Leer Total
	Escribir '¿Cuánto es el porcentaje de propina (%)?'
	Leer PorcPropina
	Escribir '¿Cuántas personas son?'
	Leer Personas
	
	Subtotal = Total/1.19
	IVA = Subtotal*(19/100)
	Propina = Subtotal*(PorcPropina/100)
	TotalNeto = Subtotal+Propina+IVA
	CadaUno = TotalNeto/Personas
	
	Escribir "El subtotal es: $", Subtotal
	Escribir "El IVA es: $", IVA
	Escribir "El total neto es: $" TotalNeto
	Escribir 'A cada uno le corresponden: $', CadaUno
	
FinAlgoritmo
