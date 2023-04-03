{6. Agregar al menú del programa del ejercicio 5, opciones para:
		a. Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.
		b. Modificar el stock de un celular dado.
		c. Exportar el contenido del archivo binario a un archivo de texto denominado:
				”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}

program Ejercicio_6;
uses crt;
type

celular = record
							codigo   	 		 : integer;
							precio	 			 : real;
							marca	 			 	 : String[20];
							stockDisponible: integer;
							stockMinimo 	 : integer;
							descripcion  	 : String[20];
							nombre 	 			 : String[20];
						end;
archivo = file of celular;

	procedure crearArchivo(var ar: archivo; var tex: text);
	var 
		dato: celular;
	//	nombre: String;
		begin
			rewrite(ar);
			reset(tex);
			while(not eof(tex))do
				begin
					writeln('entre al while');
					with dato do begin
							readln(tex,codigo,precio,marca); {En dato guardo de a tres campos}
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
		
	procedure copiarAtexto(var t: text; reg:celular);
		begin
			with reg do  begin
				writeln(codigo,precio,marca);
				writeln(stockDisponible,stockMinimo, descripcion);
				writeln(nombre);
			end;
			close(t);
		end;
		
	// inmporta todo el archivo binario a un archivo de texto	
	procedure exportarArchivo(var ar: archivo; var texExport: text);
	var nombre: String;
			reg: celular;
		begin
			reset(ar);
			writeln('Ingrese un nombre para el archivo de texto a exportar');read(nombre);
			assign(texExport,nombre);{el nombre del archivo sera 'texto'}
			rewrite(texExport);
			while(not eof (ar))do
				begin
					read(ar,reg);
					copiarAtexto(texExport,reg);
				end;
			close(ar);	
			close(texExport);
		end;
	
	procedure cargarRegistro(var reg: celular);
		begin
			writeln('ingrese codigo'); readln(reg.codigo);
			writeln('ingrese precio'); readln(reg.precio);
			writeln('ingrese marca'); readln(reg.marca);
			writeln('ingrese stock disponible'); readln(reg.stockDisponible);
			writeln('ingrese stock minimo'); readln(reg.stockMinimo);
			writeln('ingrese descrpcion'); readln(reg.descripcion);
			writeln('ingrese nombre'); readln(reg.nombre);
		end;
	
	procedure agregarCelulares(var ar: archivo);
	var
		reg: celular;
		ok : boolean;
		l  : char;
		begin
			ok:= true;
			seek(ar,fileSize(ar));
			while(ok)do begin
				cargarRegistro(reg);
				write(ar,reg);
				writeln('Para finalizar ingrese la letra ' , 'a' , '  ' , 'para continuar ingrese cualquier caracter'); 
				readln(l);
				if((l='a')or(l='A'))then
					ok := false;
			end;
		close(ar);		
		end;
		
		
		
	procedure actualizarStock(var ar: archivo);
	var n	 : String;
			reg: celular;
			i  : integer;
		begin
			reset(ar);
			read(ar,reg);
			writeln('Ingrese el nombre del celular a cual desea actualizar el stock');readln(n);
			while((not eof (ar))and(n<>reg.nombre))do begin
				read(ar,reg);	
			end;
			if(reg.nombre<>n)then
				writeln('No se encontraron coincidencias')
				else begin
					writeln('Actualice el stock del celular ', '  ' , reg.nombre, '  ' ,'ingrese un valor entero'); 
					readln(i);
					reg.stockDisponible:= i;
					write(ar, reg);
					writeln('Operacion realizada con exito')
				end;
			close(ar);
		end;
	
	procedure sinStock(var ar: archivo;var tCero: text);	
	var
		reg: celular;
		n	 : String;
		begin
			writeln('Ingrese un nombre para el archivo de texto de los celulares sin stock');readln(n);
			assign(tCero,n);
			rewrite(tCero);
			reset(tCero);
			reset(ar);
			read(ar,reg);
			while(not eof(ar))do begin
				if(reg.stockDisponible = 0)then
						copiarAtexto(tCero,reg);
				read(ar,reg);
			end;
		close(ar);
		end;
		
	procedure desplegarMenu(var ar: archivo; var tex: text; var texExport :text; var tCero: text);
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
					writeln('Listar los celulares que contengan un stock menor al stock minimo .......ingrese 2');
					writeln('Buscar un celular por su nombre .........................................ingrese 3');
					writeln('Exportar el archivo creado e el inciso A a uno de texto .................ingrese 4');
					writeln('Agregar un celulares al archivo .........................................ingrese 5');
					writeln('Actualizar stock de un celular determinado...............................ingrese 6');
					writeln('Obtener listado de los celulares sin stock en un archivo ”SinStock.txt” .ingrese 7');
					readln(num); 						 
					if(num=1)or(num=2)or(num=3)or(num=4)then
						begin
							case num of
								1: crearArchivo(ar,tex);
								2: stockMinimo(ar);
								3: buscarCadena(ar);
								4: exportarArchivo(ar,texExport);
								5: agregarCelulares(ar);
								6: actualizarStock(ar);
								7: sinStock(ar,tCero);
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
		tex, texExport, tCero: text;
begin
	textcolor(lightgreen);
	//	writeln('ingrese un nombre para el archivo');readln(nombre);
	assign(ar,'ejercicio6'); {el nombre sera, ejercicio6 }
	assign(tex,'celulares.txt');
	desplegarMenu(ar,tex,texExport, tcero);
end.
