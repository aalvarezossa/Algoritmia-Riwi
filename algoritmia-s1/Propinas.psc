Algoritmo Propinas
	
	Definir Personas Como Entero
	Definir  Cuenta, PorcPropina, Propina, Total, CadaUno Como Real
	
	Escribir '¿Cuál fue el total de la cuenta?'
	Leer Cuenta
	Escribir '¿Cuánto es el porcentaje de propina (%)?'
	Leer PorcPropina
	Escribir '¿Cuántas personas son?'
	Leer Personas
	
	Propina = Cuenta*(PorcPropina/100)
	Total = Cuenta+Propina
	CadaUno = Total/Personas
	
	Escribir 'A cada uno le corresponden: $', CadaUno
	
FinAlgoritmo
