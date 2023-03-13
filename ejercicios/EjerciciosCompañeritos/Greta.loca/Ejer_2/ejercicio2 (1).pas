{2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}

program ejercicio2;

type
	
	archivo = file of integer;
	
function promedio(suma,cant:integer):real;
	begin
		promedio:=suma/cant;
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
	
procedure numerosMenores(var a:archivo);
	var
		num,cant,cantTotal,suma:integer;
	begin
		reset(a); {iniciamos archivo en pos 0}
		cant:=0; 
		cantTotal:=0; 
		suma:=0;
		while(not eof(a)) do begin
			read(a,num); {recupero valor}
			cantTotal:=cantTotal+1; {cantidad total de numeros}
			suma:=suma+num; {suma de todos los numeros}
			if(num > 1500)then
				cant:=cant+1;
		end;
		writeln('promedio de numeros ingresados: ', promedio(suma,cantTotal):2:2);
		writeln('cantidad de numeros mayores a 1500: ',  cant);
	end;
	
var
	archivoLogico:archivo;
	archivoFisico:String;
begin
	archivoFisico:='ejercicio1';
	Assign(archivoLogico,archivoFisico); {asignamos el archivo anterior}
	
	writeln('contenido archivo'); {recorremos archivo anterior}
	writeln('-----------------');
	recorrerArchivo(archivoLogico);
	writeln;
	
	writeln('ejercitacion con archivos'); {operamos con archivo}
	writeln('-------------------------');
	numerosMenores(archivoLogico);
	
	{cerramos archivo}
	close(archivoLogico);
end.


