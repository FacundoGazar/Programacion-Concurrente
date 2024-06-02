2. Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar
un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de
acuerdo con el orden de llegada. Los clientes llegan y si esperan más de 10 minutos se
retiran sin realizar el pago.
		
Procedure Banco is
		
	Task Type Cliente;
			
	Task Empleado is
		Entry Pago(Plata: IN integer; Comprobante: OUT texto);
	End Empleado;
			
	arrClientes = array (1..N) of Cliente;
			
	Task Body Cliente is
		plata: integer := cantPlataRandom;
		comprobante : texto;
	Begin
		SELECT
			Empleado.Pago(plata, comprobante);
		OR DELAY 600.0
			NULL;
		END SELECT;
	End Cliente;
			
	Task Body Empleado is
	Begin
		loop
			accept Pago(plata: IN integer; comprobante: OUT texto) do
				comprobante = generarComprobante(plata);
			end Pago;
		end loop;
	End Empleado;
		
Begin
	null;
End Banco;
