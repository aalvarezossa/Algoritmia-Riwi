# Tablas de traza y salida final

Prueba de escritorio de cinco algoritmos en PSeInt (`.psc`). Para cada archivo se incluye:

1. Código
2. Datos de entrada usados en la prueba
3. Tabla de traza (estado de las variables paso a paso)
4. Salida final en pantalla

> **Nota:** los archivos no traen datos de entrada, así que se eligieron valores de prueba (indicados en cada sección). Las trazas se hicieron a mano sobre el código, sin ejecutarlo en PSeInt.
>
> **Notación:** `V` = verdadero, `F` = falso, `—` = no cambia / no aplica.

| # | Archivo | Algoritmo | Estructura principal |
|:-:|---|---|---|
| 1 | `Cajero_Parqueadero.psc` | CajeroParqueadero | `Mientras` con centinela |
| 2 | `ValidarPIN.psc` | ValidarPIN | `Mientras` con intentos y bandera |
| 3 | `Calificaciones.psc` | Calificaciones | `Para` con acumulador, contador, máx/mín y bandera |
| 4 | `FacturaRestaurante.psc` | FacturaRestaurante | `SubProceso` (funciones y procedimientos) |
| 5 | `Piramide.psc` | Piramide | `Para` anidados |

---

## 1. `Cajero_Parqueadero.psc` — Cajero de parqueadero

### Código

```pseint
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
```

### Escenario A: tres carros

**Entradas:** `5000`, `3000`, `7000`, `0` (el 0 termina)

| Paso | Instrucción | `valor` | `valor <> 0` | `total` | `carros` |
|:-:|---|:-:|:-:|:-:|:-:|
| 1 | Inicialización | ? | — | 0 | 0 |
| 2 | `Leer valor` (primer dato) | 5000 | — | 0 | 0 |
| 3 | Condición del `Mientras` | 5000 | V | 0 | 0 |
| 4 | Acumular (iteración 1) | 5000 | — | 5000 | 1 |
| 5 | `Leer valor` | 3000 | — | 5000 | 1 |
| 6 | Condición del `Mientras` | 3000 | V | 5000 | 1 |
| 7 | Acumular (iteración 2) | 3000 | — | 8000 | 2 |
| 8 | `Leer valor` | 7000 | — | 8000 | 2 |
| 9 | Condición del `Mientras` | 7000 | V | 8000 | 2 |
| 10 | Acumular (iteración 3) | 7000 | — | 15000 | 3 |
| 11 | `Leer valor` | 0 | — | 15000 | 3 |
| 12 | Condición del `Mientras` | 0 | **F** → sale | 15000 | 3 |

**Salida final:**

```
Total recaudado: $15000
Cantidad de carros: 3
```

### Escenario B: sin carros

**Entradas:** `0`

| Paso | Instrucción | `valor` | `valor <> 0` | `total` | `carros` |
|:-:|---|:-:|:-:|:-:|:-:|
| 1 | Inicialización | ? | — | 0 | 0 |
| 2 | `Leer valor` | 0 | — | 0 | 0 |
| 3 | Condición del `Mientras` | 0 | **F** → no entra | 0 | 0 |

**Salida final:**

```
Total recaudado: $0
Cantidad de carros: 0
```

---

## 2. `ValidarPIN.psc` — Validación de PIN con 3 intentos

### Código

```pseint
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
```

### Escenario A: acierta en el tercer intento

**Entradas:** `1111`, `2222`, `1234`

| Paso | `intentos` | `acceso` | Condición `intentos < 3 Y acceso = Falso` | `pinIngresado` | `pin = 1234` | Salida |
|:-:|:-:|:-:|:-:|:-:|:-:|---|
| 0 | 0 | F | — | ? | — | — |
| 1 | 0 | F | V Y V = **V** | 1111 | F | `Ingrese su PIN (Intento 1 de 3):` |
| 1b | 1 | F | — | 1111 | — | `PIN incorrecto. Intente nuevamente.` |
| 2 | 1 | F | V Y V = **V** | 2222 | F | `Ingrese su PIN (Intento 2 de 3):` |
| 2b | 2 | F | — | 2222 | — | `PIN incorrecto. Intente nuevamente.` |
| 3 | 2 | F | V Y V = **V** | 1234 | **V** | `Ingrese su PIN (Intento 3 de 3):` |
| 3b | 2 | **V** | — | 1234 | — | `¡PIN correcto! Acceso concedido.` |
| 4 | 2 | V | V Y F = **F** → sale | — | — | — |
| 5 | 2 | V | `acceso = Falso` → F | — | — | (no muestra nada) |

