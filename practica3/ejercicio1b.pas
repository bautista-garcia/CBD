// Ejercicio de bajas fisicas
program ejercicio1
    const VALORALTO = 9999999;
    const CORTE = 100000;
    const MARCA = 
type 
    str4 = string[4];
    str30= string[30];
    str60 = string[60];
    registroEspecies = record
        cod: integer;
        nomV: str30;
        nomC: str30;
        alt: integer;
        descripcion: str60;
        zona: str30;
    end;

    archivoEspecies = file of registroEspecies;

// PROCEDURE SECTION
procedure leer(var archivo: archivoEspecies; var dato: registroEspecies);
begin
    if(not eof(archivo)) then 
        read(archivo, dato)
    else
        dato.cod := VALORALTO;
end;

procedure borrarFisico(var archivo: archivoEspecies; cod: integer);
var
    rEspecies, aux: registroEspecies;
    pos: integer;
begin
    reset(archivo);
    leer(archivo, rEspecies);
    while(rEspecies.cod <> VALORALTO) and (rEspecies.cod <> cod) do begin
        leer(archivo, rEspecies);
    end;

    if(rEspecies.cod <> VALORALTO) then begin
        pos := filepos(archivo) - 1;
        seek(archivo, filesize(archivo) - 1);
        read(archivo, aux);
        seek(archivo, pos);
        write(archivo, aux);
        seek(archivo, filesize(archivo) - 1);
        truncate(archivo);
    end;
    // Es necesario cerrarlo aca, si trabajamos con un conjunto de bajas?
end;


// MAIN
var 
    cod: integer;
    pos: integer;
    rEspecies, aux : registroEspecies;
    arch: archivoEspecies; 
begin
    // Espacio logico <=> Espacio Fisico
    assign(arch, "archivo.dat");

    // Me posiciono en filePos = 1
    reset(arch);

    // Borrado de input
    readln(cod);
    while (cod <> CORTE) do begin
        borrarFisico(arch, cod);
    end;    

    close(arch)


end;




