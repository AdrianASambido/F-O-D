{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripción, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
debería respetar el formato dado para este tipo de archivos en la NOTA 2.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}

program Ejercicio_5;
uses crt;
type

celular = record
							codigo   	 		 : integer;
							precio	 			 : integer;
							marca	 			 	 : String[20];
							stockDisponible: integer;
							stockMinimo 	 : integer;
							descripcion  	 : String[20];
							nombre 	 			 : String[20];
							
							
						end;
archivo = file of celular;

	procedure crearArchivo(var ar: archivo; var tex: text);
	var 
		dato  : celular;
		begin
		//	writeln('ingrese un nombre para el archivo');readln(nombre)
			assign(ar,'ejercicio_5'); {el nombre sera, ejercicio5 }
			rewrite(ar);
			reset(tex);
			writeln('Antesde entrar al while');
			while(not eof(tex))do
				begin
					writeln('entre al while');
					with dato do begin
							writeln('entre al while');
							readln(tex,codigo,precio,marca); {En dato guardo de a tres campos}
							writeln('entre al while');
							readln(tex,stockDisponible,stockMinimo, descripcion);
							readln(tex,nombre );
						end;
					writeln('Antes de cargar el archivo');		
					write(ar,dato);
					writeln('Antes de salir del while');
				end;
			writeln('El archivo se cargo correctamente');
			close(ar);
			close(tex);	
		end;
		
	procedure imprimir(reg: celular);
			begin
				with reg do begin
					writeln('Celulares cuyo con stock es menor al minimo');
					writeln('|CODIGO|', codigo , ' | ' , '|PRECIO', precio, ' | ' , 'MARCA' , marca);
					writeln('|STOCK DISPONIBLE', StockDisponible , ' | ' , '|STOCK MINIMO',stockMinimo);
					writeln('|NOMBRE' , ' | ' , nombre);
				end;
			end;
		
	procedure stockMinimo(var ar: archivo);
	var reg: celular;
		begin
			reset(ar);
			while(not eof(ar))do
				begin
					read(ar,reg);
					if(reg.stockDisponible < reg.stockMinimo)then
						imprimir(reg);
				end
		end;
	
	procedure buscarCadena(var ar: archivo);
	var ok    : boolean;
			reg   : celular;
			cadena: String;
		begin
			ok:= false;
			reset(ar);
			writeln('Ingrese el nombre del equipo'); readln(cadena);
			cadena := ' '+cadena; {Se le agrega un caracter para que coincida con el registro}
			while(not eof (ar))do
				begin
					read(ar,reg);
					if(reg.nombre = cadena)then
						imprimir(reg);
						ok:= true;
				end;
			if(not ok)then
				writeln('No hay coincidencias');
			close(ar);	
		end;
		
	procedure exportarArchivo(var ar: archivo; var texExport: text);
	var nombre: String;
			reg: celular;
		begin
			reset(ar);
			writeln('Ingrese un nombre para el archivo de texto a exportar');read(nombre);
			assign(texExport, nombre);{el nombre del archivo sera 'texto'}
			rewrite(texExport);
			while(not eof (ar))do
				begin
					read(ar,reg);
					with reg do  
						begin
							writeln(texExport,codigo,precio,marca);
							writeln(texExport,stockDisponible,stockMinimo, descripcion);
							writeln(texExport,nombre);
						end	
				end;
			close(ar);	
			close(texExport);
		end;
	
		
		
	procedure desplegarMenu(var ar: archivo; var tex: text; var texExport :text);
	var
		ok : boolean;
		car: char;
		num: integer;
		begin
			ok:= true;
			while(ok)do
				begin
					writeln('---------------- Menu principal -------------------');
					writeln('------------ Ingrese la opcion deseada ------------');
					writeln('Crer un nuevo archivo desde el archivo "celulares.txt" ..................ingrese 1');
					writeln('Listar los celulares que contengan un stock menor al stock minimo .......ingrese 2' );
					writeln('Buscar un celular por su nombre .........................................ingrese 3');
					writeln('Exportar el archivocreado e el inciso A a uno de texto “celulares.txt” ..ingrese 4');
					readln(num); 						 
					if(num=1)or(num=2)or(num=3)or(num=4)then
						begin
							case num of 
								1: crearArchivo(ar,tex);
								2: stockMinimo(ar);
								3: buscarCadena(ar);
								4: exportarArchivo(ar,texExport);
							end;
						end;	
						writeln('ingrese cualquier caracter para conntinuar, ingrese la letra "a" para finalizar');
						readln(car);
						if(car = 'A')or (car = 'a')then
							ok := false;
				end;
		end;
	
	
var
		ar    				: archivo;
		tex, texExport: text;
begin
	assign(tex,'celulares.txt');
	desplegarMenu(ar,tex,texExport);
end.