**Salida final:**

```
Ingrese su PIN (Intento 1 de 3):
PIN incorrecto. Intente nuevamente.
Ingrese su PIN (Intento 2 de 3):
PIN incorrecto. Intente nuevamente.
Ingrese su PIN (Intento 3 de 3):
¡PIN correcto! Acceso concedido.
```

### Escenario B: sistema bloqueado

**Entradas:** `1111`, `2222`, `3333`

| Paso | `intentos` | `acceso` | Condición `intentos < 3 Y acceso = Falso` | `pinIngresado` | `pin = 1234` | Salida |
|:-:|:-:|:-:|:-:|:-:|:-:|---|
| 0 | 0 | F | — | ? | — | — |
| 1 | 0 | F | **V** | 1111 | F | `Ingrese su PIN (Intento 1 de 3):` |
| 1b | 1 | F | — | 1111 | — | `PIN incorrecto. Intente nuevamente.` |
| 2 | 1 | F | **V** | 2222 | F | `Ingrese su PIN (Intento 2 de 3):` |
| 2b | 2 | F | — | 2222 | — | `PIN incorrecto. Intente nuevamente.` |
| 3 | 2 | F | **V** | 3333 | F | `Ingrese su PIN (Intento 3 de 3):` |
| 3b | 3 | F | — | 3333 | — | (como `3 < 3` es F, **no** muestra "PIN incorrecto") |
| 4 | 3 | F | F Y V = **F** → sale | — | — | — |
| 5 | 3 | F | `acceso = Falso` → **V** | — | — | `Ha superado los 3 intentos. Sistema bloqueado.` |

**Salida final:**

```
Ingrese su PIN (Intento 1 de 3):
PIN incorrecto. Intente nuevamente.
Ingrese su PIN (Intento 2 de 3):
PIN incorrecto. Intente nuevamente.
Ingrese su PIN (Intento 3 de 3):
Ha superado los 3 intentos. Sistema bloqueado.
```

---

## 3. `Calificaciones.psc` — Estadísticas de 5 notas

### Código

```pseint
Algoritmo Calificaciones
	Definir i Como Entero
	Definir nota, suma, notaAlta, notaBaja Como Real
	Definir aprobados Como Entero
	Definir alguienPerdio Como Logico
	suma <- 0
	aprobados <- 0
	alguienPerdio <- Falso
	Para i <- 1 Hasta 5 Con Paso 1 Hacer
		Escribir "Ingrese la nota del estudiante ", i, " (de 1.0 a 5.0):"
		Leer nota
		suma <- suma + nota
		Si nota >= 3.0 Entonces
			aprobados <- aprobados + 1
		SiNo
			alguienPerdio <- Verdadero
		FinSi
		Si i = 1 Entonces
			notaAlta <- nota
			notaBaja <- nota
		SiNo
			Si nota > notaAlta Entonces
				notaAlta <- nota
			FinSi
			Si nota < notaBaja Entonces
				notaBaja <- nota
			FinSi
		FinSi
	FinPara
	Escribir "----------------------------------------"
	Escribir "PROMEDIO (Acumulador): ", suma / 5
	Escribir "CANTIDAD QUE APROBARON (Contador): ", aprobados
	Escribir "NOTA MÁS ALTA (Máximo): ", notaAlta
	Escribir "NOTA MÁS BAJA (Mínimo): ", notaBaja
	Si alguienPerdio Entonces
		Escribir "¿ALGUIEN PERDIó? (Bandera): Sí"
	SiNo
		Escribir "¿ALGUIEN PERDIó? (Bandera): No"
	FinSi
FinAlgoritmo
```

### Escenario A: hay reprobados

**Entradas:** `4.5`, `2.5`, `3.0`, `5.0`, `1.5`

| `i` | `nota` | `suma` | `nota >= 3.0` | `aprobados` | `alguienPerdio` | `notaAlta` | `notaBaja` | Observación |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|
| inicio | ? | 0 | — | 0 | F | ? | ? | — |
| 1 | 4.5 | 4.5 | V | 1 | F | 4.5 | 4.5 | `i = 1`: inicializa máx. y mín. |
| 2 | 2.5 | 7.0 | F | 1 | **V** | 4.5 | **2.5** | `2.5 < 4.5` → nuevo mínimo |
| 3 | 3.0 | 10.0 | V | 2 | V | 4.5 | 2.5 | 3.0 aprueba (límite); no cambia máx. ni mín. |
| 4 | 5.0 | 15.0 | V | 3 | V | **5.0** | 2.5 | `5.0 > 4.5` → nuevo máximo |
| 5 | 1.5 | 16.5 | F | 3 | V | 5.0 | **1.5** | `1.5 < 2.5` → nuevo mínimo |

