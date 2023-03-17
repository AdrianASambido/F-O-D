{ Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
  creados en el ejercicio 1, 
  a)- Informe por pantalla cantidad de números menores a 1500 
  b)- El promedio de los números ingresados. 
  c)- El nombre del archivo a procesar debe ser
  proporcionado por el usuario una única vez. Además, 
  d)- El algoritmo deberá listar el contenido del archivo en pantalla.}

program Ejercicio_2;
	uses crt;
  type
    archivoFisico = file of integer;

  procedure menoresAYPromedio(var archivo: archivoFisico);
  var num , total, valor: integer;
			promedio : real;
		begin
			valor:= 0;
			total:= 0;
			while(not eof(archivo))do begin
				read(archivo, num);
				total:= total + num;
				if(num < 1500)then
					valor := valor +1;
			end;
			promedio:= total/fileSize(archivo);
			close(archivo);
			writeln('---------------------------------------');
			writeln('La cantidad de numeros menores a 1500 son : ' , valor);
			writeln('---------------------------------------');
			writeln('el promedio de los numeros del archivo es' , promedio);
			writeln('---------------------------------------');
		end;
		
	procedure imprimir(var archivo: archivoFisico);
	var num: integer;
		begin
			reset(archivo);
			while(not eof(archivo))do begin
				read(archivo, num);
				writeln('en el lugar : ' , filePos(archivo)-1, 'esta el : ' , num);
			end;
		end;

var
  archivo : archivoFisico;
  nom: String;
begin
  textcolor(02);
  //nom := 'Ejercicio1'; //este es el nombre a ponerle al archivo
  writeln('Ingrese el nombre del archivo'); readln(nom);
  assign(archivo,nom);
  reset(archivo);
  menoresAYPromedio(archivo);
  imprimir(archivo);
  writeln('---------------------------------------'); 
  close(archivo);
end.
