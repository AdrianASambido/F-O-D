{ Realizar un programa que presente un menú con opciones para:
      a. Crear un archivo de registros no ordenados de empleados y completarlo con
         datos ingresados desde teclado. De cada empleado se registra: número de
         empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
         DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
      b. Abrir el archivo anteriormente generado y
      i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
         determinado.
      ii. Listar en pantalla los empleados de a uno por línea.
      iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}

program Ejercicio3;

type
	empleado = record
		numEmp : integer;
		apellido: String;
		nombre : String;
		edad: integer;
		dni: integer;
	end;

	archivo = file of empleado;

	procedure crearArchivo(var archivoFisico: archivo; nombre : String);
		begin
			assign(archivoFisico,nombre);
			rewrite(archivoFisico);
		end;
		
		
		
		
	procedure cargarArchivo(var archivoFisico: archivo);
		
		
		
	procedure desplegarMenu(var archivoFisico: archivo);
		begin
			case of 
			
		
		end;

var
	nombre : String;
	archivoFisico: archivo;
begin
	writeln('Imgrese el nombre del archivo a crear'); read(nombre);
	desplegarMenu(archivoFisico);
	crearArchivo(archivoFisico,nombre);
	cargarArchivo(archivoFisico);	
end.
