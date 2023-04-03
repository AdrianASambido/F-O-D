{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}

program Ejercicio_1;

uses crt;
const valorAlto = 9999;
type

empleado =	record
							codigoEmp: integer;
							nombre 	 : String[20];
							monto    : real;
						end;
		
archivoL = file of empleado;

{------------------------------------------------}

		procedure leer(var detalle: archivoL;var reg: empleado);
			begin
				if(not eof (detalle))then
					read(detalle, reg)
					else
						reg.codigoEmp := valorAlto;
			end;
	
{------------------------------------------------}

						
	procedure compactar(var detalle: archivoL; var maestro: archivoL);
	var
	reg, aux: empleado;
	total : real;
		begin
			assign(maestro, 'maestro.dat');
			assign(detalle, 'detalle.dat');
			reset(detalle);
			rewrite(maestro);
			read(detalle, reg);
			while(not eof(detalle))do begin
				aux  := reg; 
				total:= 0;
				while(not eof(detalle)and(aux.codigoEmp = reg.codigoEmp))do begin
					total := total + reg.monto;
					read(detalle, reg);
				end;
				aux.monto:= total;
				write(maestro,aux);
			end;
			close(maestro);
			close(detalle);
		end;
	
	
var
detalle, maestro: archivoL;	
	
begin
	textcolor(lightgreen);
	compactar(detalle, maestro);
end.	
	
