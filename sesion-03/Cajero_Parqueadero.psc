Algoritmo CajeroParqueadero
	Definir valor, total, carros Como Entero
	
	total <- 0
	carros <- 0
	
	Escribir "Ingrese el valor del parqueadero (0 para terminar):"
	Leer valor
	
	Mientras valor <> 0 Hacer
		total <- total + valor
		carros <- carros + 1
		
		Escribir "Ingrese el valor del siguiente carro (0 para terminar):"
		Leer valor
	FinMientras
	
	Escribir "Total recaudado: $", total
	Escribir "Cantidad de carros: ", carros
FinAlgoritmo
