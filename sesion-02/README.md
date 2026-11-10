# Tablas de decisión y pruebas de registro

Análisis de los algoritmos en PSeInt (`.psc`). Para cada archivo se incluye:

1. Código y regla de negocio
2. Tabla de decisión (condiciones → acciones)
3. Pruebas de registro (entrada, resultado esperado, resultado obtenido y estado)

> **Notación:** `V` = verdadero, `F` = falso, `X` = combinación imposible, `—` = no importa / no aplica.
>
> **Nota:** los "resultados obtenidos" se obtuvieron trazando el código manualmente, no ejecutándolo en PSeInt.

| # | Archivo | Algoritmo |
|:-:|---|---|
| 1 | `Bisiesto.psc` | Año bisiesto |
| 2 | `ValidarEdad.psc` | Validación de edad (0 a 120) |
| 3 | `ValidarRegistro.psc` | Registro por edad y términos |
| 4 | `Semaforo.psc` | Semáforo de inventario |
| 5 | `Parqueadero.psc` | Cobro de parqueadero |

---

## 1. `Bisiesto.psc` — Año bisiesto

### Código

```pseint
Algoritmo Bisiesto
	Definir anio Como Real
	Escribir "Escriba el año que desea consultar: "
	Leer anio
	Si (anio MOD 4 = 0 Y anio MOD 100 <> 0) O anio MOD 400 = 0 Entonces
		Escribir anio, " es bisiesto."
	SiNo
		Escribir anio, " no es bisiesto."
	FinSi
FinAlgoritmo
```

### Regla de negocio

Un año es bisiesto si es divisible entre 4 y no entre 100, o si es divisible entre 400.

### Tabla de decisión

**Condiciones**
- **C1:** `anio MOD 4 = 0`
- **C2:** `anio MOD 100 <> 0`
- **C3:** `anio MOD 400 = 0`

| | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| **C1** divisible entre 4 | V | V | V | V | F | F | F | F |
| **C2** no divisible entre 100 | V | V | F | F | V | V | F | F |
| **C3** divisible entre 400 | V | F | V | F | V | F | V | F |
| **Acción** | X | Bisiesto | Bisiesto | No bisiesto | X | No bisiesto | X | X |
| **Ejemplo** | — | 2024 | 2000 | 1900 | — | 2023 | — | — |

**Tabla simplificada (reglas posibles):**

| Regla | C1 | C2 | C3 | Resultado |
|:-:|:-:|:-:|:-:|---|
| R2 | V | V | F | `… es bisiesto.` |
| R3 | V | F | V | `… es bisiesto.` |
| R4 | V | F | F | `… no es bisiesto.` |
| R6 | F | V | F | `… no es bisiesto.` |

R1, R5, R7 y R8 son imposibles: todo múltiplo de 400 lo es de 100 y de 4, y todo múltiplo de 100 lo es de 4.

### Pruebas de registro

| ID | Regla | Entrada (`anio`) | Resultado esperado | Resultado obtenido | Estado |
|---|:-:|---|---|---|:-:|
| B-01 | R2 | 2024 | 2024 es bisiesto. | 2024 es bisiesto. | ✅ Pasa |
| B-02 | R2 | 4 | 4 es bisiesto. | 4 es bisiesto. | ✅ Pasa |
| B-03 | R3 | 2000 | 2000 es bisiesto. | 2000 es bisiesto. | ✅ Pasa |
| B-04 | R3 | 1600 | 1600 es bisiesto. | 1600 es bisiesto. | ✅ Pasa |
| B-05 | R4 | 1900 | 1900 no es bisiesto. | 1900 no es bisiesto. | ✅ Pasa |
| B-06 | R4 | 2100 | 2100 no es bisiesto. | 2100 no es bisiesto. | ✅ Pasa |
| B-07 | R6 | 2023 | 2023 no es bisiesto. | 2023 no es bisiesto. | ✅ Pasa |
| B-08 | R6 | 1 | 1 no es bisiesto. | 1 no es bisiesto. | ✅ Pasa |
| B-09 | Atípico | 0 | Valor inválido (no existe el año 0) | 0 es bisiesto. | ⚠️ Observación |
| B-10 | Atípico | 2024.5 | Entrada inválida (el año debe ser entero) | No determinado: depende de cómo PSeInt aplique `MOD` a un Real | ⚠️ Observación |

