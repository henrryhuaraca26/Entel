<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.nextel.utilities.Constant"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Nextel</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/calendario.js"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery.min.js"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery-ui.min.js"></script>
<STYLE type="text/css">
    a.inactivo:link     {text-decoration: none; background-color:#FFFFFF;color:#A0A0A0}
    a.inactivo:visited  {text-decoration: none; background-color:#FFFFFF;color:#A0A0A0}
    a.inactivo:active   {text-decoration: none; background-color:#FFFFFF;color:#A0A0A0}
    a.inactivo:hover    {text-decoration: none; background-color:#FFFFFF;color:#A0A0A0}
</STYLE>
</head>
<body>
<script language="javascript" type="text/javascript">
<%  String mensajeListado = "";
    if (request.getAttribute("mensajeListado") != null)
     mensajeListado = (String) request.getAttribute("mensajeListado");
%>
function BuscarOrden()
{
    document.forms[0].btnBuscar.disabled=true;
   var valido = ValidaDatos(document.forms[0],1);
   if(valido)
   {
       if(validarCombo())
      {
        document.forms[0].metodo.value= 'orderSearch';
        document.forms[0].submit();
        return false;
      } 
      else
      {
      document.forms[0].btnBuscar.disabled=false;
      return false;
   }
   }
   
  else{ 
   document.forms[0].btnBuscar.disabled=false;
   return false;
}
}

function validarCombo()
{
   if(document.forms[0].cmbDocumentType.value=='0')
   {
      alert('Debe seleccionar un tipo de documento');
      document.forms[0].cmbDocumentType.focus();
      return false;
   }
   return true;
}
function Validar()
{	
        if(document.forms[0].txtIMEI.value!="")
	{
                if(document.forms[0].txtVoucher.value=="")
		{
			alert("Debe Especificar un número de Voucher");
                        document.forms[0].txtVoucher.focus();
                        return false;
		}
	}
        return true;
}

function CambiarEquipo()
{
   if(validaChecks())
   {
    document.forms[0].metodo.value= 'productChangeSelect';
    document.forms[0].submit();
   } 
}

function CambiarModelo()
{
  if(validaChecks())
   {
     document.forms[0].metodo.value= 'modelChangeSelect';
     document.forms[0].submit();
   }
}

function DevolucionTotal()
{
   if(validaChecks())
   { document.forms[0].metodo.value= 'devolutionTotalSelect';
     document.forms[0].submit();
   }  
}
function validaChecks()
{
   opciones = document.getElementsByName("radiobutton");
   for(i=0;i<opciones.length;i++)
   {
      if(opciones[i].checked)
        return true;
   }
   
   alert('Debe seleccionar una Orden');
   return false;
}

//Paul Rivera 25/07/2014
//Rutina que permite desaparecer el link Devolución
$(document).ready(function() {
    $('input[type="radio"]').click(function(){
                //Obtenemos el value del foco del radio
                var orden = this.value.split(",");
                if(orden[2]=="<%=Constant.PORTABILIDAD_NESPECIFICACION%>"){
                    document.getElementById("mostrar").className = "inactivo";
                    document.getElementById("mostrar").href = "#";
                }
                if(orden[2]=="<%=Constant.MOVILES_NMOVIL%>"){
                    document.getElementById("mostrar").className = "";
                    document.getElementById("mostrar").href = "javascript:DevolucionTotal();";
                }
    });
});
</script>

<html:form action="/ProductDevolutionAction.do" method="post" onsubmit="javascript:return BuscarOrden();">
<html:hidden property="metodo" />
<table width="100%"  border="0">
<tr>
    <td height="60" colspan="2">
    <jsp:include page="/header.jsp"/>
    </td>
  </tr>  <tr>
    <td width="13%" valign="top"><table width="100%" border="1" class="RegionHeaderColor">
<tr>
<td>
<table width="100%" border="0">
  <tr>
    <td height="22" colspan="2" class="PortletHeaderColor"><div class="PortletHeaderText">&nbsp;&nbsp;Men&uacute;</div></td>
  </tr>  
  <tr>
    <td width="15">&nbsp;</td>
    <td width="185">
    <!-- <script type="text/javascript" src="js/menuPublico.js"></script>-->
    <jsp:include page="/menu.jsp"/>
    </td>
  </tr>
</table>
</td>
</tr>
</table></td>
    <td width="87%">
    <table width="100%" border="1" class="RegionHeaderColor">
    <tr>
    <td>
  <table width="100%"  border="0">
     <tr class="ListRow1">
      <td colspan="4" class="PortletHeaderColor"><div class="PortletHeaderText">Consulta Datos de Venta</div></td>
    </tr>
	<tr class="ListRow1">
      <td colspan="4" class="PortletText1">Criterios de B&uacute;squeda</td>
    </tr>
    <tr class="ListRow1">
      <td width="16%" class="LeftSubTab"><strong>Tipo Documento</strong></td>
      <td width="15%">
          <div align="left">
      <bean:define id="documento" name="ProductDevolutionForm" property="lstDocumentType"/>
      <html:select property="cmbDocumentType">
      <option value="0" >--Seleccionar--</option>
      <html:optionsCollection name="documento" value="npparameterid" label="npparametername" />
      </html:select>
        </div></td>
      <td width="11%" class="LeftSubTab"><strong>N&uacute;mero Documento </strong></td>
        <td width="20%">
          <div align="left">
            <html:text property="txtTypeDocumentNumber" size="20" maxlength="60" onkeypress="return solo_numeros(event)" title="*"/>
        </div></td></tr>
    <!--<tr class="ListRow1">
      <td class="LeftSubTab"><strong>N&uacute;mero Voucher </strong></td>
      <td class="ListRow1">
          <div align="left">
            <html:text property="txtVoucher" size="20" maxlength="100" />
        </div></td><td colspan="2" class="ListRow1">
          <div align="left">        </div></td>
        </tr> -->
    <tr class="ListRow1">
      <td colspan="4" class="ListRow1"><div align="center">
        <input type="button" name="btnBuscar" value="Buscar" onClick="javascript:BuscarOrden()">
      </div>        </td>
      </tr>
    <tr class="ListRow1">
      <td colspan="4">&nbsp;</td>
    </tr>
  </table>  
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="17%"><div align="center"><a href="javascript:CambiarEquipo()">Cambiar Equipo</a></div></td>
      <td width="15%"><div align="center"><a href="javascript:CambiarModelo()">Cambiar Modelo</a> </div></td>
      <td width="18%">
      <!--Paul Rivera 14/07/2014-->
      <!--Inicio de mostrar el link de devolución-->            
            <a id="mostrar" name="mostrar" href="javascript:DevolucionTotal();">Devoluci&oacute;n Total</a>
      <!--Fin de mostrar el link de devolución-->
      </td>      
      <td width="50%">
    </td>    
    </tr>
  </table>
  <div id="capa" style="width:100%; height:300px; z-index:1 ;overflow:auto" class="ListRow1" >
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="2%" class="LeftSubTab"><div align="center"></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Tipo de Orden</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Orden de Venta</strong></div></td>
      <td width="15%" class="LeftSubTab"><div align="center"><strong>Promoci&oacute;n</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>      
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Precio(S/.)</strong></div></td>
      
      <td width="5%" class="LeftSubTab"  ><div align="center" ><strong>SKU Pago Anticipado</strong></div></td>      
      <td width="5%" class="LeftSubTab"  ><div align="center" ><strong>Pago Anticipado (S/.)</strong></div></td>
      
      <td width="15%" class="LeftSubTab"><div align="center"><strong>Plan</strong></div></td>
      <td width="8%" class="LeftSubTab"><div align="center"><strong>Soluci&oacute;n</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Modelo</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Fecha Venta </strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Nro. Voucher </strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Cadena</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Sucursal</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>POS</strong></div></td>    </tr>    
     <%
        String ordenAnterior = "ninguna";
        String codproductoAnterior = "ninguna";
     %>
     <!-- SI SE ENCUENTRAN REGISTROS -->
     <logic:notEmpty name="listaProductos">
     <logic:iterate id="producto" name="listaProductos">
     
         <bean:define id="productoactual" name="producto" property="AN_NPORDERID" />
         <bean:define id="codproductoactual" name="producto" property="AV_PRODUCTID" />
         <bean:define id="aux" name="producto" property="ESPECIFICACION" />   
         <tr class="ListRow1">
         <td>
         <div align="center">
         <%
            if(!ordenAnterior.equals(productoactual+"")){
        %> 
        
        <input id="radiobutton" name="radiobutton" type="radio" value=<bean:write name="producto" property="AN_NPORDERID"/>,<bean:write name="producto" property="AV_NPORDERNUMBER"/>,<bean:write name="producto" property="ESPECIFICACION"/> onclick="mensaje(this);">
        
        <%
            }
        %>
      </div></td>
      <td class="ListRow1"><div align="center">             
         <%
            if(!ordenAnterior.equals(productoactual+"")){
        %>
         <bean:write name="producto" property="ESPECIFICACION" />
        <%
            }             
        %>  
      </td>
      <td class="ListRow1"><div align="center">
         <%
            if(!ordenAnterior.equals(productoactual+"")){
        %>
         <bean:write name="producto" property="AV_NPORDERNUMBER" />
        <%
            }             
        %> 
         </div></td>
       <% if(!codproductoactual.equals(codproductoAnterior) || !ordenAnterior.equals(productoactual+"")){%>  
      <td class="ListRow1"><div align="center"><bean:write name="producto" property="AV_NPPRODUCTNAME" /></div></td>
      <!--td class="ListRow1"><div align="center"><bean:write name="producto" property="AN_NPSOLUTIONCODE" /></div></td-->
      <td class="ListRow1"><div align="center"><bean:write name="producto" property="AV_NPSKU" /></div></td>      
      <td><div align="center"><bean:write name="producto" property="AN_NPCOSTOPRODUCT" /></div></td> 
          
      <%}else{%>
      <td class="ListRow1"><div align="center">&nbsp;</div></td>
      <!--td class="ListRow1"><div align="center"><bean:write name="producto" property="AN_NPSOLUTIONCODE" /></div></td-->
      <td class="ListRow1"><div align="center">&nbsp;</div></td>    
      <td><div align="center">&nbsp;</div></td>
      <%}codproductoAnterior = (String)codproductoactual;
      ordenAnterior=""+(Integer)productoactual;%>
      <td><div align="center"><bean:write name="producto" property="AV_NPSKUPA" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_NPMONTOAPROXIMADO" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_NPPLANNAME" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_NPSOLUTIONNAME" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_NPCHILDPRODUCTNAME" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AD_NPORDERDATE" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_NPVOUCHER" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_RETAILERNAME" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_STORENAME" /></div></td>
      <td><div align="center"><bean:write name="producto" property="AV_POSNAME" /></div></td>
    </tr>   
    </logic:iterate>   
  </logic:notEmpty>
    <tr class="ListRow1">
      <td><div align="center"></div></td>
      <td class="ListRow1"><div align="center"></div></td>
      <td class="ListRow1"><div align="center"></div></td>
      <td class="ListRow1"><div align="center"></div></td>
      <td class="ListRow1"><div align="center"></div></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><div align="center"></div></td>
      <td><div align="center"></div></td>
    </tr>
  </table>
  </div>
   <p>&nbsp;</p>
</td>
    </tr>
    </table>
</td>
  </tr>
</table>
</html:form>
</body>
</html>
     <!-- SI NO SE ENCUENTRAN REGISTROS MANDAMOS LOS MENSAJES -->     
    <logic:empty name="listaProductos">
    <tr class="ListRow1">
    <td colspan="13">
    <div align="center">
    <script type="text/javascript" language="JavaScript1.2">
    var mensaje="<%=mensajeListado%>";
    if(mensaje!="")
    {   alert(mensaje);     }
    </script>
    </div>
    </td>
    </tr>
    </logic:empty>