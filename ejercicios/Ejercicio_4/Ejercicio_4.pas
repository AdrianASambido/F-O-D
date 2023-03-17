{4. Agregar al menú del programa del ejercicio 3, opciones para:
   a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
      teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
      un número de empleado ya registrado (control de unicidad).
   b. Modificar edad a uno o más empleados.
   c. Exportar el contenido del archivo a un archivo de texto llamado
      “todos_empleados.txt”.
		d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
			que no tengan cargado el DNI (DNI en 00).
	NOTA: Las búsquedas deben realizarse por número de empleado.} 
	
program Ejercicio4;

type
	empleado = record
		numEmp  : integer;
		apellido: String;
		nombre  : String;
		edad    : integer;
		dni     : integer;
	end;

	archivo = file of empleado;
	
	procedure cargarRegistro(var reg : empleado);
		begin
			writeln('Ingrese apellido del empleado');
			readln(reg.apellido);
			if(reg.apellido <> 'fin')then;
				begin
					writeln('Ingrese numero de empleado');
					readln(reg.numEmp);
					writeln('Ingrese nombre del empleado');
					readln(reg.nombre);
					writeln('Ingrese edad del empleado');
					readln(reg.edad);
					writeln('Ingrese Dni del empleado');
					readln(reg.dni);					
				end;
		end;		

	procedure asignarArchivo(var archivoFisico: archivo);
	var 
		nom: string;
		begin
			writeln('Ingrese un nombre para el archivo');
		  readln(nom);
			assign(archivoFisico,nom);
			rewrite(archivoFisico);
		end;

	procedure crearArchivo(var archivoFisico: archivo);
	var 
		reg: empleado;
		begin
		  asignarArchivo(archivoFisico);
		  writeln('Para finalizar la carga ingrese apellido "fin"');
			cargarRegistro(reg);
			while(reg.apellido <> 'fin')do
				begin
					write(archivoFisico, reg);
					cargarRegistro(reg);
				end;
			close(archivoFisico);	
		end;
		
	procedure imprimirDeterminados(reg: empleado; nom: string);	
		begin
			if(reg.apellido = nom)then
				writeln('Se encontro el apellido buscado es :', '  ' , reg.apellido)
			else
				if(reg.nombre = nom)then
					writeln('Se encontro el nombre buscado es :', '  ' , reg.nombre)
		end;
		
		
	procedure	seleccionarEmpleados(var archivoFisico: archivo);
	var 
		nom: String;
		reg: empleado;
		begin
			reset(archivoFisico);
			writeln('Ingrese nombre o apellido para buscar coincidencias');
			readln(nom);
			while(not eof(archivoFisico))do
				begin
					read(archivoFisico, reg);
					imprimirDeterminados(reg,nom);
				end;
			close(archivoFisico);
		end;
		
	procedure imprimirEmpleado(reg: empleado);
		begin
			writeln(reg.numEmp, '  ' ,reg.apellido, '  ' ,reg.nombre, '  ' ,reg.edad, '  ' ,reg.dni);
		end;
			
	procedure listarEmpleados(var archivoFisico: archivo);
	var
			reg: empleado;
			begin
				reset(archivoFisico);
				while(not eof(archivoFisico))do
					begin
						read(archivoFisico,reg);
						writeln('----------------------------------');
						imprimirEmpleado(reg);
						writeln('----------------------------------');
					end;
				close(archivoFisico);
			end;
	
	procedure listarJubilados(var archivoFisico: archivo);
	var
		reg: empleado;
		begin
			reset(archivoFisico);
			while(not eof(archivoFisico))do
				begin
					read(archivoFisico,reg);
					if(reg.edad > 70 )then
						imprimirEmpleado(reg);
				end;
			close(archivoFisico);
		end;
	
	//Lista empleados condeterminado nombre o apellido
	//
	procedure abrirArchivo(var archivoFisico: archivo);
	var 
		n: integer;
		ok: boolean;
		begin
			ok := true;
			assign(archivoFisico, 'Ejercicio3');
			writeln('--------------------- menu de opciones ---------------------');
			writeln('Para listar determinados empleados                digite: 1');
			writeln('Para listar la totalidad de empleados             digite: 2');
			writeln('Listar en pantalla empleados proximos a jubilarse digite: 3');
			writeln('Para finalizar                                    digite: 4');
			readln(n);
			while(ok)do
				begin
					if(n = 1)or(n = 2)or(n = 3)then
						begin
							case n of
								1: seleccionarEmpleados(archivoFisico);
								2: listarEmpleados(archivoFisico);
								3: listarJubilados(archivoFisico);
							end;
							ok := false;
						end	
					else		
						begin
							if(n = 4)then
								ok := false
							else
								begin
									writeln('opcion invalida, ingrese una opciion valida'); 
									readln(n);
								end;
						end;		
				end;
		end;

	procedure modificarEdad(var archivoFisico: archivo);
		begin
			
		
		end;
	
	// Se pre-supone que el archivo existe	
	procedure agregarEmpleado(var archivoFisico: archivo);	
	var reg: empleado;
		begin
			seek(archivoFisico,fileSize(archivoFisico));
			writeln('Para finalizar la carga ingrese apellido "fin"');
			cargarRegistro(reg);			
			while(reg.apellido <> 'fin')do
				begin
					write(archivoFisico, reg);
					cargarRegistro(reg);
				end;
			close(archivoFisico);	
		end;
		
	procedure menuSecundario(var archivoFisico : archivo);
	var
		ok : boolean;
		reg: empleado;
		n  : integer;
		begin
			writeln('------------------menu de opciones------------------');
			writeln('---------- Que desea hacer ----------');
			writeln('agregar un nuevo empleado                 digite: 1');
			writeln('Modificar la edad de uno/o mas empleados  digite: 2');
			writeln('exportar el archivo a:todos_empleados.txt digite: 3');
			writeln('Exportar los empleados sin DNI cargado    digite: 4');
			writeln('si desea finalizar                        digite: 5');
			readln(n);
			while(ok)do
				begin
					if((n = 1)or(n = 2)or(n = 3 )or(n = 4))then
						begin
							case n of
								1: agregarEmpleado(archivoFisico);
								2: modificarEdad(archivoFisico);				
								3: exportarTodosEmpleados(archivoFisico);
								4: ExpotarEmpleadosDinDni(archivoFisico); 	
							end;
						ok := false		
						end	
					else 
						if(n = 5)then
							ok := false
						else	
							writeln('opcion invalida digite una opcion  valida');	
				end;
		end;	
		
	
	procedure desplegarMenu(var archivoFisico: archivo);
	var n: integer;
			ok: boolean;
		begin
			ok := true;
			writeln('----------------menu de opciones----------------');
			writeln('Si desea crear un archivo nuevo       digite: 1');
			writeln('Abrir el archivo creado anteriormente digite: 2');
			writeln('Si desea ver mas opciones             digite: 3');
			writeln('si desea finalizar                    digite: 6');
			readln(n);
			while(ok)do
				begin
					if(n = 1)or(n = 2)then
						begin
							case n of
								1: crearArchivo(archivoFisico);
								2: abrirArchivo(archivoFisico);				
								3: menuSecundario(archivoFisico);	
							end;
						ok := false		
						end	
					else 
						if(n = 6)then
							ok := false
						else	
							writeln('opcion invalida digite una opcion  valida');	
				end;
			writeln('Sesion finalizada');				 
		end;

var
	archivoFisico: archivo;
begin
	desplegarMenu(archivoFisico);
end.
	
