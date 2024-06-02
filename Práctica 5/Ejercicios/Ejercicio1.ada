Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso.
El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 2
unidades y cada camión 3 unidades. Suponga que hay una cantidad innumerable de
vehículos (A autos, B camionetas y C camiones). Analice el problema y defina qué tareas,
recursos y sincronizaciones serán necesarios/convenientes para resolver el problema.
a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad.
b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los
vehículos.

Inciso a)

	Procedure Puente is
		
		Task Type Vehiculo;
		
		Task Coordinador is
			Entry PasarAuto();
			Entry PasarCamioneta();
			Entry PasarCamion();
			Entry Salir(P: IN integer);
		End coordinador;
		
		arrV = array (1..N) of Vehiculo;
		
		Task Body vehiculo is
			soyEsto = string := obtenerTipo;
		Begin
			if (soyEsto = "Auto") then
				Coordinador.PasarAuto();
				Coordinador.Salir(1);
			else if (soyEsto = "Camioneta") then 
				Coordinador.PasarCamioneta();
				Coordinador.Salir(2);
			else
				Coordinador.PasarCamion();
				Coordinador.Salir(3);
		End vehiculo
		
		Task Body Coordinador is
			total = integer := 0;
		Begin
			loop
				SELECT
					when (total < 5) => 
						accept PasarAuto() do
							total := total + 1;
						end PasarAuto;
				OR
					when (total < 4) =>
						accept PasarCamioneta() do
							total := total + 2;
						end PasarCamioneta;
				OR
					when (total < 3) =>
						accept PasarCamion() do
							total := total + 3;
						end PasarCamion;
				OR
					accept Salir(P: IN integer) do
						total := total - P;
					end Salir;
				END SELECT
			end loop;
		End Coordinador;
		
		Begin
			null;
		End Puente;
	
	
=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=

Inciso B)

	Procedure Puente is
		
		Task Type Vehiculo;
		
		Task Coordinador is
			Entry PasarAuto();
			Entry PasarCamioneta();
			Entry PasarCamion();
			Entry Salir(P: IN integer);
		End coordinador;
		
		arrV = array (1..N) of Vehiculo;
		
		Task Body vehiculo is
			soyEsto = string := obtenerTipo;
		Begin
			if (soyEsto = "Auto") then
				Coordinador.PasarAuto();
				Coordinador.Salir(1);
			else if (soyEsto = "Camioneta") then 
				Coordinador.PasarCamioneta();
				Coordinador.Salir(2);
			else
				Coordinador.PasarCamion();
				Coordinador.Salir(3);
		End vehiculo
		
		Task Body Coordinador is
			total = integer := 0;
		Begin
			loop
				SELECT
					when (PasarCamion'count = 0 AND total < 5) => 
						accept PasarAuto() do
							total := total + 1;
						end PasarAuto;
				OR
					when (PasarCamion'count = 0 AND total < 4) =>
						accept PasarCamioneta() do
							total := total + 2;
						end PasarCamioneta;
				OR
					when (total < 3) =>
						accept PasarCamion() do
							total := total + 3;
						end PasarCamion;
				OR
					accept Salir(P: IN integer) do
						total := total - P;
					end Salir;
				END SELECT
			end loop;
		End Coordinador;
		
		Begin
			null;
		End Puente;