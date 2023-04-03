{7. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código de novela, nombre,
género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.
IMPORTANTE:Se recomienda implementar los ejercicios prácticos en Dev-Pascal. El ejecutable
puede descargarse desde la plataforma Ideas.}

program Ejercicio_7;
uses crt;

type

novela= record
					cod   : integer;
					precio: real;
					genero: String[20];
					nombre: String[20];
				end;

archivo= file of novela;

procedure crearArchivo(var ar: archivo; var texOrigen: text);
var 
	reg: novela;
		begin
			rewrite(ar);
			reset(texOrigen);
			while(not eof (texOrigen))do begin
				with reg do begin
					readln(texOrigen,cod,precio,genero);
					readln(texOrigen,nombre);
				end;
				write(ar,reg);
			end;
			close(ar);
			close(texOrigen);
		end;
	
	procedure cargarRegistro(var reg: novela);
		begin
			with reg do begin
				writeln('ingrese codigo'); readln(cod);
				writeln('ingrese precio'); readln(precio);
				writeln('ingrese genero'); readln(genero);
				writeln('ingrese nombre'); readln(nombre);
			end;
		end;	
		
	procedure agregarNovela(var ar: archivo);
	var
		reg: novela;
		ok : boolean;
		l  : char;
		begin
			ok:= true;
			reset(ar);
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
		
	procedure modificar(var ar:archivo);
	var
		reg : novela;
		n, d: integer;
		ok  : boolean;
		l   : char;
		begin
			ok:= true;
			reset(ar);
			writeln('ingrese el codigo de la novela a modificar'); readln(n);
			while(not eof(ar))do begin
				read(ar,reg);
				if(n=reg.cod)then begin
					while(ok)do begin
						writeln('Elija el numero de campo a modificar de a uno a la vez: uno(1) para codigo, dos(2) para precio, tres(2)para genero, cuatro() para nombre');
						readln(d);
						case d of 
							1:  begin 
										writeln('ingrese codigo'); readln(reg.cod);
									end;	
							2: 	begin
										writeln('ingrese precio'); readln(reg.precio);
									end;	
							3: 	begin
										writeln('ingrese genero'); readln(reg.genero);
									end;	
							4: 	begin
										writeln('ingrese nombre'); readln(reg.nombre);
									end	
							else
									writeln('opcion no valida');
					end;	
				end;
						writeln('Si desea seguir haiendo modificaciones preciones cualquier tecla, sino precione a ');
						readln(l);
						if((l='a')or(l='A'))then
							ok := false;
				end;
			end;
		end;
		
		
	
 //Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
 // una novela y modificar una existente	
	procedure modificarArchivo(var ar: archivo);	
	var
		n  : integer;
		ok : boolean;
		l  : char;
		begin
			ok:= true;
			writeln('Que desea hacer, 1 , agregar una novela, 2 , modificar una Existente'); readln(n);
			reset(ar);
			while(ok)do begin
				if(n=1)then
					agregarNovela(ar)
					else
						if(n=2)then
							modificar(ar)
							else
								writeln('Opcion incorrecta intentelo de nuevo');	
				writeln('Para finalizar ingrese la letra ' , 'a' , '  ' , 'para continuar ingrese cualquier caracter'); 
				readln(l);
				if((l='a')or(l='A'))then
					ok := false;
			end;					
			close(ar);
		end;
	
	procedure menu(var ar:archivo; var texOrigen: text);	
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
					writeln('Crer un nuevo archivo desde el archivo "novelas.txt" ..ingrese 1');
					writeln('modificar una novela...................................ingrese 2');
					readln(num); 						 
					if(num=1)or(num=2)then
						begin
							case num of
								1: crearArchivo(ar,texOrigen);
								2: modificarArchivo(ar);
							end;
						end;	
						writeln('ingrese cualquier caracter para conntinuar, ingrese la letra "a" para finalizar');
						readln(car);
						if(car = 'A')or (car = 'a')then
							ok := false;
				end;
		end;
		
var
	ar			 : archivo;
	texOrigen: text;
begin
	textcolor(lightgreen);
	assign(ar,'novela');
	assign(texOrigen,'novelas.txt');
	menu(ar,texOrigen);
end.	
