En una playa hay 5 equipos de 4 personas cada uno (en total son 20 personas donde cada
una conoce previamente a que equipo pertenece). Cuando las personas van llegando
esperan con los de su equipo hasta que el mismo esté completo (hayan llegado los 4
integrantes), a partir de ese momento el equipo comienza a jugar. El juego consiste en que
cada integrante del grupo junta 15 monedas de a una en una playa (las monedas pueden ser
de 1, 2 o 5 pesos) y se suman los montos de las 60 monedas conseguidas en el grupo. Al
finalizar cada persona debe conocer el grupo que más dinero junto. Nota: maximizar la
concurrencia. Suponga que para simular la búsqueda de una moneda por parte de una
persona existe una función Moneda() que retorna el valor de la moneda encontrada.

Procedure Playa
	
	Task Type Persona;
	
	Task Type Admin
		Entry Llegue;
		Entry Comienza;
		Entry Contar(Puntos: IN integer);
		Entry QuienSoy(ID: IN integer);
	End Admin;
	
	Task Contador is
		Entry DecidirGanador(PuntosTotal: IN integer: ID: IN integer);
		Entry AvisarGanador(ID: OUT integer);
	End Contador;
	
	arrPersona = array (1..20) of Persona;
	arrAdmin = array (1..5) of Admin;
	
	Task Body Persona is
		id: integer := obtenerID();
		valorParcial: integer := 0;
		EquipoGanador: integer;
	Begin
		Admin(id).Llegue;
		Admin(id).Comienza;
		
		for i in 1..15 loop
			valorParcial := valorParcial + Moneda();
		end loop;
		
		Admin(id).Contar(valorParcial);
		Contador.AvisarGanador(EquipoGanador);
	End Persona;
	
	Task Body Admin is
		totalPuntos: integer := 0;
		numEquipo: integer;
	Begin
		accept QuienSoy(ID: IN integer) do
			numEquipo := ID;
		End QuienSoy;
		
		for i in 1..4 loop
			accept Llegue;
		end loop;
		
		for i in 1..4 loop
			accept Comienza;
		end loop;
		
		for i in 1..4 loop
			accept Contar(Puntos: IN integer) do
				totalPuntos := totalPuntos + Puntos;
			End Contar;
		end loop;
		
		Contador.DecidirGanador(totalPuntos, numEquipo);
	End Admin;
	
	Task Body Contador is
		totalMax: integer := -1;
		idGanador: integer;
	Begin
		for i in 1..5 loop
			accept DecidirGanador(PuntosTotal: IN integer; ID: IN integer) do
				if(PuntosTotal > totalMax) then
					totalMax := PuntosTotal;
					idGanador := ID;
			End DecidirGanador;
		end loop;
		
		for i in 1..20 loop
			accept AvisarGanador(ID: OUT integer) do
				ID := idGanador;
			End AvisarGanador;
		end loop;
	End Contador;
	
Begin
	for i in 1..5 loop
		arrAdmin(i).QuienSoy(i);
	end loop;
End Playa;