**Observaciones:**
- La lógica es correcta y usa paréntesis para dejar clara la precedencia.
- `anio` se define como **Real**: se recomienda `Entero`, porque un año no tiene decimales y `MOD` está pensado para enteros.
- No se valida que el año sea mayor que 0.

---

## 2. `ValidarEdad.psc` — Validación de edad

### Código

```pseint
Algoritmo ValidarEdad
	Definir Edad Como Entero
	Escribir "Escriba su edad: "
	Leer Edad
	Si Edad < 0 O Edad > 120 Entonces
		Escribir "Edad inválida."
	SiNo
		Escribir "Edad válida."
	FinSi
FinAlgoritmo
```

### Regla de negocio

La edad es válida si está entre 0 y 120 (inclusive).

### Tabla de decisión

**Condiciones**
- **C1:** `Edad < 0`
- **C2:** `Edad > 120`

| | R1 | R2 | R3 | R4 |
|---|:-:|:-:|:-:|:-:|
| **C1** Edad < 0 | V | V | F | F |
| **C2** Edad > 120 | V | F | V | F |
| **Acción: "Edad inválida."** | X | ✔ | ✔ | |
| **Acción: "Edad válida."** | X | | | ✔ |

R1 es imposible: ningún número es a la vez menor que 0 y mayor que 120.

### Pruebas de registro

| ID | Regla | Entrada (`Edad`) | Resultado esperado | Resultado obtenido | Estado |
|---|:-:|:-:|---|---|:-:|
| E-01 | R2 | -1 (límite) | Edad inválida. | Edad inválida. | ✅ Pasa |
| E-02 | R2 | -50 | Edad inválida. | Edad inválida. | ✅ Pasa |
| E-03 | R4 | 0 (límite) | Edad válida. | Edad válida. | ✅ Pasa |
| E-04 | R4 | 1 | Edad válida. | Edad válida. | ✅ Pasa |
| E-05 | R4 | 25 | Edad válida. | Edad válida. | ✅ Pasa |
| E-06 | R4 | 120 (límite) | Edad válida. | Edad válida. | ✅ Pasa |
| E-07 | R3 | 121 (límite) | Edad inválida. | Edad inválida. | ✅ Pasa |
| E-08 | R3 | 500 | Edad inválida. | Edad inválida. | ✅ Pasa |

---

## 3. `ValidarRegistro.psc` — Registro por edad y términos

### Código

```pseint
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
```

### Regla de negocio

Solo se permite el registro si la persona tiene **14 años o más** y **acepta los términos** (`S` o `s`).

### Tabla de decisión

**Condiciones**
- **C1:** `edad >= 14`
- **C2:** `Respuesta = "S"` (tras convertir a mayúsculas)

| | R1 | R2 | R3 | R4 |
|---|:-:|:-:|:-:|:-:|
| **C1** edad >= 14 | V | V | F | F |
| **C2** acepta términos (S) | V | F | V | F |
| **Acción: "Registro exitoso."** | ✔ | | | |
| **Acción: "No puedes registrarte."** | | ✔ | ✔ | ✔ |

### Pruebas de registro

| ID | Regla | Edad | Respuesta | Resultado esperado | Resultado obtenido | Estado |
|---|:-:|:-:|:-:|---|---|:-:|
| R-01 | R1 | 20 | S | Registro exitoso. | Registro exitoso. | ✅ Pasa |
| R-02 | R1 (límite) | 14 | S | Registro exitoso. | Registro exitoso. | ✅ Pasa |
| R-03 | R1 (minúscula) | 20 | s | Registro exitoso. | Registro exitoso. | ✅ Pasa |
| R-04 | R2 | 20 | N | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-05 | R2 (límite) | 14 | N | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-06 | R3 | 10 | S | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-07 | R3 (límite) | 13 | S | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-08 | R4 | 10 | N | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-09 | R4 (límite) | 13 | N | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-10 | Respuesta inválida | 20 | SI | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-11 | Respuesta inválida | 20 | X | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-12 | Edad atípica | 0 | S | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-13 | Edad atípica | -5 | S | No puedes registrarte. | No puedes registrarte. | ✅ Pasa |
| R-14 | Edad atípica | 150 | S | Edad irreal (sin regla definida) | Registro exitoso. | ⚠️ Observación |