Cálculo final: promedio = 16.5 / 5 = **3.3**

**Salida final:**

```
----------------------------------------
PROMEDIO (Acumulador): 3.3
CANTIDAD QUE APROBARON (Contador): 3
NOTA MÁS ALTA (Máximo): 5
NOTA MÁS BAJA (Mínimo): 1.5
¿ALGUIEN PERDIó? (Bandera): Sí
```

### Escenario B: todos aprueban

**Entradas:** `3.0`, `4.0`, `5.0`, `3.5`, `4.5`

| `i` | `nota` | `suma` | `nota >= 3.0` | `aprobados` | `alguienPerdio` | `notaAlta` | `notaBaja` | Observación |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|
| inicio | ? | 0 | — | 0 | F | ? | ? | — |
| 1 | 3.0 | 3.0 | V | 1 | F | 3.0 | 3.0 | Inicializa máx. y mín. |
| 2 | 4.0 | 7.0 | V | 2 | F | **4.0** | 3.0 | Nuevo máximo |
| 3 | 5.0 | 12.0 | V | 3 | F | **5.0** | 3.0 | Nuevo máximo |
| 4 | 3.5 | 15.5 | V | 4 | F | 5.0 | 3.0 | Sin cambios |
| 5 | 4.5 | 20.0 | V | 5 | F | 5.0 | 3.0 | Sin cambios |

Cálculo final: promedio = 20 / 5 = **4**

**Salida final:**

```
----------------------------------------
PROMEDIO (Acumulador): 4
CANTIDAD QUE APROBARON (Contador): 5
NOTA MÁS ALTA (Máximo): 5
NOTA MÁS BAJA (Mínimo): 3
¿ALGUIEN PERDIó? (Bandera): No
```

> El texto `PERDIó` (con "ó" minúscula) se reproduce tal como está escrito en el código. PSeInt muestra los números reales sin ceros sobrantes (`5` en lugar de `5.0`).

---

## 4. `FacturaRestaurante.psc` — Factura con subprocesos

### Código

```pseint
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
```

### Escenario A: pedido con dos platos

**Entradas:** precio `10000` × cantidad `2`; precio `5000` × cantidad `1`; precio `0` (termina)

**Traza 1: subproceso `LeerPedido`**

| Paso | Instrucción | `precio` | `precio <> 0` | `cantidad` | `totalPedido` |
|:-:|---|:-:|:-:|:-:|:-:|
| 1 | `totalPedido <- 0` | ? | — | ? | 0 |
| 2 | `Leer precio` | 10000 | — | ? | 0 |
| 3 | Condición del `Mientras` | 10000 | V | ? | 0 |
| 4 | `Leer cantidad` | 10000 | — | 2 | 0 |
| 5 | `totalPedido + (10000 × 2)` | 10000 | — | 2 | 20000 |
| 6 | `Leer precio` | 5000 | — | 2 | 20000 |
| 7 | Condición del `Mientras` | 5000 | V | 2 | 20000 |
| 8 | `Leer cantidad` | 5000 | — | 1 | 20000 |
| 9 | `totalPedido + (5000 × 1)` | 5000 | — | 1 | 25000 |
| 10 | `Leer precio` | 0 | — | 1 | 25000 |
| 11 | Condición del `Mientras` | 0 | **F** → sale | 1 | 25000 |
| 12 | Retorna `totalPedido` | — | — | — | **25000** |

**Traza 2: programa principal y subprocesos restantes**

| Paso | Llamada / instrucción | Parámetros | Resultado | `subtotal` | `impuesto` | `propina` | `totalFinal` |
|:-:|---|---|---|:-:|:-:|:-:|:-:|
| 1 | `subtotal <- LeerPedido` | — | 25000 | **25000** | ? | ? | ? |
| 2 | `CalcularPorcentaje(subtotal, 8)` | base = 25000, porcentaje = 8 | (25000 × 8) / 100 = 2000 | 25000 | **2000** | ? | ? |
| 3 | `CalcularPorcentaje(subtotal, 10)` | base = 25000, porcentaje = 10 | (25000 × 10) / 100 = 2500 | 25000 | 2000 | **2500** | ? |
| 4 | `ImprimirFactura(...)` | 25000, 2000, 2500 | 25000 + 2000 + 2500 = 29500 | 25000 | 2000 | 2500 | **29500** |

