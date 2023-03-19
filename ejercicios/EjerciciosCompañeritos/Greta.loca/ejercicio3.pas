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

program ejercicio3;

uses crt; {biblioteca que encontré}

type
    empleado = record
        nombre:String[20];
        apellido:String[20];
        dni:String[20];
        edad:integer;
    end;

    archivo = file of empleado;

procedure cargarRegistro(var e:empleado);
    begin
        writeln('------------------------');
        write('apellido: ');readln(e.apellido);
        if(e.apellido <> 'fin')then begin
            write('nombre: ');readln(e.nombre);
            write('dni: ');readln(e.dni);
            write('edad: ');readln(e.edad);
        end;
    end;

procedure imprimirRegistro(e:empleado);
    begin
        writeln('------------------------');
        writeln('apellido: ', e.apellido);
        writeln('nombre: ',e.nombre);
        writeln('dni: ',e.dni);
        writeln('edad: ',e.edad);
        writeln;
    end;

procedure cargarArchivo(var a:archivo);
    var
        e:empleado;
    begin
		writeln('ingrese apellido "fin" para detener la carga');
        cargarRegistro(e);
        while(e.apellido <> 'fin')do begin
            write(a,e);
            cargarRegistro(e);
        end;
    end;

procedure crearArchivo(var a:archivo);
    begin
        rewrite(a);
        cargarArchivo(a);
        close(a);
    end;

procedure listarEmpleados(var a:archivo);
    var
			e:empleado;
    begin
        reset(a);
        while(not eof(a))do begin
            read(a,e);
            imprimirRegistro(e);
        end;
        close(a);
    end;

procedure listarEmpleadosPorNombreApellido(var a:archivo);
    var
        nombre:String;
        e:empleado;
    begin
        reset(a);
        writeln('ingrese nombre/apellido por el que desea buscar: ');readln(nombre);
        while(not eof(a))do begin
            read(a,e);
            if(e.nombre=nombre)or(e.apellido=nombre)then
                imprimirRegistro(e)
        end;
        close(a);
    end;

procedure empleadosJubilacion(var a:archivo);
    var
        e:empleado;
    begin
        reset(a);
        while(not eof(a))do begin
            read(a,e);
            if(e.edad >= 70)then
                imprimirRegistro(e)
        end;
        close(a);
    end;
    
procedure manipularArchivo(var a:archivo);
	var
		n:integer;
	begin
		n:=0;
		while(n<>3)do begin
			writeln('----------------------MANEJO DEL ARCHIVO----------------------');
			writeln('1: listar nombres');
			writeln('2: empleado por nombre');
			writeln('3: proximos a jubilarse');
			writeln('ingrese su opcion: ');readln(n);
			case n of
			1: listarEmpleados(a);
			2: listarEmpleadosPorNombreApellido(a);
			3: empleadosJubilacion(a);
			else 
				writeln('opcion invalida'); 
			end;
		end;
	end;

procedure archiveMenu(var a:archivo);
    var
      n:integer;
    begin
		n:= 0;
		while(n<>3)do begin
			writeln('----------------------MENU----------------------');
			writeln('1: crear archivo');
			writeln('2: manipular archivo existente');
			writeln('ingrese su opcion: ');readln(n);
			case n of
			1: crearArchivo(a);
			2: manipularArchivo(a);
			else 
				writeln('opcion invalida'); 
			end;
		end;
    end;

var
    a:archivo;
    nombre:String;
begin
	textcolor(10);
	writeln('NOMBRE ARCHIVO: ');readln(nombre);
	assign(a,'nombre');
  archiveMenu(a);
  close(a);
end.