**Observaciones:**
- Cualquier respuesta distinta de `S` (incluso `SI`) se trata igual que `N`.
- No hay un límite máximo de edad (a diferencia de `ValidarEdad.psc`, que rechaza más de 120).
- La variable se declara como `Edad` y se usa como `edad`: PSeInt no distingue mayúsculas por defecto, así que funciona.

---

## 4. `Semaforo.psc` — Semáforo de inventario

### Código

```pseint
Algoritmo Semaforo
	Definir unidades Como Entero
	Escribir "Escribe las unidades: "
	Leer unidades
	Si unidades < 0 Entonces
		Escribir "Error."
	FinSi
	Si unidades = 0 Entonces
		Escribir "Rojo: Agotado"
	FinSi
	Si unidades >= 1 Y unidades <= 10
		Escribir "Amarillo: Pedir"
	FinSi
	Si unidades > 10
		Escribir "Verde: Todo bien"
	FinSi
FinAlgoritmo
```

### Regla de negocio

| Unidades | Resultado |
|---|---|
| Menor que 0 | Error |
| 0 | Rojo: Agotado |
| 1 a 10 | Amarillo: Pedir |
| Más de 10 | Verde: Todo bien |

### Tabla de decisión

**Condiciones**
- **C1:** `unidades < 0`
- **C2:** `unidades = 0`
- **C3:** `unidades >= 1 Y unidades <= 10`
- **C4:** `unidades > 10`

| | R1 | R2 | R3 | R4 |
|---|:-:|:-:|:-:|:-:|
| **C1** unidades < 0 | V | F | F | F |
| **C2** unidades = 0 | F | V | F | F |
| **C3** 1 ≤ unidades ≤ 10 | F | F | V | F |
| **C4** unidades > 10 | F | F | F | V |
| **Acción: "Error."** | ✔ | | | |
| **Acción: "Rojo: Agotado"** | | ✔ | | |
| **Acción: "Amarillo: Pedir"** | | | ✔ | |
| **Acción: "Verde: Todo bien"** | | | | ✔ |

Las cuatro condiciones son mutuamente excluyentes y cubren todos los enteros, por lo que siempre se muestra exactamente un mensaje.

### Pruebas de registro

| ID | Regla | Unidades | Resultado esperado | Resultado obtenido | Estado |
|---|:-:|:-:|---|---|:-:|
| S-01 | R1 (límite) | -1 | Error. | Error. | ✅ Pasa |
| S-02 | R1 | -50 | Error. | Error. | ✅ Pasa |
| S-03 | R2 | 0 | Rojo: Agotado | Rojo: Agotado | ✅ Pasa |
| S-04 | R3 (límite inferior) | 1 | Amarillo: Pedir | Amarillo: Pedir | ✅ Pasa |
| S-05 | R3 | 5 | Amarillo: Pedir | Amarillo: Pedir | ✅ Pasa |
| S-06 | R3 (límite superior) | 10 | Amarillo: Pedir | Amarillo: Pedir | ✅ Pasa |
| S-07 | R4 (límite) | 11 | Verde: Todo bien | Verde: Todo bien | ✅ Pasa |
| S-08 | R4 | 500 | Verde: Todo bien | Verde: Todo bien | ✅ Pasa |

**Observaciones:**
- A diferencia de la versión anterior, aquí `Y` está bien usado y el verde sí es alcanzable.
- Se usan cuatro `Si` independientes en lugar de `SiNo` anidados. Funciona porque las condiciones son excluyentes, aunque se evalúan todas siempre.
- El mensaje `Error.` es poco descriptivo (no indica que las unidades no pueden ser negativas).

---

## 5. `Parqueadero.psc` — Cobro de parqueadero

### Código

```pseint
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
```

### Regla de negocio

