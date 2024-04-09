program ejercicio2;

type
    str30 = string[30];
    tVehiculo = record
        codigoVehiculo: integer;
        patente: str30; 
        #motor: str30;
        cantidadPuertas: integer;
        precio: real;
        descripcion: str30;
    end;
    tArchivo = file of tVehiculo;

procedure leer(var archivo: archivoEspecies; var dato: registroEspecies);
begin
    if(not eof(archivo)) then 
        read(archivo, dato)
    else
        dato.cod = VALORALTO;
end;

procedure agregar(var arch: tArchivo; vehiculo: tVehiculo);
var
    v, rLibre: tVehiculo;
    cod, posLibre: integer;
begin
    // Se lee la cabecera
    reset(arch);
    read(arch, v);
    Val(v.descripcion, posLibre, cod);
    if(posLibre = -1) then seek(arch, filesize(arch))
    else begin
        // Leo rLibre para poder actualizar cabecera luego
        seek(arch, posLibre);
        read(arch, rLibre);
        // Actualizo cabecera
        seek(arch, 0);
        write(arch, sLibre)
        seek(arch, posLibre);
    end;
    // Escribo en rLibre o en donde estaba marca de EOF
    write(arch, vehiculo);
    close(arch); 
end;

procedure eliminar(var arch: tArchivo; codigoVehiculo: integer);
var
    v, vLibre: tVehiculo;
    posLibre: integer;
begin
    // Leo cabecera
    reset(arch);
    read(arch, vLibre);

    // Busco vehiculo a eliminar
    leer(arch, v);
    while (v.codigoVehiculo <> VALORALTO) and (v.codigoVehiculo <> codigoVehiculo) do begin
        if(v.codigoVehiculo = codigoVehiculo) then begin
            // Copiamos previa cabezera a lugar a eliminar
            posLibre := filepos(arch) - 1;
            seek(arch, posLibre);
            write(arch, vLibre);

            // Copiamos registro borrado a cabezera
            Str(posLibre, v.descripcion);
            seek(arch, 0);
            write(arch, v);
        end;
    end;

    close(arch);
end;

