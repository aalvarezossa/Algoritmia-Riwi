Algoritmo Parqueadero
	Definir tipo, minutos, horas Como Entero
	Definir tarifa, total Como Real
	Definir factura Como Caracter
	Escribir "Tipo de vehículo (1 = carro, 2 = moto): "
	Leer tipo
	Escribir "Minutos de permanencia: "
	Leer minutos
	Escribir "¿Tiene factura de compra? (S/N): "
	Leer factura
	factura <- Mayusculas(factura)
	Si minutos < 0 Entonces
		Escribir "Los minutos no pueden ser negativos."
	SiNo
		Segun tipo Hacer
			1:
				tarifa <- 4000
			2:
				tarifa <- 2000
			De Otro Modo:
				tarifa <- 0
		FinSegun
		Si tarifa = 0 Entonces
			Escribir "Tipo de vehículo no válido"
		SiNo
			Si minutos <= 15 Entonces
				total <- 0
			SiNo
				horas <- trunc((minutos+59)/60)
				total <- horas * tarifa
				Si total > 30000 Entonces
					total <- 30000
				FinSi
				Si factura = "S" Entonces
					total <- total / 2
				FinSi
			FinSi
			Escribir "El valor a pagar es: $", total
		FinSi
	FinSi
FinAlgoritmo
