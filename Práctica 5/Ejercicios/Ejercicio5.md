En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos
de U Usuarios de a uno a la vez y de acuerdo con el orden en que se hacen los pedidos.
Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera la
respuesta de este que le indica si está todo bien o hay algún error. Mientras haya algún error,
vuelve a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le responde
que está todo bien, el usuario se retira. Cuando un usuario envía un pedido espera a lo sumo
2 minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto y vuelve a
intentarlo (usando el mismo documento).

```Pascal
Procedure Sistema is

	Task Servidor is
		Entry Documento(T: IN texto; B: OUT boolean);
	End Servidor;
	
	Task Type Cliente;
	
	arrCliente = array (1..U) of Cliente;
	
	Task Body Cliente is
		estaMal: boolean := true;
		respuesta: boolean;
		modificar: boolean := false;
		doc: texto;
	Begin
		doc := generarDocumento();
		while (estaMal) loop
			if (modificar) then
				doc := modificarDocumento(doc);
				modificar := false;
			end if;
			SELECT
				Servidor.Documento(doc, respuesta);
				if (respuesta) then
					modificar := true;
				else
					estaMal := false;
				end if;
			OR DELAY 120.0
				DELAY 60.0
			END SELECT;
		end loop;
	End Cliente;
	
	Task Body Servidor is
	Begin
		loop
			accept Documento(T: IN texto; B: OUT boolean) do
				B := evaluarDocumento(T) //Devuelve FALSE si no encuentra errores en el documento y TRUE en caso contrario.
			End Documento;	
		end loop;
	End Servidor
	
Begin
	NULL;
End Sistema;
```
