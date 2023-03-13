{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}

program ejercicio1;

type
	
	archivo = file of integer;
	
procedure cargarArchivo(var a:archivo); {cargamos valores a nuestro archivo}
	var
		num:integer;
	begin
		write('ingrese un numero: ');readln(num);
		while(num <> 3000)do begin
			write(a,num);
			write('ingrese un número: ');readln(num);
		end;
	end;
	
procedure recorrerArchivo(var a:archivo); {recorremos el archivo, imprimiendo los datos}
	var
		num:integer;
	begin
		reset(a); {lo dejamos en la posicion inicial}
		while(not eof(a))do begin
			read(a,num);
			writeln(num);
		end;
	end;

var
	archivoInteger:archivo;
	nombreArchivo:String;
begin
	write('ingrese el nombre para su archivo: ');readln(nombreArchivo); 
	{ ^
	* | estoy ingresando el nombre 'ejercicio1 
	para poder usarlo con el ejercicio2'}
	
	{asignamos el archivo logico con su nombre}
	Assign(archivoInteger,nombreArchivo);
	
	writeln('------------------------------------------------------');
	
	{creamos el archivo}
	rewrite(archivoInteger);
	
	{cargamos numeros}
	cargarArchivo(archivoInteger);
	
	writeln('-------------lista de integers ingresados-------------');
	
	{imprimimos contenido del archivo}
	recorrerArchivo(archivoInteger);
	
	{cerramos archivo}
	close(archivoInteger);
end.
