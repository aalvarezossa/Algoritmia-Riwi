Algoritmo ValidarPIN
	Definir pinCorrecto, pinIngresado, intentos Como Entero
	Definir acceso Como Logico
	
	pinCorrecto <- 1234
	intentos <- 0
	acceso <- Falso
	
	Mientras intentos < 3 Y acceso = Falso Hacer
		Escribir "Ingrese su PIN (Intento ", intentos + 1, " de 3):"
		Leer pinIngresado
		
		Si pinIngresado = pinCorrecto Entonces
			acceso <- Verdadero
			Escribir "¡PIN correcto! Acceso concedido."
		SiNo
			intentos <- intentos + 1
			Si intentos < 3 Entonces
				Escribir "PIN incorrecto. Intente nuevamente."
			FinSi
		FinSi
	FinMientras
	
	Si acceso = Falso Entonces
		Escribir "Ha superado los 3 intentos. Sistema bloqueado."
	FinSi
FinAlgoritmo
