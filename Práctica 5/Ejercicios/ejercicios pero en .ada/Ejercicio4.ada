En una clínica existe un médico de guardia que recibe continuamente peticiones de
atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la
clínica ser atendidos.
Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo
haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del
médico. Si no es atendida tres veces, se enoja y se retira de la clínica.
Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente
le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el
momento que pueda (el pedido puede ser que el médico le firme algún papel). Cuando la
petición ha sido recibida por el médico o la nota ha sido dejada en el escritorio, continúa
trabajando y haciendo más peticiones.
El médico atiende los pedidos dándole prioridad a los enfermos que llegan para ser atendidos.
Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto tiempo. Cuando
está libre aprovecha a procesar las notas dejadas por las enfermeras.


Procedure Clinica is

	Task Medico is
		Entry PedidoCliente(receta: OUT texto);
		Entry PedidoEnfermera(pedido: IN OUT texto);
		Entry RevisarEscritorio(T: IN OUT texto);
	End Medico;
	
	Task Escritorio is
		Entry RecibirNota(T: IN texto);
	End Escritorio;
	
	Task Type Cliente;
	
	Task Type Enfermera;
	
	arrCliente = array (1..P) Cliente;
	arrEnfermera = array (1..E) Enfermera;
	
	Task Body Cliente is
		atendido: integer := 0;
		receta: texto;
	Begin
		SELECT 
			Medico.PedidoCliente(receta);
			atendido := 3;
		OR DELAY 300.0
			atendido := atendido + 1;
		END SELECT;
		
		while (atendido < 3) loop
			SELECT
				Medico.PedidoCliente(receta);
				atendido := 3;
			OR DELAY 600.0
				atendido := atendido + 1;
			END SELECT;
		end loop;
		
	End Cliente;
	
	Task Body Enfermera is
		pedido: texto;
	Begin
		loop
			pedido := generarPedido();
			SELECT
				Medico.PedidoEnfermera(pedido);
			OR ELSE
				Escritorio.RecibirNota(pedido);
			END SELECT;
		end loop;
	End Enfermera;
	
	Task Body Medico is
		T: texto;
	Begin
		loop
			SELECT
				accept PedidoCliente(receta: OUT texto) do
					receta := AtenderClienteYRecetarAlgo();
				End PedidoCliente;
			OR
				when (PedidoCliente'count = 0) =>
					accept PedidoEnfermera(pedido: IN OUT texto) do
						pedido := ResolverPedido(pedido);
					End PedidoEnfermera;
			OR
				when (PedidoCliente'count = 0 AND PedidoEnfermera'count = 0) =>
					accept RevisarEscritorio(nota: IN OUT texto) do
						nota := ResolverNota(nota);
					End RevisarEscritorio;
			END SELECT
		end loop;
	End Medico;
	
	Task Body Escritorio is
		nota: texto;
	Begin
		loop
			accept RecibirNota(T: IN texto) do
				nota := T;
			End RecibirNota;
			Medico.RevisarEscritorio(nota);
		end loop;
	End Escritorio;
	
Begin
	NULL;
End Clinica;
