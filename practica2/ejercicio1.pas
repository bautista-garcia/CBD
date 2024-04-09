// Ejercicio 1: Se tienen 10 archivos detalles que contienen 
// código de empleado, la fecha y la cantidad de días de licencia solicitadas.
// El archivo maestro tiene información de cada empleado: código de empleado, nombre y apellido,
//  fecha de nacimiento, dirección, cantidad de hijos, teléfono, cantidad de días que le 
// corresponden de vacaciones en ese periodo. Tanto el maestro como los detalles están ordenados por código de empleado
// Se debe actualizar la cantidad de días que le restan de vacaciones
// Si el empleado tiene menos días de los que solicita deberá informarse en un archivo de texto indicando:
//  código de empleado, nombre y apellido, cantidad de días que tiene y cantidad de días que solicita

program Ejercicio1;

const valoralto=’9999’;
const CANTDETALLES=10
type 
  str4 = string[4];
  str30 = string[30];

Empleado = record 
    cod: str4;
    nomap: str30;
    nacimiento: str30;
    dirección: str30;
    hijos: str30;
    telefono: integer;
    vac: integer;
end;

EmpleadoDetalle = record
    cod: str4;
    fecha: str30;
    lic: integer;
end;

detalle = file of EmpleadoDetalle;
maestro = file of Empleado;
arrDetalle = array[1..3] of arc_productos;
arrRegDetalle = array[1..3] of EmpleadoDetalle;

var 
    mae: maestro;
    det: arrDetalle;
    regm: Empleado;
    regd, min: EmpleadoDetalle;
    arrRegd: arrRegDetalle
    i: integer;
    nomDet: str30;
    reporte: text;

// Lectura con control de fin de archivo sin perder el ultimo dato.
procedure leer (var archivo:detalle; var dato: EmpleadoDetalle);
begin
  if (not eof(archivo))then
    read (archivo,dato)
else
    dato.cod:= valoralto;
end;

// Busca el minimo entre todos los detalles y avanza una posicion para que en el proximo minimo() se compare con el proximo de ese detalle
procedure minimo (var det: detalles; var regDet: arrRegd; var min: regd);
var 
    posMin, i: integer;
begin
    posMin := 1;
    min := regDet[1];
    for i:=1 to CANTDETALLES do begin
        if(regDet[i].codigo < min.codigo) then begin
            min := regDet[i];
            posMin := i;
        end;
    end;
    leer(det[posMin], regDet[posMin]); 
end;



begin 
    // Paso 1: Asignamos archivos logicos a archivos fisicos.
    assign(reporte, "reporte.txt");
    assign(mae, "maestro");
    for i:=1 to CANTDETALLES do begin
        nomDet := "detalle" + i;
        assing(det[i], nomDet);
    end;

    // Paso 2: Nos posicionamos en el primer registro de cada archivo
    reset(reporte);
    reset(mae);
    for i:=1 to CANTDETALLES do begin
        reset(det[i]);
    end;

    // Paso 3: Leemos el maestro, todos los detalles y buscar el que tenga minimo codigo de empleado
    read(mae, regm)
    for i:=1 to CANTDETALLES do begin
        leer(det[i], arrRegd[i]);
    end;
    minimo(det, arrRegd, min); //Se almacena registro de minimo codigo de empleado en min.

    // Paso 4: Procesamos todos los registros detalles
    while (min.cod <> valoralto) do begin  
        // Buscamos en el maestro el registro correspondiente al detalle
        while (regm.cod <> min.cod) do begin
            read(mae, regm);
        end;

        // Reporte o actualizacion de vacaciones
        if(min.lic > regm.vac) then begin
            writeln(reporte, regm.vac, regm.lic, regm.cod);
            writeln(reporte, regm.nomap)
        end
        else regm.vac := regm.vac - min.lic;
        seek(mae, filepos(mae) - 1);
        write(mae, regm);

        // Avanzo buscando el nuevo minimo
        minimo(det, arrRegd, min); 
        if (not(EOF(mae))) then
            read(mae, regm);    
    end;

    // Paso 5: Cierro todos los archivos
    close(reporte);
    close(mae);
    for i:= 1 to CANTDETALLES do begin
        close(det[i]);
    end;

end;




        






