--
-- BDD II - Trabajo voluntario sobre ORDBM con Oracle
-- Francisco Charte Ojeda - Diciembre 2007
--
-- Este m�dulo contiene todas las sentencias DDL para definir los tipos 
--

--------- DEFINICI�N DE TIPOS DE OBJETO -------------------------------

-- La direcci�n es un objeto que va asociado a las empresas (clientes y proveedores)
-- y tambi�n a los almacenes con que pueda contar la empresa que utiliza la aplicaci�n
create or replace type TDireccion as object (
  TipoVia	varchar(5),
  NombreVia	varchar(40),
  Numero	integer,
  CodPostal	varchar(5),

  -- Facilita una cadena con la direcci�n completa
  member function Str return varchar
);
/
-- Una empresa puede tener varios n�meros de tel�fono (fijos, m�viles), por lo que
-- defino un tipo TTelefonos que permita contener hasta 5 tel�fonos
create type TTelefonos as varray(5) of varchar(10);
/
-- Declaraci�n avanzada del tipo TFactura que se definir� m�s adelante
create type TFactura;
/
-- Tipo para mantener una lista de referencias a facturas
create or replace type TFacturas as table of ref TFactura;
/
-- Existe un tipo gen�rico para todas las empresas, ya sean clientes o proveedores
create or replace type TEmpresa as object (
  CIF		varchar(10),
  RazonSocial	varchar(60),
  Direccion 	TDireccion,     -- La direcci�n es un objeto
  Telefonos	TTelefonos,     -- Lista con los tel�fonos de la empresa
  IBANCuenta	varchar(20),
  Facturas      TFacturas,      -- Facturas emitidas/enviadas a la empresa
  
  -- Calcula el pago pendiente total a un proveedor o de un cliente
  member function PagoPendiente return real
) not final; -- Este tipo servir� como base para otros
/
-- Tipo para el valor de retorno del m�todo Proveedores
create or replace type TListaProveedores as table of varchar(60);
/
-- Existe una descripci�n gen�rica por producto
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
-- Los lotes de productos formar�n tablas anidadas
create or replace type TProductos as table of TProducto;
/
-- Que se almacenar�n en cada uno de los almacenes existentes
create or replace type TAlmacen as object (
  Nombre	varchar(20),
  Direccion   	TDireccion,
  Productos	TProductos,	-- Los productos son una tabla anidada
  
  -- Facilita el inventario del almac�n
  member function Inventaria return integer,
  -- Calcula el valor de los productos del almacen
  member function Valora return real
);
/
-- Las l�neas de albar�n de entrega
create or replace type TLineaAlbaran as object (
  Producto	ref TDescProducto,  	-- indica el producto, que proceder� de un lote de producto y, por tanto, de un almacen 
  Cantidad	integer,		-- la cantidad y el precio
  Precio	real
);
/
-- Cada albar�n se compondr� de una serie de l�neas
create or replace type TLineasAlbaran as table of TLineaAlbaran;
/
create or replace type TAlbaran as object (
  NumAlbaran    varchar(10),
  Lineas	TLineasAlbaran,
  Comentarios   varchar(200),
  
  -- Calcula el total del albar�n, que no incluye IVA ni descuentos
  member function TotalAlbaran return real
);
/
-- Una l�nea de factura va asociada a una l�nea de albar�n, de la que toma
-- el producto, cantidad y precio. Un albar�n puede dar lugar a varias facturas 
-- y, a la inversa, en una misma factura se pueden recoger varios albaranes
create or replace type TLineaFactura as object (
  Descripcion	varchar(60),  	        -- descripci�n del producto
  Cantidad	integer,		-- la cantidad y el precio
  Precio	real,
  Descuento     real                    -- y el descuento a aplicar
);
/
-- Tipo que re�ne las l�neas de factura de cada factura
create or replace type TLineasFactura as table of TLineaFactura;
/
-- La factura tiene los datos generales y las l�neas asociadas
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
-- Este tipo representa cualquier tipo de transacci�n (compra o venta)
create or replace type TTransacion as object (
  Fecha		date,
  Albaran	ref TAlbaran  	-- Las transacciones generan un albar�n
);
/
-- Las compras o ventas son conjuntos de transacciones
create or replace type TCompras as table of TTransacion;
/
create or replace type TVentas as table of TTransacion;
/
-- Cada proveedor tendr� asociada una tabla de productos que nos ofrece
create or replace type TListaProductos as table of ref TDescProducto;
/
-- El tipo proveedor est� derivado de TEmpresa
create or replace type TProveedor under TEmpresa (
  Productos     TListaProductos,	-- Una tabla con los productos
  Compras	TCompras		-- As� como una tabla con las transacciones de compra
);
/
-- El tipo cliente est� derivad de TEmpresa
create or replace type TCliente under TEmpresa (
  Ventas	TVentas		-- Una tabla con las transacciones de venta
);
/
-- Este tipo identifica los pagos a proveedores o los pagos procedentes de clientes
create or replace type TPago as object (
  Fecha		date,			-- Fecha en que se efect�a el pago
  Factura	ref TFactura,		-- Referencia a la factura asociada
  Importe	real			-- Importe pagado
);
/

