<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Nextel</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
<script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>      
<script type="text/javascript" src="js/jquery.simplemodal.js"></script> 
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.10.4.min.css">  
<link type='text/css' href='css/modal.css' rel='stylesheet' media='screen' />
</head>
<body>
<script type="text/javascript" language="javascript">
    var flag=1;
    
    function soloNumeros(e){   
        var key = window.Event ? e.which : e.keyCode;
        return ( (key >= 8 && key <= 13) || (key >= 48 && key <= 57) || key==46); 
   }
        
    function checkDecimals(fieldName, fieldValue) {
        decallowed = 2; 
        
        if (isNaN(fieldValue) || fieldValue == "") {
            alert("El monto no es válido.");
            fieldName.select();
            fieldName.focus();
        }else if(fieldValue.substring(0,1)=="-"){
            alert("El monto no es válido.");
            fieldName.select();
            fieldName.focus();
        }
        else {
            if (fieldValue.indexOf('.') == -1) fieldValue += ".";
              dectext = fieldValue.substring(fieldValue.indexOf('.')+1, fieldValue.length);
        
            if (dectext.length > decallowed)
            {
                alert ("Por favor ingresar un número con " + decallowed + " decimales.");
                fieldName.select();
                fieldName.focus();
            }
            else {
                return true;
            }
       }
   }
    
    function respuesta()
    {
        var resultado = "<%=(String)request.getAttribute("mensaje")%>";
        if (resultado=='repeat')
        {
           alert('Ya existe ese sku en esta cadena');
        }
    }
    
    function eliminarItem(valor, idCadena)
    {
        var entra = confirm("Esta Ud. seguro de Eliminar SKU")
        if(entra)
        {
            document.forms[0].hidIdCadena.value = idCadena;
            document.forms[0].hidSkuId.value = valor;
            document.forms[0].metodo.value="deleteSku";
            document.forms[0].submit();            
        }
    }
    
    function buscarSkuNoKit()
    {
        document.forms[0].btnBuscar.disabled=true;     
       
        if(document.forms[0].cmbRetailerSearch.value=='0')
        {
          alert('Debe seleccionar la Cadena');
          document.forms[0].cmbRetailerSearch.focus();
          document.forms[0].btnBuscar.disabled=false;
        }
        else
        {
            document.forms[0].hidIdCadena.value = document.forms[0].cmbRetailerSearch.value;
            document.forms[0].asociando.disabled=false;
            document.forms[0].metodo.value= 'getSkuNoKit';
            document.forms[0].submit(); 
        }  
    }
    
    function buscarProcessSkuNoKit()
    {   
        if(document.forms[0].cmbRetailer.value=='0')
        {
          alert('Debe seleccionar la Cadena');
          document.forms[0].cmbRetailer.focus();
        }
        else
        {
            document.forms[0].asociando.disabled=false;
            document.forms[0].metodo.value= 'getProcessSkuNoKit';
            document.forms[0].submit(); 
        }  
    }
    
    function AsociarSkuNoKit()
    {
        document.forms[0].asociando.disabled=true;  
         if(document.forms[0].cmbRetailer.value=='0')
        {
          alert('Debe seleccionar la Cadena');
          document.forms[0].cmbRetailer.focus();
          document.forms[0].asociando.disabled=false;          
        }
        else
        {
            if(document.forms[0].txtSKU.value!='')
            {
                if(document.forms[0].txtMonto.value!=0)
                {
                   if(checkDecimals(document.forms[0].txtMonto, document.forms[0].txtMonto.value) != true){
                       document.forms[0].asociando.disabled=false;
                       return false;
                   }else{
                       var listaproducts = "";
                       var existeselec=0; 
                       document.forms[0].hidIdCadena.value = document.forms[0].cmbRetailer.value;
                       document.forms[0].asociando.disabled=false;
                       document.forms[0].metodo.value= 'proccessSku';
                       document.forms[0].submit();
                    }
                }else{                   
                   document.forms[0].txtMonto.focus();
                   alert('Debe ingresar un Monto');
                   document.forms[0].asociando.disabled=false;                      
                }
            }
            else
            {
                document.forms[0].txtSKU.focus();
                alert('Debe ingresar un SKU');
                document.forms[0].asociando.disabled=false;
            }
        }          
    }
    
