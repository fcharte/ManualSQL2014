--
-- BDD II - Trabajo voluntario sobre ORDBM con Oracle
-- Francisco Charte Ojeda - Diciembre 2007
--
-- Este módulo contiene todas las sentencias DDL para definir los tipos 
--

--------- DEFINICIÓN DE TIPOS DE OBJETO -------------------------------

-- La dirección es un objeto que va asociado a las empresas (clientes y proveedores)
-- y también a los almacenes con que pueda contar la empresa que utiliza la aplicación
create or replace type TDireccion as object (
  TipoVia	varchar(5),
  NombreVia	varchar(40),
  Numero	integer,
  CodPostal	varchar(5),

  -- Facilita una cadena con la dirección completa
  member function Str return varchar
);
/
-- Una empresa puede tener varios números de teléfono (fijos, móviles), por lo que
-- defino un tipo TTelefonos que permita contener hasta 5 teléfonos
create type TTelefonos as varray(5) of varchar(10);
/
-- Declaración avanzada del tipo TFactura que se definirá más adelante
create type TFactura;
/
-- Tipo para mantener una lista de referencias a facturas
create or replace type TFacturas as table of ref TFactura;
/
-- Existe un tipo genérico para todas las empresas, ya sean clientes o proveedores
create or replace type TEmpresa as object (
  CIF		varchar(10),
  RazonSocial	varchar(60),
  Direccion 	TDireccion,     -- La dirección es un objeto
  Telefonos	TTelefonos,     -- Lista con los teléfonos de la empresa
  IBANCuenta	varchar(20),
  Facturas      TFacturas,      -- Facturas emitidas/enviadas a la empresa
  
  -- Calcula el pago pendiente total a un proveedor o de un cliente
  member function PagoPendiente return real
) not final; -- Este tipo servirá como base para otros
/
-- Tipo para el valor de retorno del método Proveedores
create or replace type TListaProveedores as table of varchar(60);
/
-- Existe una descripción genérica por producto
create or replace type TDescProducto as object (
  IdDesProducto	varchar(10),
  Marca		varchar(20),
  Modelo	varchar(20),
  Descripcion	varchar(60),
  
  -- Obtiene las existencias de un tipo de producto
  member function Existencias(Pr ref TDescProducto) return integer,
  -- Facilita los proveedores a los que se puede pedir el producto
  member function Proveedores(Pr ref TDescProducto) return TListaProveedores
);
/
-- De cada tipo de producto pueden existir varios lotes, adquiridos a un cierto precio
-- y con una cantidad concreta
create or replace type TProducto as object (
  IdProducto	varchar(10),
  DesProducto   ref TDescProducto,
  Cantidad	integer,
  PrecioAdq	real
);
/  
-- Los lotes de productos formarán tablas anidadas
create or replace type TProductos as table of TProducto;
/
-- Que se almacenarán en cada uno de los almacenes existentes
create or replace type TAlmacen as object (
  Nombre	varchar(20),
  Direccion   	TDireccion,
  Productos	TProductos,	-- Los productos son una tabla anidada
  
  -- Facilita el inventario del almacén
  member function Inventaria return integer,
  -- Calcula el valor de los productos del almacen
  member function Valora return real
);
/
-- Las líneas de albarán de entrega
create or replace type TLineaAlbaran as object (
  Producto	ref TDescProducto,  	-- indica el producto, que procederá de un lote de producto y, por tanto, de un almacen 
  Cantidad	integer,		-- la cantidad y el precio
  Precio	real
);
/
-- Cada albarán se compondrá de una serie de líneas
create or replace type TLineasAlbaran as table of TLineaAlbaran;
/
create or replace type TAlbaran as object (
  NumAlbaran    varchar(10),
  Lineas	TLineasAlbaran,
  Comentarios   varchar(200),
  
  -- Calcula el total del albarán, que no incluye IVA ni descuentos
  member function TotalAlbaran return real
);
/
-- Una línea de factura va asociada a una línea de albarán, de la que toma
-- el producto, cantidad y precio. Un albarán puede dar lugar a varias facturas 
-- y, a la inversa, en una misma factura se pueden recoger varios albaranes
create or replace type TLineaFactura as object (
  Descripcion	varchar(60),  	        -- descripción del producto
  Cantidad	integer,		-- la cantidad y el precio
  Precio	real,
  Descuento     real                    -- y el descuento a aplicar
);
/
-- Tipo que reúne las líneas de factura de cada factura
create or replace type TLineasFactura as table of TLineaFactura;
/
-- La factura tiene los datos generales y las líneas asociadas
create or replace type TFactura as object (
  NumFactura	varchar(10),
  Fecha		date,
  Importe	real,
  IVA		real,		-- El tipo aplicable a cada empresa puede cambiar, por eso se almacena el importe
  Pagado	real,
  Lineas	TLineasFactura,
  
  -- Calcula el total de la factura
  member function TotalFactura return real
);
/
-- Este tipo representa cualquier tipo de transacción (compra o venta)
create or replace type TTransacion as object (
  Fecha		date,
  Albaran	ref TAlbaran  	-- Las transacciones generan un albarán
);
/
-- Las compras o ventas son conjuntos de transacciones
create or replace type TCompras as table of TTransacion;
/
create or replace type TVentas as table of TTransacion;
/
-- Cada proveedor tendrá asociada una tabla de productos que nos ofrece
create or replace type TListaProductos as table of ref TDescProducto;
/
-- El tipo proveedor está derivado de TEmpresa
create or replace type TProveedor under TEmpresa (
  Productos     TListaProductos,	-- Una tabla con los productos
  Compras	TCompras		-- Así como una tabla con las transacciones de compra
);
/
-- El tipo cliente está derivad de TEmpresa
create or replace type TCliente under TEmpresa (
  Ventas	TVentas		-- Una tabla con las transacciones de venta
);
/
-- Este tipo identifica los pagos a proveedores o los pagos procedentes de clientes
create or replace type TPago as object (
  Fecha		date,			-- Fecha en que se efectúa el pago
  Factura	ref TFactura,		-- Referencia a la factura asociada
  Importe	real			-- Importe pagado
);
/

