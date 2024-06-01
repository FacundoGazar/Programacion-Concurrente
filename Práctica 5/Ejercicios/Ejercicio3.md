Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se
comunican continuamente. Se requiere modelar su funcionamiento considerando las
siguientes condiciones:
- La central siempre comienza su ejecución tomando una señal del proceso 1; luego
toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una
señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
- Los procesos periféricos envían señales continuamente a la central. La señal del
proceso 1 será considerada vieja (se deshecha) si en 2 minutos no fue recibida. Si la
señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y
vuelve a mandarla (no se deshecha).

```Pascal
Procedure Sistema is

	Task Central is 
		Entry SenalA(SA: IN integer);
		Entry SenalB(SB: IN integer);
	End Central;
	
	Task ProcesoA;
	
	Task ProcesoB;
	
	Task Body Central is
	Begin
		accept SenalA(SA);
		
		loop
			SELECT
				accept SenalA(SA);
			OR
				accept SenalB(SB);
					SELECT
						accept SenalB(SB);
					OR DELAY 180.0
						NULL;
					END SELECT;
			END SELECT;
		end loop
	End Central;
	
	Task Body ProcesoA is
		SA: integer;
	Begin
		loop
			SA := generarSenal;
			SELECT 
				Central.SenalA(SA);
			OR DELAY 120.0
				NULL;
			END SELECT
		end loop
	End ProcesoA;
	
	Task Body ProcesoB is
		SB: integer;
		noRecibida: boolean := true;
	Begin
		loop
			if (noRecibida) then
				SB := generarSenal;
				noRecibida := false;
			end if;
			SELECT 
				Central.SenalB();
				noRecibida := true;
			ELSE
				DELAY 60.0;
			END SELECT
		end loop
	End ProcesoA;
Begin
	null;
END Sistema;
```