</script>
<html:form action="/SkuNoKitAction.do" method="post">
<html:hidden property="hidSkuId" />
<html:hidden property="metodo" />
<html:hidden property="hidIdCadena" />
<table width="100%"  border="0">
  <tr>
    <td height="60" colspan="2">
        <jsp:include page="/header.jsp"/>    
    </td>
  </tr>
  <tr>
    <td width="13%" height="411" valign="top"><table width="100%" border="1" class="RegionHeaderColor">
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
    <td width="87%" valign="top">
	<table width="100%" border="1" class="RegionHeaderColor">
    <tr>
    <td>
	
  <table width="100%"  border="0">
  	<tr class="ListRow1">
      <td colspan="3" class="PortletHeaderColor"><div class="PortletHeaderText">Asignar Sku Pago Anticipado</div></td>
  </table>
  
  <table width="100%"  border="0">    
    <tr class="ListRow1">
      <td colspan="8" class="PortletText1">Busqueda</td>
    </tr>
    <tr class="ListRow1">      
     <td width="8%" class="LeftSubTab"><strong>Cadena</strong></td>
     <td width="13%"><div align="left"/>
          <html:select property="cmbRetailerSearch">
              <option value="0" >--Seleccionar--</option>
                <html:options collection="ListaCadena" property="npretailerid" labelProperty="npname"/>
           </html:select>
     </td>
     <td width="13%"><input type="button" name="btnBuscar" value="Buscar" onclick="javascript:buscarSkuNoKit();"></td>
     <td width="13%">&nbsp;</td>
     <td width="13%">&nbsp;</td>
    </tr>
    
    <tr class="ListRow1">
      <td colspan="8" class="PortletText1">Crear Sku Pago Anticipado</td>
    </tr>
    <tr class="ListRow1">
      <td width="8%" class="LeftSubTab"><strong>Cadena</strong></td>
      <td width="13%"><div align="left"/>
          <html:select property="cmbRetailer">
              <option value="0" >--Seleccionar--</option>
                <html:options collection="ListaCadena" property="npretailerid" labelProperty="npname"/>
           </html:select>
       </td>
       <td width="13%">&nbsp;</td>
       <td width="13%">&nbsp;</td>
       <td width="13%">&nbsp;</td>
    </tr>
    <tr class="ListRow1">
         <td width="10%" class="LeftSubTab">
            <strong>Monto</strong>
         </td>
          <td width="15%">
            <p>
              <label/><html:text property="txtMonto" maxlength="8" size="15" onkeypress="return soloNumeros(event);" />
            </p>            
          </td>
          <td width="8%">&nbsp;</td>
          <td width="13%">&nbsp;</td>
          <td width="13%">&nbsp;</td>
    </tr>
    <tr class="ListRow1">
         <td width="10%" class="LeftSubTab">
            <strong>SKU</strong>
         </td>
          <td width="15%">
            <p>
              <label/><html:text property="txtSKU" maxlength="30" size="15" onkeypress=" alfanumerico(this);"/>
            </p>            
          </td>
          <td width="8%"><input type="button" name="asociando" value="Asociar" onclick="javascript:AsociarSkuNoKit();"></td>
          <td width="13%">&nbsp;</td>
          <td width="13%">&nbsp;</td>
    </tr>    
    <tr class="ListRow1">
      <td colspan="8">&nbsp;</td>
    </tr>
  </table>
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td colspan="4" class="PortletText1">Lista de Sku Pago Anticipado</td>
    </tr>
    <tr class="ListRow1">
      <td colspan="4">      
    <logic:notEmpty name="listaSkuNoKitAssigned" scope="session">
        <div align="center" >
            <div class="PageLinks">     
                  <display:table id="skuasignada" name="sessionScope.listaSkuNoKitAssigned"
                    style="width:100%" pagesize="10"  requestURIcontext="true" excludedParams="*"  cellpadding="0">
                  <display:column title="Cadena" property="cadena" class="ListRow1" headerClass="LeftSubTabStruts" />
                  <display:column title="SKU" property="npsku" class="ListRow1" headerClass="LeftSubTabStruts" />
                  <display:column title="Monto" property="npamount" class="ListRow1" headerClass="LeftSubTabStruts"style="text-align:right"  format="{0,number,#,##0.00}" />  
                  <display:column title="Eliminar" class="ListRow1" headerClass="LeftSubTabStruts" style="text-align:center;">
                        <div align="center"><a href="javascript:eliminarItem('${skuasignada.npskukitid}', '${skuasignada.npretailid}')" ><img src="images/Eliminar.gif" width="16" height="15" border="0" title="Eliminar"></a></div>
                </display:column>  
                </display:table>
            </div> 
        </div>
    </logic:notEmpty>  
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
</td>
  </tr>
</table>
<script type="text/javascript" language="javascript">
    var mensaje = "<%=(String)request.getAttribute("mensajeRegistro")%>";    
    
    if(mensaje!=null && mensaje=='registroExito')
    {
       alert('Se Registro el SKU');       
       document.forms[0].metodo.value="getProcessSkuNoKit";
       document.forms[0].submit();
    } else if(mensaje!=null && mensaje=='deleteExito')
    {
       alert('Se Elimino el SKU');
       document.forms[0].metodo.value="getProcessSkuNoKit";
       document.forms[0].submit();
    }else if(mensaje == 'registroDuplicado'){
        alert('Monto Sku ya esta registrado.');
    }
    
    if(mensaje!= null && mensaje =="errorprocess")
    {  
        alert("Se produjo un error en la operación");
    }        
</script>
</html:form>
</body>
</html>