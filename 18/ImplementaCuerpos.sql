--
-- BDD II - Trabajo voluntario sobre ORDBM con Oracle
-- Francisco Charte Ojeda - Diciembre 2007
--
-- Este m�dulo contiene la implementaci�n de los m�todos de los tipos
--

--------- DEFINICI�N M�TODOS -------------------------------

create or replace type body TDireccion is 
  -- La llamada a Str() devolver� una cadena con la direcci�n completa
  member function Str return varchar is
  begin
    return TipoVia || ' ' || NombreVia || ', ' || Numero;
  end;
end;
/
create or replace type body TEmpresa is
  -- Calcula el pago pendiente total a un proveedor o de un cliente
  member function PagoPendiente return real is
    Total real;
    Pagado real;
  begin
    -- Obtengo la suma del total de las facturas recibidas o emitidas
    select sum(value(f).TotalFactura()) into Total
    from Proveedor p, table(p.Facturas) f
    where p.CIF=self.CIF;

    -- y la suma de los pagos que se han hecho asociados a esas facturas
    select sum(pa.Importe) into Pagado
    from Proveedor p, table(p.Facturas) f, Pago pa
    where p.CIF=self.CIF and pa.Factura = value(f);
  
    return Total-Pagado; -- Para devolver la diferencia
  end;
end;
/
create or replace
type body TDescProducto is
  -- Las funciones de este tipo toman como argumento una referencia al
  -- producto sobre el que se quiere operar. Esto es necesario por la
  -- limitaci�n que tiene Oracle en el tratamiento del par�metro SELF,
  -- cuya referencia no puede obtenerse mediante el operador REF y que
  -- es necesaria para la implementaci�n correcta de estas funciones.
  -- M�s informaci�n en el cap�tulo 18 de Oracle PL/SQL Programming, en
  -- el apartado 18.5.3: http://www.unix.org.ua/orelly/oracle/prog2/ch18_05.htm

  -- Obtiene las existencias de un tipo de producto
  member function Existencias(Pr ref TDescProducto) return integer is
    n integer;
  begin
    -- Sumo las cantidades disponibles en todos los almacenes del producto
    -- cuya referencia se entrega como argumento
    select sum(p.Cantidad) into n
    from Almacen al, table(al.Productos) p
    where p.DesProducto = Pr;
    
    return n;
  end;
  
  -- Facilita los proveedores a los que se puede pedir el producto
  member function Proveedores(Pr ref TDescProducto) return TListaProveedores is
    Prov TListaProveedores;
  begin
    -- Elegir valores �nicos de la raz�n social para aquellos proveedores
    -- que tengan en su lista de productos el facilitado como par�metro
    select unique p.RazonSocial bulk collect into Prov
    from Proveedor p, table(p.Productos) t
    where Pr in (select value(t) from table(p.Productos));
    
    return Prov;
  end;
end;
/
create or replace type body TAlmacen is
  -- Facilita el inventario del almac�n
  member function Inventaria return integer is
    n integer;
  begin
    select sum(p.Cantidad) into n
    from Almacen al, table(al.Productos) p
    where al.Nombre=self.Nombre;
    
    return n;
  end;
  -- Calcula el valor de los productos del almacen
  member function Valora return real is
    n real;
  begin
    select sum(p.cantidad*p.precioadq) into n
    from Almacen al, table(al.Productos) p
    where al.Nombre=self.Nombre;
  
    return n;
  end;
end;
/
create or replace type body TAlbaran is
  -- Calcula el total del albar�n, que no incluye IVA ni descuentos
  member function TotalAlbaran return real is
    n real;
  begin
    select sum(li.Cantidad*li.Precio) into n
    from Albaran al, table(al.Lineas) li
    where al.NumAlbaran = self.NumAlbaran;
    
    return n;
  end;
end;
/
create type body TFactura is
  -- Calcula el total de la factura
  member function TotalFactura return real is
  begin
    return self.Importe + self.IVA;
  end;
end;
/