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

uses crt;
type
	empleado = record
		numEmp  : integer;
		apellido: String[20];
		nombre  : String[20];
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

	procedure asignarArchivo(var archivoLogico: archivo);
	var 
		nom: string;
		begin
			writeln('Ingrese un nombre para el archivo');
		  readln(nom);
			assign(archivoLogico,nom);
			rewrite(archivoLogico);
		end;

	procedure crearArchivo(var archivoLogico: archivo);
	var 
		reg: empleado;
		begin
		  writeln('Para finalizar la carga ingrese apellido "fin"');
		  rewrite(archivoLogico);
			cargarRegistro(reg);
			while(reg.apellido <> 'fin')do
				begin
					write(archivoLogico, reg);
					cargarRegistro(reg);
				end;
			close(archivoLogico);	
		end;
		
	procedure imprimirDeterminados(reg: empleado; nom: string);	
		begin
			if(reg.apellido = nom)then
				writeln('Se encontro el apellido buscado es :', '  ' , reg.apellido)
			else
				if(reg.nombre = nom)then
					writeln('Se encontro el nombre buscado es :', '  ' , reg.nombre)
		end;
		
		
	procedure	seleccionarEmpleados(var archivoLogico: archivo);
	var 
		nom: String;
		reg: empleado;
		begin
			reset(archivoLogico);
			writeln('Ingrese nombre o apellido para buscar coincidencias');
			readln(nom);
			while(not eof(archivoLogico))do
				begin
					read(archivoLogico, reg);
					imprimirDeterminados(reg,nom);
				end;
			close(archivoLogico);
		end;
		
	procedure imprimirEmpleado(reg: empleado);
		begin
			writeln(reg.numEmp);
			writeln(reg.apellido);
			writeln(reg.nombre);
			writeln(reg.edad);
			writeln(reg.dni);
		end;
			
	procedure listarEmpleados(var archivoLogico: archivo);
	var
			reg: empleado;
			begin
				reset(archivoLogico);
				while(not eof(archivoLogico))do
					begin
						read(archivoLogico,reg);
						writeln('----------------------------------');
						imprimirEmpleado(reg);
						writeln('----------------------------------');
					end;
				close(archivoLogico);
			end;
	
	procedure listarJubilados(var archivoLogico: archivo);
	var
		reg: empleado;
		begin
			reset(archivoLogico);
			while(not eof(archivoLogico))do
				begin
					read(archivoLogico,reg);
					if(reg.edad > 70 )then
						imprimirEmpleado(reg);
				end;
			close(archivoLogico);
		end;
	
	//Lista empleados condeterminado nombre o apellido
	//
	procedure abrirArchivo(var archivoLogico: archivo);
	var 
		n: integer;
		ok: boolean;
		begin
			ok := true;
	//		assign(archivoLogico, 'Ejercicio3');
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
								1: seleccionarEmpleados(archivoLogico);
								2: listarEmpleados(archivoLogico);
								3: listarJubilados(archivoLogico);
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

	procedure modificarE(var archivoLogico: archivo; reg: empleado);
	var edad: integer;
		begin
			writeln('ingrese edad');
			readln(edad);
			reg.edad := edad;
			seek(archivoLogico, filePos(archivoLogico)-1);
			write(archivoLogico, reg);
		end;
		

	procedure modificarEdad(var archivoLogico: archivo);
	var
		reg : empleado;
		ok  : String;
		begin
			reset(archivoLogico);
			while(not eof(archivoLogico))do			
				begin
					read(archivoLogico, reg);
					writeln('el empleado' , '  ' , reg.apellido, '  ' , reg.nombre, '  ' , 'tiene::' , '  ' , reg.edad);
					writeln('Desea modificar la edad ?, ingrese si o no');
					readln(ok);
					if(ok = 'si')then
						begin
							modificarE(archivoLogico, reg);
						end;	
				end;
			writeln('Ya no mas empleaods en la lista');
			close(archivoLogico);
		end;
	
	procedure existe(var archivoLogico: archivo; num: integer; var ok: boolean);
	var	
		reg: empleado;
		begin
			ok := false;
			while(not eof(archivoLogico)and(ok))do
				begin
					read(archivoLogico, reg);
					if(reg.numEmp = num)then
						ok:= true;
				end;	
			close(archivoLogico);	
		end;
	
	// Se pre-supone que el archivo existe	
	procedure agregarEmpleado(var archivoLogico: archivo);	
	var 
		reg: empleado;
		ok : boolean;
		begin
			writeln('Para finalizar la carga ingrese apellido "fin"');
			cargarRegistro(reg);
			while(reg.apellido <> 'fin')do
				begin
					reset(archivoLogico);
					existe(archivoLogico, reg.numEmp,ok);
					if(ok)then
						writeln('El empleado existe, ingrese otro')
					else	
						seek(archivoLogico,fileSize(archivoLogico));
						write(archivoLogico, reg);
					cargarRegistro(reg);
				end;		
			close(archivoLogico);				
		end;
		
	// Exportar el contenido del archivo a un archivo 
	// de texto llamado “todos_empleados.txt”.	
		
	procedure exportarTodosEmpleados(var archivoLogico: archivo; var todos_empleados: Text);
	var
		reg:empleado;
		begin
			reset (archivoLogico);
			rewrite (todos_empleados);
			while not eof (archivoLogico) do begin
				read (archivoLogico,reg);
				with reg do writeln (todos_empleados,'|NRO: ',numEmp:10,'|EDAD: ',edad:10,'|DNI: ',dni:10,'|APELLIDO: ',apellido:10,'|NOMBRE: ',nombre:10); 
			end;
		close (archivoLogico);
		close (todos_empleados)
		end;
	
