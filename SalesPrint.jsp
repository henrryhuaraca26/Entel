<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.nextel.utilities.Constant"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Nextel</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
</head>

<body>
<html:form action="/OrderAction.do" method="post">
<html:hidden property="metodo"/>
<table width="400" border="0" align="center">
  <tr>
    <td width="42%" class="PortletHeaderColor"><div class="PortletHeaderText">Orden de Venta </div></td>
  </tr>
</table>


<table width="400" border="0" align="center">
  <tr>
    <td width="27%" rowspan="2">
    <img src="images/logo.jpg" width="150" height="30">
    </td>
    <td colspan="2"><div align="center"><strong><bean:write name="OrderForm" property="strNamePrint"/></strong></div></td>
  </tr>
  <tr>
    <td width="6%" height="21"><div align="right"><strong>N&deg;</strong></div></td>
    <td width="25%"><div align="center"><bean:write name="OrderForm" property="txtOrderNumber"/></div></td>
  </tr>
</table>
<table width="400" border="0" align="center">
  <tr>
    <td width="11%"><strong>POS:</strong></td>
    <td width="48%"><bean:write name="OrderForm" property="txtRetailer"/> - <bean:write name="OrderForm" property="txtStore"/></td>
  </tr>
  <tr>
    <td><strong>Fecha:</strong></td>
    <td><bean:write name="OrderForm" property="txtDateSales"/></td>
  </tr>
</table>


<table width="400" border="1" align="center">
  <tr>
    <td width="11%" class="ListRow0"><div align="center"><strong>Cant.</strong></div></td>
    <td width="9%" class="ListRow0"><div align="center"><strong>SKU</strong></div></td>
    <td width="14%" class="ListRow0"><div align="center"><strong>Precio Unitario</strong></div></td>
    
    <td width="14%" class="ListRow0" style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" ><div align="center"><strong>SKU   <br/> Pago <br/> Anticipado </strong></div></td>
    <td width="14%" class="ListRow0" style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" ><div align="center"><strong>Pago <br/> Anticipado </strong></div></td>
    
    <td width="8%" class="ListRow0"><div align="center"><strong>Monto</strong></div></td>
  </tr>
</table>
<%
    float montoTotal = 0;
%>
<logic:iterate id="venta" name="OrderForm" property="lstVoucher">
<logic:notEqual value="" name="venta" property="skuProduct">
<bean:define id="totalproducto" name="venta" property="costTotal"/>
<table width="400" border="0" align="center">
<tr>
    <td width="11%"><div align="center"><span style="font-size:11px"><bean:write name="venta" property="cantidad"/></span></div></td>
    <td width="9%"><div align="center"><span style="font-size:11px"><bean:write name="venta" property="skuProduct"/></span></div></td>
    <td width="14%"><div align="right"><span style="font-size:11px"><bean:write name="venta" property="costProduct"/></span></div></td>    
    <td width="14%" style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" ><div align="right"><span style="font-size:11px"><bean:write name="venta" property="skuProductAnticipado"/></span></div></td>
    <td width="14%" style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" ><div align="right"><span style="font-size:11px"><bean:write name="venta" property="costProductAnticipado"/></span></div></td>    
    <td width="8%"><div align="right"><span style="font-size:11px"><bean:write name="venta" property="costTotal"/></span></div></td>  
  </tr>
  <%montoTotal = montoTotal + (totalproducto!=null?(Float)totalproducto:0);%>
</table>
</logic:notEqual>
</logic:iterate>
<logic:notEqual value="0" name="OrderForm" property="txtMostraDeposito">
  <%
    String monedaDepo = (String)request.getSession().getAttribute("moneda");
    Float montoDepo = (Float)request.getSession().getAttribute("monto");
            
    String skuGuarantee = "";
    String productGuarantee = "";
    Integer productGuaranteeQuantity = 0;
    
    Long idModality = new Long(request.getSession().getAttribute("IdModality").toString());
    Long guaranteeProductFlag = new Long(request.getSession().getAttribute("GuaranteeProductFlag").toString());
    String modality_sale = Constant.P_MODALITY_CONSIGNACION;
    String guaranteeProductFlagEnabled = Constant.GUARANTEE_PRODUCT_ENABLE;
    int guaranteeProductEnabled = Integer.parseInt(guaranteeProductFlagEnabled);
    int modalityConsignation = Integer.parseInt(modality_sale);
                 
    if((idModality==modalityConsignation) && (guaranteeProductFlag==guaranteeProductEnabled)) {
        skuGuarantee = request.getSession().getAttribute("skugarantia") ==null?"":(String)request.getSession().getAttribute("skugarantia");
        productGuarantee = request.getSession().getAttribute("productogarantia") == null?"":(String)request.getSession().getAttribute("productogarantia");
        productGuaranteeQuantity = request.getSession().getAttribute("cantidadproductogarantia") == null?0:(Integer)request.getSession().getAttribute("cantidadproductogarantia");
    
        montoTotal += montoDepo;
    }
    
  if((idModality==modalityConsignation) && (guaranteeProductFlag==guaranteeProductEnabled)) {%>
  <table width="400" border="0" align="center">
  <tr>
      <td width="100%" class="ListRow0" colspan="4"><span style="font-size:11px">Deposito en Garantía:</span></td>
  </tr>
  <tr>
    <td width="11%"><div align="center"><span style="font-size:11px"><%=productGuaranteeQuantity%></span></div></td>
    <td width="9%"><div align="center"><span style="font-size:11px"><%=skuGuarantee%></span></div></td>
    <td width="14%"><div align="right"><span style="font-size:11px">&nbsp;</span></div></td>
    <td width="8%"><div align="right"><span style="font-size:11px"><%=montoDepo%></span></div></td>
  </tr>
  </table>
  <% 
    
  } %>  
  
</logic:notEqual>




<table width="400" border="0" align="center">
<tr>
    <td width="11%"><div align="center"><span style="font-size:11px"></span></div></td>
    <td width="9%"><div align="center"><span style="font-size:11px"></span></div></td>
    <td width="14%"><div align="right"><span style="font-size:11px"><strong> Costo Total:</strong></span></div></td>
    <td width="8%"><div align="right"><span style="font-size:11px"><%=montoTotal%></span></div></td>
  </tr>
</table>
<p>&nbsp;</p>

</html:form>
</body>
</html>
<script type="text/javascript">
window.print();
</script>
