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
        dato.cod = VALORALTO;
end;


// MAIN
var 
    cod: integer;
    pos: integer;
    rEspecies, aux : registroEspecies;
    arch, archNuevo: archivoEspecies; 
begin
    // Espacio logico <=> Espacio Fisico
    assign(arch, "archivoViejo.dat");
    assign(archNuevo, "archivoNuevo.dat");

    // Me posiciono en filePos = 1
    reset(arch);
    rewrite(archNuevo);
    readln(cod);

    while (cod <> CORTE) do begin
        // Leo en archivo hasta encontrar el buscado
        leer(arch, rEspecies);
        while (rEspecies.cod <> cod) and (rEspecies.cod <> VALORALTO) do begin 
            leer(arch, rEspecies);
        end;
        // Caso en que encuentro registro a marcar y no se termino el archivo
        if(rEspecies.cod <> VALORALTO) then begin 
            pos = filePos(arch) - 1;
            rEspecies.nomV = MARCA;
            seek(arch, pos); 
            write(arch, rEspecies);
        end;
        // Me posiciono en 0 para la proxima marca
        seek(arch, 0);
        readln(cod);
    end;

    // Copio en archivo nuevo registros con nomV != MARCA
    leer(arch, rEspecies);
    while(rEspecies.cod <> VALORALTO) do begin
        if(rEspecies.nomV != MARCA) then write(archNuevo, rEspecies);
        leer(arch, rEspecies);
    end;

    // Cierro archivos
    close(arch);
    close(archNuevo);


end;




