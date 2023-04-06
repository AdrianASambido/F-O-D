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
			valorAlto = 9999;
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
								
	archMaestro		 = file of producto;
	archDetalle 	 = file of	prodVendido;
	vecDeDetalle   = array[1..dimF] of archDetalle;{Vector de archivos de detalle}
	vecDeRegistros = array[1..dimF] of prodVendido;{Vector de registros de detalle}
	
	//El vector de detalles ya viene cargado con los archivos							
	procedure cargarDetalles(var vecD: vecDeDetalle; var vecR: vecDeRegistros);							
		var
			i		: integer;
			a		: String;
			regD: prodVendido;
		begin
			for i:= 1 to dimF do begin
				str(i,a);  {convierto el valor entero de i en un string en "a"}
				assign(vecD[i],'sucursal'+a );{concateno String, y lo asigo a cada archivo}
				reset(vecD[i]);
				read(vecD[i],regD);
				vecR[i]:= regD;
				close(vecD[i]); 
			end;
		end;							
		
	{--------------------------------------------------------------}	
	
	procedure minimo(var vecR : vecDeRegistros; var min : prodVendido);
	var
		i, pos : integer;
		begin
		min.codigoPro := valorAlto;
		for i := 1 to dimF do begin
			if(vecR[i].codigoPro < min.codigoPro) then begin
				min := vecR[i];
				pos := i;
			end;
		end;
		if(min.codigo <> valorAlto)then
			
		
		end;
	
		
		
	procedure merge(var maestro: archMaestro);
	var
		begin
		
		end;
					
var								
	maestro   : archMaestro;
	vecDeDetalle: vecDeDetelle;				
begin
	assign(mae,'Ejercicio_3');
	reset(mae);
	cargarDetalles(vecD);
end.