- **Tarifa por hora:** carro (1) = $4.000, moto (2) = $2.000.
- **Gracia:** hasta 15 minutos no se cobra.
- **Cobro:** se cobra por hora o fracción (`horas = trunc((minutos+59)/60)`, es decir, minutos redondeados hacia arriba a horas completas).
- **Tope:** el cobro máximo es $30.000.
- **Descuento:** con factura de compra se aplica 50 % (después del tope, por lo que el máximo con factura es $15.000).
- **Validaciones:** los minutos no pueden ser negativos y el tipo debe ser 1 o 2. Se valida primero los minutos y luego el tipo.

### Tabla de decisión

**Condiciones**
- **C1:** `minutos < 0`
- **C2:** tipo de vehículo válido (`tipo` = 1 o 2)
- **C3:** `minutos <= 15`
- **C4:** `horas * tarifa > 30000`
- **C5:** `factura = "S"`

**Acciones**
- **A1:** mostrar "Los minutos no pueden ser negativos."
- **A2:** mostrar "Tipo de vehículo no válido"
- **A3:** total = 0
- **A4:** total = horas × tarifa
- **A5:** total = 30000 (tope)
- **A6:** total = total / 2 (descuento)
- **A7:** mostrar "El valor a pagar es: $" total

| | R1 | R2 | R3 | R4 | R5 | R6 | R7 |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| **C1** minutos < 0 | V | F | F | F | F | F | F |
| **C2** tipo válido (1 o 2) | — | F | V | V | V | V | V |
| **C3** minutos <= 15 | — | — | V | F | F | F | F |
| **C4** horas × tarifa > 30000 | — | — | — | F | F | V | V |
| **C5** factura = S | — | — | — | F | V | F | V |
| **A1** error minutos | ✔ | | | | | | |
| **A2** tipo no válido | | ✔ | | | | | |
| **A3** total = 0 | | | ✔ | | | | |
| **A4** total = horas × tarifa | | | | ✔ | ✔ | ✔ | ✔ |
| **A5** aplicar tope $30.000 | | | | | | ✔ | ✔ |
| **A6** aplicar 50 % | | | | | ✔ | | ✔ |
| **A7** mostrar valor a pagar | | | ✔ | ✔ | ✔ | ✔ | ✔ |

**Valor final por regla (R3 a R7):**

| Regla | Resultado |
|:-:|---|
| R3 | $0 |
| R4 | horas × tarifa |
| R5 | (horas × tarifa) / 2 |
| R6 | $30.000 |
| R7 | $15.000 |

**Referencias para pruebas de límites:**

| Vehículo | Tarifa | Horas máximas sin tope | Minutos máximos sin tope | Primer minuto con tope |
|---|---|:-:|:-:|:-:|
| Carro | $4.000 | 7 (= $28.000) | 420 | 421 (8 h = $32.000 → $30.000) |
| Moto | $2.000 | 15 (= $30.000) | 900 | 901 (16 h = $32.000 → $30.000) |

### Pruebas de registro

