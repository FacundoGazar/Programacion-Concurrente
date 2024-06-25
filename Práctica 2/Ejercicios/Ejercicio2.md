
2. Un sistema de control cuenta con 4 procesos que realizan chequeos en forma
colaborativa. Para ello, reciben el historial de fallos del día anterior (por simplicidad, de
tamaño N). De cada fallo, se conoce su número de identificación (ID) y su nivel de
gravedad (0=bajo, 1=intermedio, 2=alto, 3=crítico). Resuelva considerando las siguientes
situaciones:

INCISO A 

Se debe imprimir en pantalla los ID de todos los errores críticos (no importa el
orden).

```Python

cola fallos(int, int); //se dispone
sem mutex=1;

Process Proceso[id: 0..3]{
	int idF, grav;
	P(mutex)
	while (!fallos.isEmpty){
		fallos.pop(idF,grav);
		V(mutex)
		if (grav == 3)
			print(idF)		
		P(mutex)
	}
	V(mutex)
}
```
INCISO B

Se debe calcular la cantidad de fallos por nivel de gravedad, debiendo quedar los resultados en un vector global.

```Python
cola fallos(int, int); //se dispone
sem mutex=1;
int resultados[4]=([4] 0);
sem result=1;

Process Proceso[id: 0..3]{
	int idF, grav;
	P(mutex)
	while (!fallos.isEmpty){
		fallos.pop(idF,grav);
		V(mutex)
		P(result)
		resultados[grav]++;		
		V(result)
		P(mutex)
	}
	V(mutex)
}
```
INCISO C

Ídem b) pero cada proceso debe ocuparse de contar los fallos de un nivel de
gravedad determinado.

```Python
cola fallos(int, int); //se dispone
sem mutex=1;
int resultados[4]=([4] 0);
sem result=1;

Process Proceso[id: 0..3]{
	int idF, grav;
	P(mutex)
	while (!fallos.isEmpty){
		fallos.pop(idF,grav);
		if (idF != id)
			fallos.push(idF,grav)
		V(mutex)
		else		
			P(result)
			resultados[grav]++;		
			V(result)
		P(mutex)
	}
	V(mutex)
}
```