program operacionesBasicas;

type 
	
	acotado = String[10];
	
	alumno = record
		nombre:acotado;
		apellido:acotado;
		legajo:acotado;
	end;
	
	{declaracion de archivos}
	
	archivo = file of alumno;
	

var
	archivoAlumno:archivo;
	a:alumno;
	b:alumno;
begin
	{hacer las asignaciones del archivo fisico con el logico}
	Assign(archivoAlumno,'archivoAlumno.dat');
	
	{creacion del archivo}
	Rewrite(archivoAlumno);
	
	{cargamos un alumno}
	writeln('ingrese datos del alumno:');
	write('nombre: ');readln(a.nombre);
	write('apellido: ');readln(a.apellido);
	write('legajo: ');readln(a.legajo);
	
	{escribimos en el archivo}
	write(archivoAlumno,a);

   {cargamos otro alumno}
	writeln('ingrese datos del alumno:');
	write('nombre: ');readln(a.nombre);
	write('apellido: ');readln(a.apellido);
	write('legajo: ');readln(a.legajo);

	{escribimos en el archivo}
	write(archivoAlumno,a);


	{reseteamos posicion}
	reset(archivoAlumno);
	
	writeln('-----------------------------------------');
	
	{posicion del elemento b}
	writeln('posicion actual: ', filePos(archivoAlumno));
	
	{peso/diml? del archivo}
	writeln('tamanio/diml archivo: ', fileSize(archivoAlumno));
	
	{recuperamos archivo}
	read(archivoAlumno,b);
	
	writeln('-----------------------------------------');
	
	{imprimimos datos de lo que recuperamos}
	writeln('datos de nuestro archivo:');
	write('nombre: ');writeln(b.nombre);
	write('apellido: ');writeln(b.apellido);
	write('legajo: ');writeln(b.legajo);
	
	{ir a posicion determinada}
	seek(archivoAlumno,1);
	{recuperamos archivo}
	read(archivoAlumno,b);
	
	writeln('-----------------------------------------');
	
	{imprimimos datos de lo que recuperamos}
	writeln('datos de nuestro archivo en pos 1:');
	write('nombre: ');writeln(b.nombre);
	write('apellido: ');writeln(b.apellido);
	write('legajo: ');writeln(b.legajo);
	
	writeln('-----------------------------------------');
	writeln('estamos en EOF? : ', eof(archivoAlumno), ' <- da true porque solo cargamos un elemento');
	{cerramos archivo}
   readln;
	close(ArchivoAlumno);
   readln;
end.
