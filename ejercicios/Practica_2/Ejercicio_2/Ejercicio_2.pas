{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}

program Ejercicio_2;
const valorAlto = 9999;
type
	
	alumno = record						
							cantSinFinal: integer;
							cantConFinal: integer;
							nombre   		: String[20];
							codigoAlu		: integer;
							apellido 		: String[15];
					 end;
					 
	datos = record				 
						codigoAlu		 : integer;
						aprobofinal	 : boolean;
						aproboCursada: boolean;
					end;

	maestro= file of alumno;{contiene informacion de cada alumno}
	detalle= file of datos; {contiene informacion de matrrias de alumnos}
	
	
	{-------------------------------------------}
	
	procedure masDeCuatro(var mae: maestro; var tex: text);
	var 
		reg: alumno;
		begin
			rewrite(tex);
			reset(mae);
			while(not eof(mae))do begin
				read(mae, reg);
				if((reg.cantSinFinal - reg.cantConFinal)>4)then begin
					with reg do begin
						writeln(cantSinFinal,cantConFinal,nombre);
						writeln(codigoAlu,apellido);
					end;
					seek(mae, filePos(mae)-1);
					write(mae,reg);
				end;		
			end;
		end;
	
	{-------------------------------------------}
	
	procedure leer(var det: detalle; var reg: datos);
		begin
			if(not eof(det))then
				read(det,reg)
				else
					reg.codigoAlu:= valorAlto;
		end;
	
	
	{-------------------------------------------}
	
	procedure cargarMaestro(var mae: maestro;var regM: alumno; totalCursadas, totalFinal: integer);
		begin 
			regM.cantConFinal:= regM.cantConFinal + totalFinal;
			regM.cantSinFinal:= regM.cantSinFinal + totalCursadas;
			seek(mae, filePos(mae)-1);
			write(mae,regM);
			read(mae, regM);
		end;
	
 {-----incrementa la cursada y/o el final-----}
 	procedure actualizarDatos(var mae: maestro; var det: detalle);
 	var
		regM: alumno;{registro para  manejar maestro}
		regD: datos; {registro para  manejar detalle}
		actual, totalFinal,totalcursadas: integer;
		begin
			read(mae,regM);
			leer(det,regD);
			while(regD.codigoAlu<>valorAlto)do begin {Aqui se indica si el archivo de detalle termino}
				totalFinal	 := 0;
				totalCursadas:= 0;
				actual			 := regD.codigoAlu;
				while(regD.codigoAlu = actual)do begin
					if(regD.aproboCursada)then
						totalCursadas:= totalCursadas + 1;
					if(regD.aproboFinal)then
						totalFinal:= totalFinal + 1;
					leer(det,regD);
				end;
				cargarMaestro(mae, regM, totalCursadas, totalFinal);
			end;
			close(mae);
			close(det);
		end;

	
	{-------------------------------------------}

var
	mae: maestro;
	det: detalle;
	tex: text;
begin
	assign(mae,'maestro');
	assign(det,'detalle');
	assign(tex,'masDeCuatro');
	reset(mae);
	reset(det);
	actualizarDatos(mae,det);
end.
