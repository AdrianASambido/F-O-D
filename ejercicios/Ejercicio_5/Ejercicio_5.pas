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

type

celular = record
							codigo   	 		 : integer;
							nombre 	 			 : String[20];
							descripcion  	 : String[20];
							marca	 			 : String[20];
							precio	 			 : real;
							stockMinimo 	 : integer;
							stockDisponible: integer;
						end;
archivo = file of celular;

	procedure cargarArchivo(var ar: archivo; var tex: text);
	var 
		dato: celular;
		begin
			reset(tex);
			reset(ar);
			while(not eof(tex))do
				begin
					with dato do begin
							readln(tex,codigo,nombre,descripcion);
							readln(tex,marca,precio,stockMinimo);
							readln(tex, stockDisponible);
						end;
					write(ar,dato);
				end;
		end;
		
	procedure stockMinimo(var ar: archivo);
		begin
			reset(ar);
			while(not eof(ar)do
				begin
					
				
				end
		  
		end;
	
		
		
	procedure desplegarMenu(var ar: archivo);
	
	
var
		ar    : archivo;
		tex   : text;
		nombre: String;
begin
	assign(tex,'celulares.txt');
	writeln('ingrese un nombre para el archivo');readln(nombre);
	assign(ar,nombre); {el nombre sera, ejercicio5 }
	reWrite(ar);
	desplegarMenu(ar,text);
end.
