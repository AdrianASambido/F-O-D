{3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
		De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
		stock mínimo y precio del producto.
			Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
		debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
		maestro. La información que se recibe en los detalles es: código de producto y cantidad
		vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
		descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
		debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
			puede venir 0 o N registros de un determinado producto.}

program Ejercicio_3;
const dimF = 30;

type
	producto= record
							nombre		 		 : String[20];
							descripcion		 : String[20];
							codigoPro	 		 : integer;
							stockDisponible: integer;
							precio				 : real;
							stockMinimo		 : string;
						end;
						
	prodVendido = record
									codigoPro	 		 : integer;
									cantidadVendida: integer;
								end;
								
	maestro = file of producto;
	detalle = file of	prodVendido;
	vecDeDetelle = array[1..dimF] of detalle;{Vector de archivos de detalle}
								
	procedure cargarDetalles(var vector: vecDeDetelle);							
		var
			i: integer;
			a: String;
		begin
			for i:= 1 to dimF do begin
				str(i,a);  {convierto el valor entero de i en un string en "a"}
				assign(vector[i],'sucursal'+a );{concateno String}
			end;
		end;							
								
var								
	mae   : maestro;
	vector: vecDeDetelle;				
begin
	assign(mae,'Ejercicio_3');
	reset(mae);
	cargarDetalles(vector);
end.
