{ Realizar un programa que presente un menú con opciones para:
      a. Crear un archivo de registros no ordenados de empleados y completarlo con
         datos ingresados desde teclado. De cada empleado se registra: número de
         empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
         DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
      b. Abrir el archivo anteriormente generado y
      i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
         determinado.
      ii. Listar en pantalla los empleados de a uno por línea.
      iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}

program Ejercicio3;

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
			assign(archivoFisico,'Ejercicio3');
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
	
	procedure desplegarMenu(var archivoFisico: archivo);
	var n: integer;
			ok: boolean;
		begin
			ok := true;
			writeln('----------------menu de opciones----------------');
			writeln('Si decea crear un archivo nuevo       digite: 1');
			writeln('Abrir el archivo creado anteriormente digite: 2');
			writeln('si desea finalizar                    digite: 3');
			readln(n);
			while(ok)do
				begin
					if(n = 1)or(n = 2)then
						begin
							case n of
								1: crearArchivo(archivoFisico);
								2: AbrirArchivo(archivoFisico);						
							end;
						ok := false		
						end	
					else 
						if(n = 3)then
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
