3. Un sistema operativo mantiene 5 instancias de un recurso almacenadas en una cola.
Además, existen P procesos que necesitan usar una instancia del recurso. Para eso, deben
sacar la instancia de la cola antes de usarla. Una vez usada, la instancia debe ser encolada
nuevamente.
```Python
int cantDisp=5;
cola recursos; //se dispone
sem mutexP=1;
sem mutexR =1;
sem dormidos[P]=([P] 0);
cola esperando;

Process Proceso[id: 0..P-1]{
	Recurso recurso;
	int sig;
	
	P(mutexP)
	if (cantDisp != 0){
		cantDisp--;
		V(mutexP);
	}
	else{
		esperando.push(id);
		V(mutexP)
		P(dormidos[id]);
	}
	
	P(mutexR)
	recursos.pop(recurso);
	V(mutexR)
	//usar el recurso
	P(mutexR)
	recursos.push(recurso);
	V(mutexR)
	
	P(mutexP)
	if(esperando.isEmpty){
		cantDisp++;
	}
	else{
		esperando.pop(sig);
		V(dormidos[sig]):
	}
	V(mutexP)
}

```