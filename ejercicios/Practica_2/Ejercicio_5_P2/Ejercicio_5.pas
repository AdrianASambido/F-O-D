{ 5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos
*    de toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
     información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
     en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo 
*    maestro reuniendo dicha información.
  Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
     nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
     del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
     padre.
  En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
     apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
     lugar.
  Realizar un programa que cree el archivo maestro a partir de toda la información de los
     archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
     apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
     apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
     además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
     deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
      Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la 
    * persona y además puede no haber fallecido.}

program Ejercicio_5;

const dimF = 50;
 valorAlto = 9999;

type
 
		 rDeceso			= record //registro de fallecidos, icluido en el de personas del maestro
											dni                                     : String[25];
											matricula_del_medico_que_firma_el_deceso: String[25];
											fecha_del_deceso			  							  : String[25];
											hora_del_deceso			  	 							  : String[25];
											lugar_del_deceso	 				  					  : String[25];	// partido o delegacion
										end;
									 
     rDirecciones = record  //registro incluido en el registro de nacidos
											calle : String[25];
											nro   : integer;
											piso  : integer;
											depto : integer;
											ciudad: String[25];
										end;
     
nacido = record   // registro para los archivos detalle
													nro_partida_nacimiento			 : integer;
													nombre_apellido							 : String[25];													
													direccion										 : rDirecciones;
													matricula_del_medico				 : integer;
													nombre_y_apellido_de_la_madre: String[25];
													DNI_madre										 : integer;
													nombre_y_apellido_del_padre	 : String;
													DNI_del_padre								 : integer;
												end;
												
fallecido = record // registro para los archivos detalle 
							nro_partida_nacimiento: integer;
							nombre_apellido				: String[25];
							deceso 							: rDeceso;
						end;


persona = record	 // registro para el archivo maestro
						nacimiento: nacido;
						defuncion : rDeceso ; 
						fallecio 	: boolean;
					end;	
					
archi_maestro = file of persona;
detalleN 			= file of nacido;
detalleF 			= file of fallecido;