**Salida final:**

```
Subtotal: $25000
Impuesto (8%): $2000
Propina (10%): $2500
TOTAL A PAGAR: $29500
```

### Escenario B: pedido vacío

**Entradas:** precio `0`

| Paso | Instrucción | `precio` | `precio <> 0` | `totalPedido` |
|:-:|---|:-:|:-:|:-:|
| 1 | `totalPedido <- 0` | ? | — | 0 |
| 2 | `Leer precio` | 0 | — | 0 |
| 3 | Condición del `Mientras` | 0 | **F** → no entra | 0 |
| 4 | Retorna `totalPedido` | — | — | **0** |

Con subtotal = 0: impuesto = (0 × 8) / 100 = 0, propina = 0 y total = 0.

**Salida final:**

```
Subtotal: $0
Impuesto (8%): $0
Propina (10%): $0
TOTAL A PAGAR: $0
```

---

## 5. `Piramide.psc` — Pirámide de asteriscos

### Código

```pseint
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
```

En cada fila `i` se imprimen `n - i` espacios y luego `2i - 1` asteriscos. El `Escribir ""` final solo hace el salto de línea.

### Escenario A: altura 4

**Entrada:** `n = 4`

| `i` | Rango de `j` (`1` a `n - i`) | Espacios impresos | Rango de `k` (`1` a `2i - 1`) | Asteriscos impresos | Línea resultante |
|:-:|:-:|:-:|:-:|:-:|---|
| 1 | 1 a 3 | 3 | 1 a 1 | 1 | `···*` |
| 2 | 1 a 2 | 2 | 1 a 3 | 3 | `··***` |
| 3 | 1 a 1 | 1 | 1 a 5 | 5 | `·*****` |
| 4 | 1 a 0 (no se ejecuta) | 0 | 1 a 7 | 7 | `*******` |
| 5 | — | — | — | — | `i = 5 > n` → termina |

(`·` representa un espacio, solo para que se vea en la tabla.)

**Traza detallada de la fila `i = 2`:**

| Paso | Instrucción | `j` | `k` | Texto acumulado en la línea |
|:-:|---|:-:|:-:|---|
| 1 | Imprime espacio | 1 | — | `·` |
| 2 | Imprime espacio | 2 | — | `··` |
| 3 | Imprime `*` | — | 1 | `··*` |
| 4 | Imprime `*` | — | 2 | `··**` |
| 5 | Imprime `*` | — | 3 | `··***` |
| 6 | `Escribir ""` (salto de línea) | — | — | `··***` ⏎ |

**Salida final:**

```
Ingrese la altura de la pirámide:
   *
  ***
 *****
*******
```

### Escenario B: altura 1

**Entrada:** `n = 1`

| `i` | Rango de `j` | Espacios | Rango de `k` | Asteriscos | Línea |
|:-:|:-:|:-:|:-:|:-:|---|
| 1 | 1 a 0 (no se ejecuta) | 0 | 1 a 1 | 1 | `*` |

**Salida final:**

```
*
```

### Escenario C: altura 0

**Entrada:** `n = 0`

El `Para i <- 1 Hasta 0` no se ejecuta (1 > 0), por lo que no se imprime ninguna línea.

**Salida final:** (solo el mensaje de entrada, sin pirámide)

```
Ingrese la altura de la pirámide:
```

---

## Resumen

| Algoritmo | Escenarios | Resultado principal |
|---|:-:|---|
| `Cajero_Parqueadero.psc` | 2 | A: total $15000 con 3 carros. B: $0 con 0 carros |
| `ValidarPIN.psc` | 2 | A: acceso en el 3.er intento. B: sistema bloqueado |
| `Calificaciones.psc` | 2 | A: promedio 3.3, 3 aprobados, máx. 5, mín. 1.5, hay reprobados. B: promedio 4, 5 aprobados, máx. 5, mín. 3, nadie perdió |
| `FacturaRestaurante.psc` | 2 | A: total a pagar $29500. B: $0 |
| `Piramide.psc` | 3 | A: pirámide de 4 filas. B: un asterisco. C: sin salida |
