<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Nextel</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/jquery.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/calendario.js"></script>
<script type="text/javascript">
var MILISEGUNDOS_DIA = 86400000;
$(document).ready(function(){
    var rangoDias = parseInt($("#rangoDias").val()) - 1;
    
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth();
    var day = today.getDate();
    $("#fechaFin").val(formatoNumero(day) + "/" + formatoNumero(month+1) + "/" + year);

    var diasMilis = rangoDias * MILISEGUNDOS_DIA;
    var milis = today.getTime() - diasMilis;
    var date = new Date();
    date.setTime(milis);
    $("#fechaInicio").val(formatoNumero(date.getDate()) + "/" + formatoNumero(date.getMonth()+1) + "/" + date.getFullYear());
});
function validarFormulario () {
    var fechaInicio = $("#fechaInicio").val();
    var fechaFin = $("#fechaFin").val();
    var rangoDias = parseInt($("#rangoDias").val()) - 1;
    var tipoDoc =  $("#tipoDocumento").val();
    var numDoc =  $("#nroDocumento").val();
    
    if ($.trim(fechaInicio)=='') {
        alert ('Ingrese la Fecha inicio');
        return false;
    }
    
    if ($.trim(fechaFin)=='') {
        alert ('Ingrese la Fecha fin');
        return false;
    }
        
    var opcion = estaEnRango (fechaInicio, fechaFin, rangoDias);
    if (opcion == 1) {
        alert ("La fecha inicial es mayor a le fecha final");
        return false;
    } else if (opcion == 2) {
        alert ("Las fechas deben estar en rango de " + (rangoDias+1) + " dias");
        return false;
    }
    
    if( numDoc != ""  &&  tipoDoc == 0){
        alert ("Seleccione un Tipo Documento ");
        return false;
    }
    
     if( tipoDoc != 0  &&  numDoc == ""){
        alert ("Ingresar Nro. de documento");
        return false;
    }
}

function estaEnRango (strInicio, strFin, dias) {
    var valInicio = parseFecha (strInicio);
    var dateInicio = new Date (parseInt(valInicio[3]), parseInt(valInicio[2])-1, parseInt(valInicio[1]), 0, 0, 0, 0);
    var milisInicio = dateInicio.getTime();
        
    var valFin = parseFecha (strFin);
    var dateFin = new Date(parseInt(valFin[3]), parseInt(valFin[2])-1, parseInt(valFin[1]), 0, 0, 0, 0);
    var milisFin = dateFin.getTime();
        
    if (milisInicio > milisFin) {
        return 1; 
            
    } else {
        var diasMilis = dias * MILISEGUNDOS_DIA;
        var diferencia = milisFin - milisInicio;
        if (diferencia >= 0 && diferencia <= diasMilis) {
            return 0; 
        } else {
            return 2;
        }
    }
}

function parseFecha (fecha) {
    var datePat = /^(\d{2})\/(\d{2})\/(\d{4})$/;
    return fecha.match(datePat);
}

