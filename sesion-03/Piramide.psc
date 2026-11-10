Algoritmo Piramide
	Definir n, i, j, k Como Entero
	
	Escribir "Ingrese la altura de la pirámide:"
	Leer n
	
	Para i <- 1 Hasta n Con Paso 1 Hacer
		Para j <- 1 Hasta n - i Con Paso 1 Hacer
			Escribir Sin Saltar " "
		FinPara
		Para k <- 1 Hasta (2 * i - 1) Con Paso 1 Hacer
			Escribir Sin Saltar "*"
		FinPara
		Escribir ""
	FinPara
FinAlgoritmo
