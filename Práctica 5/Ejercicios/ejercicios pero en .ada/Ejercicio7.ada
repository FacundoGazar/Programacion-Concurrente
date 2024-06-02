Hay un sistema de reconocimiento de huellas dactilares de la policía que tiene 8 Servidores
para realizar el reconocimiento, cada uno de ellos trabajando con una Base de Datos propia;
a su vez hay un Especialista que utiliza indefinidamente. El sistema funciona de la siguiente
manera: el Especialista toma una imagen de una huella (TEST) y se la envía a los servidores
para que cada uno de ellos le devuelva el código y el valor de similitud de la huella que más
se asemeja a TEST en su BD; al final del procesamiento, el especialista debe conocer el
código de la huella con mayor valor de similitud entre las devueltas por los 8 servidores.
Cuando ha terminado de procesar una huella comienza nuevamente todo el ciclo. Nota:
suponga que existe una función Buscar(test, código, valor) que utiliza cada Servidor donde
recibe como parámetro de entrada la huella test, y devuelve como parámetros de salida el
código y el valor de similitud de la huella más parecida a test en la BD correspondiente.
Maximizar la concurrencia y no generar demora innecesaria.

Procedure Sistema
	
	Task Type Servidor;
	
	Task Especialista is
		Entry BrindarDatos(TEST: OUT integer);
		Entry RespuestaServer(COD: IN integer; VALOR: IN integer);
	End Especialista;
	
	arrBD = array (1..8) of Servidor;
	
	Task Body Especialista is
		valorMax: integer := -1;
		codMax: integer;
		TEST: integer;
	Begin
		loop
			imagen = ObtenerHuella();
			
			for i in 1..8 loop
				accept BrindarDatos(TEST: OUT integer) donde
					TEST := imagen;
				End BrindarDatos;
			end loop;
			
			for i in 1..8 loop
				accept RespuestaServer(COD: IN integer; VALOR: IN integer) donde
					if(COD > codMax) then
						codMax := COD;
						valorMax := VALOR;
					end if;
				End RespuestaServer;
			end loop;
			
		end loop;
	End Especialista;
	
	
	Task Body Servidor is
		TEST: integer;
		COD: integer;
		VALOR: integer;
	Begin
		loop
			Especialista.BrindarDatos(TEST);
			Buscar(TEST, COD, VALOR);
			Especialista.RespuestaServer(COD, VALOR);
		end loop;
	End Servidor;
Begin
	NULL;
End Sistema;