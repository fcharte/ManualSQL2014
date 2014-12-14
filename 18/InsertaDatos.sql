-- La empresa tendrá dos almacenes 
insert into Almacen values (
  'Principal', TDireccion('Cl.','Las Cruces',25,'21242'), TProductos());
insert into Almacen values (
  'Pgno. Esperanza', TDireccion('Avda.','Granada',4,'18342'), TProductos());
  
-- Algunas descripciones de productos
insert into DescProducto values (
  1, 'Loretto', 'Xire', 'Vestido crep con sobrefalda');
insert into DescProducto values (
  2, 'Kira', 'Dropes', 'Pantalón micropana pinzas');
insert into DescProducto values (
  3, 'Kira', 'Tablas', 'Falda tableada antelina');
  
-- Insertamos un proveedor
insert into Proveedor values (
  'B-38299173', 'Mirto S.L.', TDireccion('Cl.','Rosas rojas', 7, '43234'),
  TTelefonos('916376274','672817382'), '3120-4032-17-4215333', TFacturas(),
  TListaProductos(), TCompras());
  
-- Que nos va a vender dos de los tipos de productos registrados antes
insert into the (select prv.Productos from Proveedor prv where CIF='B-38299173') 
  select ref(d) from DescProducto d
  where d.IdDesProducto <= 2;

-- Cómo crear un nuevo producto y asociarlo a un nuevo proveedor
declare
  RefP ref TDescProducto;
begin
  insert into DescProducto d values (
     4, 'Aixa', 'Plete', 'Camisa doble cuello')
     returning ref(d) into RefP;
     
  insert into Proveedor values (
    'B-73599774', 'Creaciones Miranda', TDireccion('Cl.','Rojas rosas', 7, '23432'),
    TTelefonos('53376274','95817382'), '0120-1037-12-0005312', TFacturas(),
    TListaProductos(RefP), TCompras());
end;
/
-- Compra de unos lotes de productos a un proveedor
declare
  RefAlb  ref TAlbaran;
  RefDes1  ref TDescProducto;
  RefDes2  ref TDescProducto;
begin
  -- Obtengo las referencia a la descripción del producto recibido
  select ref(d) into RefDes1 from DescProducto d where IdDesProducto = '1';
  select ref(d) into RefDes2 from DescProducto d where IdDesProducto = '2';
  
  -- Se registran los productos en el almacén donde se han recibido
  insert into the (select al.Productos from Almacen al where Nombre='Principal')
    values (TProducto('1', RefDes1, 5, 20.5));
  insert into the (select al.Productos from Almacen al where Nombre='Principal')
    values (TProducto('2', RefDes2, 7, 16.35));
  insert into the (select al.Productos from Almacen al where Nombre='Pgno. Esperanza')
    values (TProducto('1', RefDes1, 10, 20.5));

  -- Genero el albarán de entrada de los productos  
  insert into Albaran alb values (
   '121/07',
   TLineasAlbaran(
     TLineaAlbaran(RefDes1, 15, 20.5),
     TLineaAlbaran(RefDes2, 7, 16.35)
   ), 'Primera compra a este proveedor')
   returning ref(alb) into RefAlb;
  
  -- Para agregar la nueva transacción
  insert into the(select Compras from Proveedor where CIF='B-38299173') 
    values (TTransacion(sysdate, RefAlb));
end;
/
-- Generar la factura correspondiente a la transacción de una cierta
-- fecha tomando los datos del albarán correspondiente
declare
 LineasFact TLineasFactura;
 Total real := 0;
 RefFact ref TFactura;
begin
  -- Preparación de las líneas que compondrán la factura con los datos
  -- del albarán y calculando la columna del descuento
  select TLineaFactura(li.Producto.Descripcion,li.Cantidad,li.Precio,li.Precio*li.Cantidad*0.05)
  bulk collect into LineasFact
  from the(select p.Compras from Proveedor p where CIF='B-38299173') co,
  table(co.Albaran.Lineas) li
  where round(co.Fecha,'day') = round(sysdate,'day');

  -- Con las filas generadas por la consulta anterior se calcula el total
  select sum(li.Precio*li.Cantidad-li.Descuento) into Total
  from table(LineasFact) li;

  -- Creación de la factura
  insert into Factura f values(
    '19/07', sysdate, Total, Total*0.16, 0, LineasFact)
  returning ref(f) into RefFact;
  
  -- Se añade la referencia a la factura a la tabla Facturas del proveedor
  insert into the(select p.Facturas from Proveedor p where CIF='B-38299173') 
     values(RefFact);
end;
/

-- Inserción de dos pagos parciales asociados a la factura previa
insert into Pago
 select sysdate, ref(f), 45
 from Factura f where NumFactura = '19/07';
 
insert into Pago
 select sysdate+1, ref(f), 30
 from Factura f where NumFactura = '19/07';
