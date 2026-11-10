Algoritmo ValidarRegistro
	Definir Edad Como Entero
	Definir Respuesta Como Caracter
	Escribir "¿Cuántos años tienes?"
	Leer Edad
	Escribir "¿Aceptas los términos? (S/N)"
	Leer Respuesta
	Respuesta <- Mayusculas(Respuesta)
	Si edad >= 14 Y Respuesta = "S" Entonces
		Escribir "Registro exitoso."
	SiNo
		Escribir "No puedes registrarte."
	FinSi
FinAlgoritmo
