-- Obtener una lista de almacenes incluyendo sus direcciones
select a.Nombre, a.Direccion.Str() "Dirección" from Almacen a;

-- Obtener las descripciones de los productos que nos facilita un proveedor
select value(prod).Descripcion "Producto"
from the (select prv.Productos from Proveedor prv where CIF='B-38299173') prod;

-- Ver la lista de compras hechas a un proveedor
select co.Fecha, co.Albaran.Lineas, co.Albaran.Comentarios
from the(select p.Compras from Proveedor p where CIF='B-38299173') co;

-- Ver todas las líneas de albarán de las compras hechas a un proveedor
select co.Fecha, deref(li.Producto).Descripcion "Producto", li.Cantidad, li.Precio, co.Albaran.Comentarios
from the(select p.Compras from Proveedor p where CIF='B-38299173') co,
table(co.Albaran.Lineas) li;

-- Ver todos los datos de un proveedor, incluyendo conlumnas que son tablas
select *
from Proveedor p, table(p.Compras)
where CIF='B-38299173';

-- Ver los lotes de producto existentes en los almacenes
select al.Nombre, deref(p.DesProducto).Descripcion, p.Cantidad, p.PrecioAdq
from Almacen al, table(al.Productos) p;

-- Cómo recorrer las líneas de un albarán desde un bloque PL/SQL
-- (lo mismo sería válido para recorrer otras tablas anidadas)
declare
 RefLi TLineasAlbaran;
 Prod TDescProducto;
begin
  -- Se recuperan en memoria las líneas del albarán
  select value(li) bulk collect into RefLi
  from the(select p.Compras from Proveedor p where CIF='B-38299173') co,
  table(co.Albaran.Lineas) li;

  -- Se utiliza un bucle para recorrer las líneas
  for i in RefLi.first .. RefLi.last loop
    -- En PL/SQL no puede usarse directamente una referencia para acceder a
    -- sus miembros (en SQL sí), por lo que es necesario usar esta sentencia
    select deref(RefLi(i).Producto) into Prod from dual;
    -- Ahora ya se tiene la descripción del producto y el resto de datos asociados
    dbms_output.put_line(Prod.Descripcion || ', ' || RefLi(i).Cantidad);
  end loop;
end;
/
-- Obtención de los datos de una factura concreta
select * from Factura where NumFactura='19/07';
-- Muestras las líneas de la factura anterior
select li.* from the(select f.Lineas from Factura f where f.NumFactura='19/07') li;

-- Recuperar el número de factura, importe y líneas de las facturas de
-- un cierto proveedor
select value(f).NumFactura,value(f).Importe,l.*
from Proveedor p, table(p.Facturas) f, table(value(f).Lineas) l
where CIF='B-38299173';

-- Obtener lo que queda pendiente de pago a un proveedor
select p.PagoPendiente()
from Proveedor p
where CIF='B-38299173';

-- Obtener las existencias de un cierto producto
select p.Existencias(ref(p))
from DescProducto p
where p.IdDesProducto = '1';

-- Obtener la lista de proveedores que nos facilita un cierto producto
select value(t) "Proveedores"
from DescProducto p, table(p.Proveedores(ref(p))) t
where p.IdDesProducto = '2';

-- Inventario de los distintos almacenes, obteniendo su nombre,
-- el número de artículos que debe haber y su valor
select al.Nombre, al.Inventaria(), al.Valora()
from Almacen al;

-- Obtener albaranes y sus totales
select al.NumAlbaran, al.TotalAlbaran()
from Albaran al;
