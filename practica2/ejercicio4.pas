// EJEMPLO DE MERGE
program ejercicio4;
const CANTDETALLES = 20;
type
    str30 = string[30];
    str4 = string[4];
    registro = record
        cod: str4;
        nom: str30;
        genero: str30;
        director: str30;
        duracion: integer;
        fecha: str30;
        asistentes: integer;
    end;

    maestro = file of registro;
    detalle = file of registro;
    arrDetalle = array [1..CANTDETALLES] of detalle;

// Lectura con control de fin de archivo sin perder el ultimo dato.
procedure leer (var archivo:maestro; var dato: registro);
begin
  if (not eof(archivo))then
    read (archivo,dato)
else
    dato.cod:= valoralto;
end;

// Busca el minimo entre todos los detalles y avanza una posicion para que en el proximo minimo() se compare con el proximo de ese detalle
procedure minimo (registroMinimo: registro; arregloDetalles: arrDetalle, arregloRegistroDetalles);
var 
    posMin, i: integer;
begin
    posMin := 1;
    registroMinimo := arregloDetalles[1];
    for i:=2 to CANTDETALLES do begin
        if(arregloDetalles[i].codigo < registroMinimo.codigo) then begin
            registroMinimo := arregloDetalles[i];
            posMin := i;
        end;
    end;
    leer(arregloDetalles[posMin], arregloRegistroDetalles[posMin]); 
end;

