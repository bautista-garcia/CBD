// Ejercicio 2 (Corte de Control)
// Archivo binario: código de autor, nombre del autor, nombre disco, género y la cantidad vendida de ese CD.

program ejercicio2;
    const VALORALTO = 'ZZZ'

type
    str4 = string[4];
    str30 = string[30];
    registroMaestro = record
        cod: str4;
        autor: str30;
        disco: str30;
        genero: str30;
        ventas: integer;
    end;
    archivoMaestro = file of registroMaestro;

procedure leer(var archivo: archivoMaestro; var registro: registroMaestro);
var
begin
  if (not eof(archivo))then
    read (archivo,registro)
else
    registro.cod:= valoralto;
end;

var
    aMaestro: archivoMaestro;
    rMaestro
    reporte: text;
    i: integer;
    totalGenero, totalAutor, totalDiscografica: integer;

    // Variables de corte
    autor, genero: str30;

begin
    // Paso 1: Encadenar archivos logicos y fisicos
    assign(aMaestro, "archivomaestro");

    // Paso 2: Nos ubicamos en la primera posicion
    reset(aMaestro);

    // Paso 3: Procesamos el archivo
    totalDiscografica := 0;
    leer(aMaestro, rMaestro);

    while (rMaestro.autor <> VALORALTO) do begin 
        writeln("Autor: ", rMaestro.autor);
        totalAutor := 0;
        autor := rMaestro.autor;
        while (rMaestro.autor = autor) do begin
            writeln("Genero: ", rMaestro.genero);
            genero := rMaestro.genero;
            totalGenero := 0;
            while (rMaestro.autor = autor) and (rMaestro.genero = genero) do begin 
                writeln("Nombre del disco: ", rMaestro.disco, "Cantidad vendida: ", rMaestro.ventas);
                // Escribimos reporte de cada registro
                writeln(reporte, ventas, nomap);
                writeln(reporte, disco)
                
                totalGenero:=totalGenero + rMaestr.ventas;
                leer(aMaestro, rMaestro);
            end;
            writeln("Genero: ", genero, "Total Genero", totalGenero);
            totalAutor:= totalAutor + totalGenero;
        end;
        writeln("Total autor: ", totalAutor);
        totalDiscografica := totalDiscografica + totalAutor;
    end;
    writeln("Total discografica", totalDiscografica);

    // Paso 4: Cerramos archivos
    close(aMaestro);

end;



