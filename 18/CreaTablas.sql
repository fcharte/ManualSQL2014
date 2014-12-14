--
-- BDD II - Trabajo voluntario sobre ORDBM con Oracle
-- Francisco Charte Ojeda - Diciembre 2007
--
-- Este módulo contiene todas las sentencias DDL para crear las tablas
--

------------------------- CREACIÓN DE TABLAS -------------------------------

-- Las descripciones de los productos tienen una tabla propia,
-- ya que un mismo producto podríamos obtenerlo de distintos
-- proveedores
create table DescProducto of TDescProducto (
  IdDesProducto primary key 
);

-- La tabla de proveedores permitirá localizar la empresa por
-- su CIF y lleva anidadas tres tablas: una de referencias a 
-- productos que nos ofrece, otra con las compras que le hemos
-- efectuado y la tercera con las referencias a las facturas
create table Proveedor of TProveedor (
  CIF		primary key
)
  nested table Productos store as TblProductos,
  nested table Compras store as TblCompras,
  nested table Facturas store as TblFacturasCompra;

-- La tabla de clientes permitirá localizar la empresa por 
-- su CIF y lleva anidada la tabla que contiene todas las
-- ventas que hemos efectuado con él y la tabla de facturas
create table Cliente of TCliente (
  CIF		primary key
)
  nested table Ventas store as TblVentas,
  nested table Facturas store as TblFacturasVenta;

-- Tabla para registrar los pagos
create table Pago of TPago;

-- La tabla de facturas tiene anidada la de las líneas que le corresponden
create table Factura of TFactura
  nested table Lineas store as TblLinFacturas;

-- La tabla de albaranes tiene anidada la de las líneas que le corresponden
create table Albaran of TAlbaran
  nested table Lineas store as TblLinAlbaran;

-- La tabla con los almacenes tiene asociada la tabla de lotes de productos
-- que contiene
create table Almacen of TAlmacen
  nested table Productos store as TblLotesProductos;