| ID | Regla | Tipo | Minutos | Factura | Resultado esperado | Resultado obtenido | Estado |
|---|:-:|:-:|:-:|:-:|---|---|:-:|
| P-01 | R1 | 1 | -1 | N | Los minutos no pueden ser negativos. | Los minutos no pueden ser negativos. | ✅ Pasa |
| P-02 | R1 (precede al tipo) | 3 | -5 | N | Los minutos no pueden ser negativos. | Los minutos no pueden ser negativos. | ✅ Pasa |
| P-03 | R2 | 3 | 60 | N | Tipo de vehículo no válido | Tipo de vehículo no válido | ✅ Pasa |
| P-04 | R2 | 0 | 30 | S | Tipo de vehículo no válido | Tipo de vehículo no válido | ✅ Pasa |
| P-05 | R2 (gracia no aplica) | 5 | 10 | N | Tipo de vehículo no válido | Tipo de vehículo no válido | ✅ Pasa |
| P-06 | R3 | 1 | 0 | N | El valor a pagar es: $0 | El valor a pagar es: $0 | ✅ Pasa |
| P-07 | R3 (límite) | 1 | 15 | N | El valor a pagar es: $0 | El valor a pagar es: $0 | ✅ Pasa |
| P-08 | R3 | 2 | 15 | S | El valor a pagar es: $0 | El valor a pagar es: $0 | ✅ Pasa |
| P-09 | R4 (límite 16 min) | 1 | 16 | N | $4000 (1 h) | El valor a pagar es: $4000 | ✅ Pasa |
| P-10 | R4 (1 h exacta) | 1 | 60 | N | $4000 (1 h) | El valor a pagar es: $4000 | ✅ Pasa |
| P-11 | R4 (2 h por 1 min extra) | 1 | 61 | N | $8000 (2 h) | El valor a pagar es: $8000 | ✅ Pasa |
| P-12 | R4 moto | 2 | 16 | N | $2000 (1 h) | El valor a pagar es: $2000 | ✅ Pasa |
| P-13 | R4 moto | 2 | 120 | N | $4000 (2 h) | El valor a pagar es: $4000 | ✅ Pasa |
| P-14 | R4 (máx. sin tope, carro) | 1 | 420 | N | $28000 (7 h) | El valor a pagar es: $28000 | ✅ Pasa |
| P-15 | R4 (límite moto, = tope) | 2 | 900 | N | $30000 (15 h) | El valor a pagar es: $30000 | ✅ Pasa |
| P-16 | R4 (factura inválida) | 1 | 60 | X | $4000 (sin descuento) | El valor a pagar es: $4000 | ✅ Pasa |
| P-17 | R5 | 1 | 60 | S | $2000 | El valor a pagar es: $2000 | ✅ Pasa |
| P-18 | R5 (minúscula) | 2 | 61 | s | $2000 (4000 / 2) | El valor a pagar es: $2000 | ✅ Pasa |
| P-19 | R5 | 2 | 16 | S | $1000 | El valor a pagar es: $1000 | ✅ Pasa |
| P-20 | R6 (límite carro) | 1 | 421 | N | $30000 (tope) | El valor a pagar es: $30000 | ✅ Pasa |
| P-21 | R6 | 1 | 600 | N | $30000 (tope) | El valor a pagar es: $30000 | ✅ Pasa |
| P-22 | R6 (límite moto) | 2 | 901 | N | $30000 (tope) | El valor a pagar es: $30000 | ✅ Pasa |
| P-23 | R6 (un día completo) | 2 | 1440 | N | $30000 (tope) | El valor a pagar es: $30000 | ✅ Pasa |
| P-24 | R7 | 1 | 421 | S | $15000 | El valor a pagar es: $15000 | ✅ Pasa |
| P-25 | R7 | 2 | 901 | S | $15000 | El valor a pagar es: $15000 | ✅ Pasa |

**Observaciones:**
- Se valida primero `minutos < 0`; por eso con tipo inválido y minutos negativos se muestra el error de minutos (P-02).
- El tipo inválido se detecta aunque los minutos estén dentro de la gracia (P-05).
- Cualquier respuesta de factura distinta de `S` se trata como "sin factura" (P-16).
- El tope se aplica **antes** del descuento, así que el máximo a pagar es $30.000 sin factura y $15.000 con factura.
- La detección de tipo inválido usa `tarifa = 0`: funciona hoy, pero si algún día se agrega una tarifa gratuita se confundiría con un tipo inválido.

---

## Resumen de resultados

| Algoritmo | Archivo | Casos | Pasan | Fallan | Observaciones |
|---|---|:-:|:-:|:-:|:-:|
| Año bisiesto | `Bisiesto.psc` | 10 | 8 | 0 | 2 |
| Validación de edad | `ValidarEdad.psc` | 8 | 8 | 0 | 0 |
| Registro | `ValidarRegistro.psc` | 14 | 13 | 0 | 1 |
| Semáforo | `Semaforo.psc` | 8 | 8 | 0 | 0 |
| Parqueadero | `Parqueadero.psc` | 25 | 25 | 0 | 0 |

Ningún caso falla. Las observaciones son validaciones faltantes (año 0, decimales en `Bisiesto`, edad máxima en `ValidarRegistro`), no errores de lógica.