vec_de_detalleN  = array [1..dimF] of detalleN;
vec_de_detalleF  = array [1..dimF] of detalleF;
vec_de_registroN = array [1..dimF] of nacido;
vec_de_registroF = array [1..dimF] of fallecido;


	procedure leerN (var regN: nacido; var archivoN: detalleN);
		begin
			if(not eof(archivoN))then
				read(archivoN,regN)
				else
					regN.nro_partida_nacimiento := valorAlto;
		end;
	
	{------------------------------------------------------------------------------------}

	procedure leerF(var regF: fallecido; var archivoF: detalleF);
		begin
			if(not eof(archivoF))then
				read(archivoF,regF)
				else
					regF.nro_partida_nacimiento := valorAlto;
		end;
	
	{------------------------------------------------------------------------------------}
		
	procedure closeDetalles(var vecNacidos: vec_de_detalleN; var vecFallecidos: vec_de_detalleF);	
	var
		i: integer;
		begin
			for i := 1 to dimF do begin
				close(vecNacidos[i]);
				close(vecFallecidos[i]);
			end;
		end;
	
	
	{------------------------------------------------------------------------------------}
	//recibe los vectores de detalle y los asigna, y guarda los primeros registros de c/u 
	procedure  cargarVectores(var vecNacidos: vec_de_detalleN; var vecFallecidos: vec_de_detalleF; 
							var vecRnacidos: vec_de_registroN; var vecRfallecidos: vec_de_registroF);
	var 
		i : integer;
		a : String;
		begin
			for i := 1 to dimF do begin
				str(i,a);
				assign(vecNacidos[i],'delegacion' + a);
				assign(vecFallecidos[i],'delegacion' + a);
				reset(vecNacidos[i]);
				reset(vecFallecidos[i]);
				leerN (vecRnacidos[i],vecNacidos[i]);
				leerF(vecRfallecidos[i],vecFallecidos[i]);
			end;
		end;

	{------------------------------------------------------------------------------------}
	
	procedure minimoN (var vecRnacidos: vec_de_registroN; var vecNacidos: vec_de_detalleN;
										 var minN: nacido);
	var
		pos, i: integer;
		begin
			minN.nro_partida_nacimiento := valorAlto;
			for i := 1 to dimF do begin
				if(vecRnacidos[i].nro_partida_nacimiento < minN.nro_partida_nacimiento)then
					minN := vecRnacidos[i];
					pos := i;			
			end;
			if(minN.nro_partida_nacimiento <> valorAlto)then
				leerN(vecRnacidos[pos], vecNacidos[pos]);
		end;
	
	{------------------------------------------------------------------------------------}
	
	procedure minimoF(var vecRfallecidos: vec_de_registroF; var vecFallecidos: vec_de_detalleF ; 
										var minF : fallecido);
	var pos, i : integer;									
		begin
			minF.nro_partida_nacimiento := valorAlto;
			for i := 1 to dimF do begin	
				if(vecRfallecidos[i].nro_partida_nacimiento < minF.nro_partida_nacimiento)then
					minF := vecRfallecidos[i];
					pos := i;	
			end;		
			if(minF.nro_partida_nacimiento <> valorAlto)then
				leerF(vecRfallecidos[pos], vecFallecidos[pos]);		
		end;	
	
	{------------------------------------------------------------------------------------}
	
	procedure noMuerto(var regM : fallecido);
		begin
			regM.deceso.dni                                   	:= ' ';
			regM.deceso.matricula_del_medico_que_firma_el_deceso:= ' ';
			regM.deceso.fecha_del_deceso			  							  := ' ';
			regM.deceso.hora_del_deceso			  	 							  := ' ';
			regM.deceso.lugar_del_deceso	 				  					  := ' ';
		end;
	
	{------------------------------------------------------------------------------------}
	
	procedure cargarMaestro(var maestro: archi_maestro ; var vecNacidos: vec_de_detalleN; var vecFallecidos: vec_de_detalleF;	
													var vecRnacidos: vec_de_registroN; var vecRfallecidos: vec_de_registroF);						
	var									 	
		minN: nacido;
		minF: fallecido; //los tres son redistro de cada uno de los tipos
		regM: persona;
		begin
			minimoN(vecRnacidos,vecNacidos,minN);    //busco el minimo en nacidos
			minimoF(vecRfallecidos,vecFallecidos,minF); //busco el minimo en fallecidos
			while(minN.nro_partida_nacimiento <> valorAlto)do begin//pregunto solamente por nacidos	
				if(minN.nro_partida_nacimiento = minF.nro_partida_nacimiento)then begin
					regM.defuncion := minF.deceso;
					regM.fallecio  := true;
					minimoF(vecRfallecidos,vecFallecidos,minF);
				end
					else
						noMuerto(minF);		
				regM.nacimiento:= minN;
				write(maestro,regM);
				minimoN(vecRnacidos,vecNacidos,minN);		  	
			end;	
			close(maestro);
			closeDetalles(vecNacidos, vecFallecidos);	
		end;								
	
	{------------------------------------------------------------------------------------}	
	
	procedure procesarTexto(var maestro: archi_maestro; var texto: text);
	var
		regM: persona;
		begin
			reset(maestro);
			while(not eof(maestro))do begin
				read(maestro, regM);
				with regM do begin
					writeln(texto,'|NOMBRE y APELLIDO:', nacimiento.nombre_apellido, '|CALLE:',nacimiento.direccion.calle, 
									'|PISO', nacimiento.direccion.piso, '|DEPTO', nacimiento.direccion.depto,  
									'|CIUDAD', nacimiento.direccion.ciudad, '|MATRICULA MEDICO;',nacimiento.matricula_del_medico,
									'|NOMBRE Y APELLIDO DE LA MADRE:', nacimiento.nombre_y_apellido_de_la_madre, '|DNI MADRE:',nacimiento.DNI_madre,
									'|NOMBRE Y APELLIDO DEL PADRE:', nacimiento.nombre_y_apellido_del_padre, '|DNI PADRE', nacimiento.DNI_del_padre,
									'|DNI FALLECIDO:', regM.defuncion.rDeceso.dni,'|MATRICULA MEDICO:', defuncion.rDeceso.matricula_del_medico_que_firma_el_deceso,
									'| FECHA DEL DECESO:',defuncion.deceso.fecha_del_deceso,'|HORA DEL DECESO:',	defuncion.deceso.hora_del_deceso,
									'| LUGAR DEL DECESO: ', defuncion.deceso.lugar_del_deceso);
				end;
			end;
			close(texto);
			close(maestro);
		end;
	
	{------------------------------------------------------------------------------------}
	 
var
	maestro       : archi_maestro; 
	vecNacidos    : vec_de_detalleN;
	vecFallecidos : vec_de_detalleF;
	vecRnacidos   : vec_de_registroN;
  vecRfallecidos: vec_de_registroF;
  texto 				: text;
begin
	rewrite(maestro);
	assign(maestro,'maestro.dat');
	rewrite(texto);
	assign(texto,'Actualizado.tex');
	rewrite(texto);
	cargarVectores(vecNacidos,vecFallecidos,vecRnacidos,vecRfallecidos);
	cargarMaestro(maestro, vecNacidos,vecFallecidos, vecRnacidos, vecRfallecidos);
	procesarTexto(maestro,texto);
end.
