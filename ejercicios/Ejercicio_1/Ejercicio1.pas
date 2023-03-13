{ Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
  incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
  archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
  se ingrese el número 30000, que no debe incorporarse al archivo.}

program Ejercicio1;

uses crt;
type
   archivoFisico = file of integer;
   
	 procedure imprimir(var archivo: archivoFisico);
	 var dato: integer;
		begin
			reset(archivo);
			while(not eof(archivo))do
				begin
					read(archivo, dato);
					writeln(dato);
				end;
		end;
   
var
   archivo : archivoFisico;
   n : integer;
   nombre : String;
begin
   textcolor(02);
   writeln('Ingrese el nombre del archivo'); readln(nombre);
   writeln('El nombre del archivo es: ', nombre);
   assign(archivo,'Ejercicio1');
   rewrite(archivo);
   writeln('Ingrese numeros enteros, finalice la carga ingresando 30000');
   readln(n);
   while(n <> 30000)do   begin
     write(archivo,n);
     writeln('Ingrese un número entero');
     readln(n);
     writeln('--------------------------------');
   end;
   imprimir(archivo);
   writeln('--------------------------------');
   writeln('La carga finalizo con exito');
   close(archivo);
end.

