{3. Realizar un programa que presente un menú con opciones para:
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
program menu;
type
	str = string[20];
	empleado = record
		nro:integer;
		apellido:str;
		nombre:str;
		edad:integer;
		dni:integer;
	end;
	archivo = file of empleado;

	procedure listar(var a:archivo; nombreArc:str);
	var
		nombreDeterminado,empleadosEnLinea,mayores,nombreEmpleado:str;
		e:empleado;
	begin
		
		write(' ingrese un nombre de empleado a buscar: ');
		readln(nombreEmpleado);
		nombreDeterminado:=' lista de los empleados llamados 'nombreEmpleado,'\n';
		empleadosEnLista:='empleados en lista \n';
		mayores:=' lista de empleados mayores a 70 años \n';
		assign(a,nombreArc);
		reset(a);
		while not eof(a) do begin
			read(a,e);
			if(e.nombre = nombreEmpleado)then 
				nombreDeterminado:='Nombre ',e.nombre,' Apellido ',e.apellido,' numero de empleado ',e.nro,' edad ',e.edad,' dni ',e.dni,'\n';
			empleadosEnLista:='Nombre ',e.nombre,' Apellido ',e.apellido,' numero de empleado ',e.nro,' edad ',e.edad,' dni ',e.dni,'\n';
			if(e.edad > 70) then 
				mayores:='Nombre ',e.nombre,' Apellido ',e.apellido,' numero de empleado ',e.nro,' edad ',e.edad,' dni ',e.dni,'\n';
		end;
		close(a);
		write(nombreDeterminado); {concatenas?? no entiendo}
		writeln();
		writeln();
		write(empleadosEnLinea);
		writeln();
		writeln();
		write(mayores);
		writeln();
		writeln();
	end;
	procedure crearArchivo(var a:archivo; nombreArc:str);
		procedure leerRegistro(var e:empleado);
		begin
			write(' ingrese un Apellido: ');
			readln(e.apellido);
			if(e.apellido <> 'fin')then begin
				write('ingrese un nombre: ');
				readln(e.nombre);
				write('ingrese numero de empleado: ');
				readln(e.nro);
				write('ingrese edad: ');
				readln(e.edad);
				write('ingrese dni: ');
				readln(e.dni);
			end;
		end;
	var
		e:empleado;
	begin
		leerRegistro(e);
		if(e.apellido <> 'fin')then begin
			write('ingrese un nombre para el archivo: ');
			readln(nombreArc);
			assign(a,nombreArc);
			rewrite(a);
			while(e.apellido <> 'fin')do begin
				write(a,e);
				leerRegistro(e);
			end;
			close(a);
		end;
	end;
	procedure menu(var a:archivo);
	var
		opcion,nombreArc:str;
	begin
		writeln('                       ---------------------- Menu ---------------------');
		writeln();
		writeln('crear registros de empleados ---> a');
		writeln();
		writeln('enlistar Busquedas ------------------------------------> b');
		writeln();
		writeln('finalizar Menu --------------------------> z');
		writeln();
		write(' ingrese una opcion: ');
		readln(nro);
		if(opcion <> 'z')then begin
			while(opcion <> 'z')do begin
				case opcion of
					'a':crearArchivo(a,nombreArc);
					'b':listar(a);
				else
					writeln(' opcion invalida');
				end;
				writeln('                       ---------------------- Menu ---------------------');
				writeln();
				writeln('crear registros de empleados ---> a');
				writeln();
				writeln('enlistar Busquedas ------------------------------------> b'); {repetis codigo innecesario}
				writeln();
				writeln('finalizar Menu --------------------------> z');
				writeln();
				write(' ingrese una opcion: ');
				readln(opcion);
			end;
		end;
	end;
var
	a:archivo;
begin
	menu(a);
end.