function formatoNumero (numero) {
    if (numero<10) {
        return "0" + numero;
    }
    return numero;
}
</script>
</head>
<body>
<html:form action="/OrderAction.do" method="post" onsubmit="return validarFormulario();">
<html:hidden property="metodo" value="generarReportePago"/>
<html:hidden styleId="rangoDias" property="rangoDias"/>
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
                                <td height="22" colspan="2" class="PortletHeaderColor">
                                    <div class="PortletHeaderText">&nbsp;&nbsp;Men&uacute;</div>
                                </td>
                            </tr>  
                            <tr>
                                <td width="15">&nbsp;</td>
                                <td width="185">                                    
                                    <jsp:include page="/menu.jsp"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td width="87%" valign="top">
            <table width="100%" border="1" class="RegionHeaderColor">
                <tr>
                    <td>                        
                            <table width="85%">
                                <tr class="ListRow1">
                                    <td colspan="6" class="PortletHeaderColor">
                                        <div class="PortletHeaderText">Reporte de pago</div>
                                    </td>
                                </tr>
                                <tr class="ListRow1">
                                    <td colspan="6" class="PortletText1">Criterios de Búsqueda</td>
                                </tr>    
                                <tr class="ListRow1">
                                    <td width="14%" class="LeftSubTab">
                                        <strong>Cadena</strong>
                                    </td>
                                    <td width="20%" colspan="3">  
                                    <html:select property="idCadena" title="*">
                                        <option value="0" >-- Todos --</option>
                                        <html:options collection="ListaCadena" property="npretailerid" labelProperty="npname"/>
                                    </html:select>
                                    </td>                             
                                    <td colspan="2" class="ListRow1">&nbsp;&nbsp;</td>
                                </tr>   
                                <tr class="ListRow1">
                                    <td width="14%" class="LeftSubTab">
                                        <strong>Tipo Documento</strong>
                                    </td>
                                    <td width="20%" colspan="3">  
                                    <html:select styleId="tipoDocumento" property="tipoDocumento" title="*">
                                        <option value="0" >-- Seleccione --</option>
                                        <html:options collection="documento" property="npparameterid" labelProperty="npparametername"/>
                                    </html:select>
                                    </td>                             
                                    <td colspan="2" class="ListRow1">&nbsp;&nbsp;</td>
                                </tr>                        
                                <tr class="ListRow1">
                                    <td width="14%" class="LeftSubTab">
                                        <strong>Nro. Documento</strong>
                                    </td>
                                    <td width="20%" colspan="3">    
                                        <html:text styleId="nroDocumento" property="nroDocumento"  title="*"    onkeypress="return solo_numeros(event)"  maxlength="15"/>
                                    </td>                             
                                    <td colspan="2" class="ListRow1">&nbsp;&nbsp;</td>
                                </tr>   
                                <tr class="ListRow1">
                                    <td width="14%" class="LeftSubTab">
                                        <strong>Fecha Inicio (*)</strong>
                                    </td>
                                    <td width="20%" colspan="3">  
                                    <html:text styleId="fechaInicio" property="fechaInicio"  title="*"    onkeypress="mascara2(this,'/',patron2,true,event)" onblur="javascript:esFechaValida(this)"/>
                                    <a href="javascript:show_Calendario('forms[0].fechaInicio');"><img src="images/show-calendar.gif"  alt="" border="0"></a>
                                    </td>  
                                    <td width="17%" class="LeftSubTab">
                                        <strong>Fecha Fin (*)</strong>
                                    </td>
                                    <td width="40%">  
                                    <html:text styleId="fechaFin" property="fechaFin"  title="*"    onkeypress="mascara2(this,'/',patron2,true,event)" onblur="javascript:esFechaValida(this)"/>
                                    <a href="javascript:show_Calendario('forms[0].fechaFin');"><img src="images/show-calendar.gif"  alt="" border="0"></a>
                                    </td>            
                                </tr>
                                <tr>
                                    <td width="14%" >&nbsp;</td>
                                    <td width="21%" >&nbsp;</td>
                                    <td width="20%"  colspan="3">&nbsp;</td>                                
                                    <td width="30%" >&nbsp;</td>
                                </tr>                            
                                <tr >
                                    <td width="14%" >&nbsp;</td>
                                    <td width="40%" colspan="4" >
                                        <div align="center">
                                            <input type="submit" name="cmbGenerar" id="cmbGenerar" value=" Generar Reporte" onclick="return validarFormulario();">
                                        </div>
                                    </td>                                                             
                                    <td width="30%" >&nbsp;</td>
                                </tr>   
                                <tr>
                                    <td width="14%" >&nbsp;</td>
                                    <td width="21%" >&nbsp;</td>
                                    <td width="20%"  colspan="3">&nbsp;</td>                                
                                    <td width="30%" >&nbsp;</td>
                                </tr>   
                                <tr>
                                    <td colspan="6">
                                    </td>    
                                </tr> 
                                <tr>
                                    <td width="14%" >&nbsp;</td>
                                    <td width="21%" >&nbsp;</td>
                                    <td width="20%"  colspan="3">&nbsp;</td>                                
                                    <td width="30%" >&nbsp;</td>
                                </tr>
                            </table>
                    </td>   
                </tr>
            </table>
        </td>
    </tr>
</table>
</html:form>
</body>
</html>