//	Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
//	que no tengan cargado el DNI (DNI en 00).
	procedure exportarEmpleadosSinDni(var archivoLogico : archivo; var faltaDniEmpleado:text);
	var
		reg: empleado;
		begin
			reset (archivoLogico);
			rewrite (faltaDniEmpleado);
			while not eof (archivoLogico) do 
				begin
					read(archivoLogico,reg);
					if(reg.dni = 00)then
						with reg do writeln (faltaDniEmpleado,'|NRO: ',numEmp:10,'|EDAD: ',edad:10,'|DNI: ',dni:10,'|APELLIDO: ',apellido:10,'|NOMBRE: ',nombre:10); 
				end;
			close (archivoLogico);
			close (faltaDniEmpleado)
		end;	
		
	procedure menuSecundario(var archivoLogico : archivo);
	var
		ok : boolean;
		n  : integer;
		todos_empleados : text;
		faltaDNIEmpleado: text;
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
								1: agregarEmpleado(archivoLogico);
								2: modificarEdad(archivoLogico);				
								3: exportarTodosEmpleados(archivoLogico,todos_empleados);
								4: exportarEmpleadosSinDni(archivoLogico,faltaDniEmpleado); 	
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
		
	
	procedure desplegarMenu(var archivoLogico: archivo; nombre: String);
	var n: integer;
			ok: boolean;
		begin
			assign(archivoLogico,'Ejercicio4');
			ok := true;
			writeln('----------------menu de opciones----------------');
			writeln('Si desea crear un archivo nuevo       digite: 1');
			writeln('Abrir el archivo creado anteriormente digite: 2');
			writeln('Si desea ver mas opciones             digite: 3');
			writeln('si desea finalizar                    digite: 6');
			readln(n);
			while(ok)do
				begin
					if((n = 1)or(n = 2)or(n = 3))then
						begin
							case n of
								1: crearArchivo(archivoLogico);
								2: abrirArchivo(archivoLogico);				
								3: menuSecundario(archivoLogico);	
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
	archivoLogico   : archivo;
	faltaDniEmpleado:text;
	todos_empleados :text;
	nombre          : String;
begin
	textcolor(02);
	clrscr;
	writeln('ingrese el nommbre del archivo');
	readln(nombre);
	desplegarMenu(archivoLogico,nombre);
	writeln('TE FELICITO ADRIAN, SOS UN CAPO');
end.
