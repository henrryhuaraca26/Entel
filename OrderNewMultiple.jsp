<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.nextel.utilities.StringUtils" %>
<%@page import="com.nextel.utilities.Constant" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Entel</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/callAjax.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
<script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="js/jquery.simplemodal.js"></script> 
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.10.4.min.css">  
<link type='text/css' href='css/modal.css' rel='stylesheet' media='screen' />

<script type="text/javascript" src="js/2jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery.hashchange.min.js"></script> 
<script type="text/javascript" src="js/jquery.easytabs.min.js"></script> 

<!--Apolarc Proyecto Telefonia Fija -->

<style type="text/css">

.hide{
    display : none;
}

.show{
    display : block;
}

</style>

<!--Archivo para componente Acepta-->
<script type="text/javascript" src="js/json2.js"></script>
<OBJECT classid='CLSID:592B9D7E-51C9-401F-A03C-4DE61FF7008D' name="Autentia" id='Autentia'></OBJECT>
<!--
<script language="JavaScript" type="text/javascript" src="js/jsrasign/ext/jsbn.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/ext/jsbn2.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/ext/rsa.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/ext/rsa2.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/ext/base64.js"></script>

<script language="JavaScript" type="text/javascript" src="js/cryptojs/yahoo-min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/core.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/md5.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/sha1.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/sha256.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/ripemd160.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/x64-core.js"></script>
<script language="JavaScript" type="text/javascript" src="js/cryptojs/sha512.js"></script>

<script language="JavaScript" type="text/javascript" src="js/jsrasign/rsapem-1.1.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/rsasign-1.2.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/asn1hex-1.1.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/x509-1.1.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jsrasign/crypto-1.1.min.js"></script>


<script type="text/javascript" src="js/plugin.autentia.js"></script>
-->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!--Apolarc Proyecto Telefonia Fija -->

<style type="text/css">

.hide{
    display : none;
}

.show{
    display : block;
}

</style>

<!-- Fin Apolarc-->
</head>
<%

   List<String> listado=new ArrayList<String>();
   String specialprice = (String)request.getAttribute("specialprice");
   request.setAttribute("specialprice",specialprice);
   String deposite = (String)request.getAttribute("deposite");
   
   
   request.setAttribute("deposite",deposite);
   System.out.println("deposite="+deposite);
   System.out.println("specialprice="+specialprice);
   
  /*      java.util.Properties properties= new java.util.Properties();
         properties.load(com.nextel.action.OrderActionMultiple.class.getResourceAsStream("/constant.properties"));
       */
     /*    int productoSerie = Integer.parseInt(properties.getProperty("parameter_specificationId_producto_serie"));
         //LEL 30-11-09 Se filtrará los prepago y postpago por Specification 
         int idSpecification_product_prePago = Integer.parseInt(properties.getProperty("parameter_specificationId_prePago"));
         int idSpecification_product_postPago = Integer.parseInt(properties.getProperty("parameter_specificationId_postPago"));   
         
        int idSpecification_product_prePago_portability = Integer.parseInt(properties.getProperty("parameter_specificationId_prePago_portability"));
        int idSpecification_product_postPago_portability = Integer.parseInt(properties.getProperty("parameter_specificationId_postPago_portability")); 
   */
                          int productoSerie = Integer.parseInt(Constant.P_SPECIFICATIONID_PRODUCTO_SERIE);            
                       //Se filtrarï¿½ los prepago y postpago por Specification 
                       int idSpecification_product_prePago = Integer.parseInt(Constant.P_SPECIFICATIONID_PREPAGO);
                     int idSpecification_product_postPago = Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO);
         
                               
                       //DEANAYAC : se agrega constantes de portabilidad 
                        int idSpecification_product_prePago_portability = Integer.parseInt(Constant.P_SPECIFICATIONID_PREPAGO_PORTABILITY);
                        int idSpecification_product_postPago_portability = Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO_PORTABILITY);        
                        int activo_flag= Integer.parseInt(Constant.P_ACTIVE);                      
%>
<body onload="javascript:resultado();">
<EMBED id="plgAutentia" TYPE="application/x-proxyautentiasocket-plugin" ALIGN=CENTER WIDTH=0 HEIGHT=0>
<script type="text/javascript" language="javascript">  
var mostrarPop = "<%=(String)request.getAttribute("mostrarDetalleValidacion")%>";

if(mostrarPop=="1")
{ window.open('EvaluationCreditCustomer.jsp',"","width=600,height=300,scrollbars=auto,resizable=yes,modal=yes");   }

var mostrarPopup = "<%=(String)request.getAttribute("popupVerificacion")%>";
var sFlagNovatroinic = "<%=(String)request.getAttribute("sFlagNovatroinic")%>";
var sNovatronicMessageText="<%=(String)request.getAttribute("messageBodyToShow")%>";

if(mostrarPopup=="0" && sFlagNovatroinic!="0" && sNovatronicMessageText!="null")
{
    alert("<%=(String)request.getAttribute("messageBodyToShow")%>");
}
if(mostrarPopup=="1")
{   
    $(document).ready(function() {         
        $('#popup_reniec_view').modal({
            show: false,
            width: 'auto',
            height: 'auto',
            backdrop: 'static'
        });
        $('#popup_reniec_view').bind('keydown', function(e) { 
            if (e.which == 27) {
                return false;
            }
        }); 
        });   
}

if(mostrarPopup=="2"){
    $(document).ready(function(){       
        $("#popup_reniec_view_IdData").modal({
            show: false,
            width: 'auto',
            height: 'auto',
            backdrop: 'static'
        });
        $('#popup_reniec_view_IdData').bind('keydown', function(e) { 
            if (e.which == 27) {
                return false;
            }
        });
        });  

}

if(mostrarPopup=="3"){
    $(document).ready(function(){
        mostrarValdiacionBiometrica();
    });

}

function mostrarValdiacionBiometrica(){
    $("#popup_identificacion_view").modal({
        show: false,
        width: 'auto',
        height: 'auto',
        backdrop: 'static',
		/*NORMALIZACION DE DIRECCIONES*/
        onClose: function (dialog) {
            if(autentiBiometricaOK == true ){
                mostrarNormalizacionDirecciones();
            }
            $.modal.close();
        }
        /*NORMALIZACION DE DIRECCIONES FIN*/
    });
    $('#popup_identificacion_view').bind('keydown', function(e) { 
        if (e.which == 27) {
            return false;
        }
    });        
    
    $("#dniValidBiomTxt").val("<%=(String)request.getAttribute("dniBiometrica")%>");
    $("#ordenIdValidBiomTxt").val("<%=(Integer)request.getAttribute("ordenGenerada")%>");
    $("#multiple").val("<%=(Integer)request.getAttribute("multiple")%>");
    $("#multipleOrderId").val("<%=(Long)request.getAttribute("multipleOrderId")%>");

    $("#tipoDocu").val("<%=(String)request.getAttribute("tipoDocu")%>");

    dniUserReniec = "<%=(String)request.getAttribute("dniUserReniec")%>";
    transaccionAcepta = "<%=(String)request.getAttribute("transaccionAcepta")%>";
    $("#divSeleccionDatosCliente").hide();
    $("#divErrorBiometrico").hide();
    $("#divCuestionarioBiometrico").hide();
    $("#divExitoNoBiometrico").hide();
    $("#divBiometricoExterno").hide();
    $("#divExitoBiometricoExterno").hide();
    if(dniUserReniec==="null"){
        alert("No se ha configurado un DNI de consulta para este promotor");
    }
    cargarComboMotivos();
    cargarComboMotivosNoValidacion();
    
    
      /*para mostrar lo de exoneracion*/
      document.getElementById("rowExonerate").style.display = "none"
    document.getElementById("rowExonerateBtn").style.display = "none"
    document.getElementById("rowOldFlow").style.display = "table-row";
    /*
    var isValidate = validateClientExonerate();
    if(isValidate){ // isValidate hace referencia a si el cliente puede realizar una exoneracion
		document.getElementById("rowExonerate").style.display = "table-row";
		document.getElementById("rowExonerateBtn").style.display = "none";
		document.getElementById("rowOldFlow").style.display = "none";
		$("#divSeleccionValidacion").hide();
		loadTypeDocumentExonerate();
                document.getElementById("cmbTypeDocument").value = 0;
                loadLastLegalRepresentative();
	}else{
		document.getElementById("rowExonerate").style.display = "none"
		document.getElementById("rowExonerateBtn").style.display = "none"
		document.getElementById("rowOldFlow").style.display = "table-row";
	}*/
}

      function popupReniec(){
        
        $(document).ready(function() {
            $("#popup_reniec_view").modal({
                show: false,
                width: 'auto',
                height: 'auto',
                backdrop: 'static'
            });
            $('#popup_reniec_view').bind('keydown', function(e) { 
                if (e.which == 27) {
                    return false;
                }
            });
        });       
      }
      function popupIdData(){
       $(document).ready(function() {
            $("#popup_reniec_view_IdData").modal({
                show: false,
                width: 'auto',
                height: 'auto',
                backdrop: 'static'
            });
            $('#popup_reniec_view_IdData').bind('keydown', function(e) { 
                if (e.which == 27) {
                    return false;
                }
            });
        });       
      }
      

        function ViewPorta(xml){
            
                 var portabilidad = xml.getElementsByTagName("portabilidad")[0];
                 var data = portabilidad.getElementsByTagName("data");
               
                for(var i = 0 ; i<data.length ; i++)
                {
                    var item = data[i];
                    var myString = item.firstChild.nodeValue;
                    var campo = myString.split(";");
                    var cedente = campo[0];
                    var numero = campo[1]; 
                    var operadora = campo[2];
                    var tipoDocumento = campo[3];
                    var numeroDocumento = campo[4];
                }
                  //document.getElementById('txtCedenteview').value=cedente;
                  $('select[name="txtCedenteview"]')[0].value=cedente;
                  //document.getElementById('txtOperadoraView').value=operadora;
                  $('select[name="txtOperadoraView"]')[0].value=operadora;
                  document.getElementById('lblTelefonoview').innerHTML=numero;
                    $('select[name="txtTipoDocumento"]')[0].value=tipoDocumento;            
                  document.getElementById('txtNumeroDocumento').innerHTML=numeroDocumento
                  //$('input[name="lblTelefonoview"]').innerHTML=numero;
            }

function metodoExtraAnulacion(){
    if(document.getElementById('ocultar_Procesar')!=null){
        document.getElementById('ocultar_Procesar').style.display = 'none';
    }
    $("#btnImprimirVoucher").hide();
}
function metodoExtraOK(){
	//NORMALIZACION DE DIRECIONES
    autentiBiometricaOK = true;
    //NORMALIZACION DE DIRECIONES FIN
}
function ValidarCliente()
{
    if(validarCamposCliente()==true){
        document.forms[0].metodo.value="customerValidate";
        document.getElementById('ocultar_Validar').style.visibility="hidden";
        document.forms[0].submit();
    }    
}


function validarCamposCliente()
{
    if(document.forms[0].cmbDivision.value=="0")
    {
        alert("Debe de seleccionar la División");
        document.forms[0].cmbDivision.focus();
        return false;
    }
    if(document.forms[0].cmbCategoria.value=="0")
    {
        alert("Debe de seleccionar el tipo de Categoría");
        document.forms[0].cmbCategoria.focus();
        return false;
    }
    if(document.forms[0].cmbSubCategoria.value=="0")
    {
        alert("Debe de seleccionar el tipo de Sub Categoría");
        document.forms[0].cmbSubCategoria.focus();
        return false;
    }
    return true;
}

//AGN
function cargarTipoDocumentacion()
{

    var pre = "<%=(String)request.getSession().getAttribute("numSolPre")%>";
    var pos = "<%=(String)request.getSession().getAttribute("numSolPos")%>";
    
    var sele = document.getElementById('cmbTipoDocumentacion');
    var tex = sele.options[sele.selectedIndex].text;
    if(tex === "Automático")
    {
        document.getElementById('divEmail').style.display='';
        document.getElementById('divTxtEmail').style.display='';
        document.getElementById('div_cpuf').style.display='';
        document.getElementById('divMotivo').style.display='none';
        document.getElementById('divTxtMotivo').style.display='none';
        document.getElementById('txtOrderNumber').disabled = true;
        document.getElementById('txtOrderNumberPostpago').disabled = true;
        
         var arrayOriginal = [];

      if(document.getElementsByName('txtNameSubcategorias[]').length>0){
        var totalElementosKit = document.getElementsByName('txtNameSubcategorias[]').length;
            var indice = 0;
            for(var i=0; i < totalElementosKit; i++){
                    var imei = 	document.getElementsByName('txtNameSubcategorias[]')[i].value;
                    arrayOriginal[indice] = imei;
                    indice++;
            }
      }
    
    var preIden = "Prepago";
    var posIden = "Postpago";
    var postIden = "PostPago";
    var totalPre = 0;
    var totalPos = 0;
        for(var i=0; i < arrayOriginal.length; i++){
           if(arrayOriginal[i].indexOf(preIden) > -1){
               totalPre++;
           }
           
           if(arrayOriginal[i].indexOf(posIden) > -1 || arrayOriginal[i].indexOf(postIden) > -1){
               totalPos++;
           }                   
        }
            
        if(pos != 'null' && totalPos>0){
            document.getElementById('txtOrderNumberPostpago').value = pos;
        }
        if(pre != 'null' && totalPre>0){
            document.getElementById('txtOrderNumber').value = pre;
        }


    }else if(tex === "Manual"){
        document.getElementById('divMotivo').style.display='';
        document.getElementById('divTxtMotivo').style.display='';
        document.getElementById('divEmail').style.display='none';
        document.getElementById('divTxtEmail').style.display='none';
        document.getElementById('div_cpuf').style.display='none';
        document.getElementById('txtOrderNumber').value = '';
        document.getElementById('txtOrderNumberPostpago').value= '';
        document.getElementById('txtOrderNumber').disabled = false;
        document.getElementById('txtOrderNumberPostpago').disabled = false;
    }
    
}



//
function resultado()
{    
    /* Inicializar los campos*/
     if(document.forms[0].cmbDivision.value=="0")
        {
        document.getElementById('divTipoDocumentacion').style.display='none';
        document.getElementById('divValTipoDocumentacion').style.display='none';
        document.getElementById('divEmail').style.display='none';
        document.getElementById('divTxtEmail').style.display='none';
        document.getElementById('divMotivo').style.display='none';
        document.getElementById('divTxtMotivo').style.display='none';
        document.getElementById('div_cpuf').style.display='none';
        document.getElementById('extra').style.display='';
        }
    /* */
    var mensaje = "<%=(String)request.getAttribute("mensajeEvaluationCredit")%>";    
    if(mensaje!=null && mensaje=='ordenExistente')
    {
       alert('Ya existe una orden con ese número');
    }
    //BALFARO 10/12/2010 INICIO
    if (mensaje!=null && mensaje=='monedasDiferentes')
    {
        alert('Las monedas de los productos elegidos en la orden, deben ser iguales');
    }
    if (mensaje!=null && mensaje=='monedasNull')
    {
        alert('Alguno de los productos elegidos, NO tienen precio o tipo de moneda');
    }
    
    //BALFARO 10/12/2010 FIN
    if(mensaje!=null && mensaje=='ok')
    {
       alert('El proceso de evaluación crediticia se realizara de forma manual')
    }
    if(mensaje!=null && mensaje=='okPopup')
    {
       //document.forms[0].metodo.value="associateNew";
       var specialprice = "<%=(String)request.getAttribute("specialprice")%>";
       var deposite = "<%=(String)request.getAttribute("deposite")%>";
       var popupcancel = "<%=(String)request.getAttribute("popupcancel")%>";
       document.forms[0].specialprice.value = specialprice;
       document.forms[0].deposite.value = deposite;
       document.forms[0].popupcancel.value = popupcancel;
       window.open('EvaluationCredit.jsp',"","width=1000,height=500,scrollbars=yes");
    }
    
    if(mensaje!=null && mensaje=='ordenError'){
       alert('Error del servicio que consulta la existencia del número de Solicitud');
    }
    
    if(mensaje!=null && mensaje=='okOrden'){
       alert('Se grabó la orden');
    }/*
    if(mensaje!=null && mensaje=='timeLimitExceeded'){
       var sBodymensaje = "<%=(String)request.getAttribute("mensajeBodyMessage")%>";
       alert(sBodymensaje);
    }*/
  var categoria = document.forms[0].cmbCategoria.value;
  
    if(categoria==3 || categoria == 6){       
      // document.getElementById("tdporta").style.display="block";       
       document.getElementById("tdregion").style.display="none";       
    }else{
      // document.getElementById("tdporta").style.display="none";       
       document.getElementById("tdregion").style.display="";       
    }
    
    var flagRadio="<%=request.getSession().getAttribute("flagRadioMontoAnticipado")%>";    
    if (flagRadio=="true"){
        $('input:radio[name=pagoAnticipado]').attr("disabled",true);
    }
    
   var messageError="<%=request.getSession().getAttribute("ErrorThnkis")%>";     
   if(messageError!="" &&  messageError!=null && messageError!= "null"  ){
       alert(messageError);
   }
    
    
}
/* INICIO
* CREATED BY : FBERNALES   -- PROYECTO: PORTABILIDAD  
*                          -- REQUERIMIENTO : LIMITE DE TIEMPO PARA LAS ORDENES DE PORTABILIDAD
*/
function ProcesarOrden()
{   

     var categoria = document.forms[0].cmbCategoria.value;
     if(categoria==3){
       
    if($('#divTipoDocumentacion').css('display') !== 'none'){ 
            var sele = document.getElementById('cmbTipoDocumentacion');
            var tex = sele.options[sele.selectedIndex].text;
            if(tex === "Manual"){
            
                if(document.forms[0].cmbMotivo){
                    if(document.forms[0].cmbMotivo.value == 0){
                        document.forms[0].cmbMotivo.focus();
                        alert("Debe seleccionar motivo");
                        return false;
                    }                
                }
            }       
        }     
    }else{
    if($('#divTipoDocumentacion').css('display') !== 'none'){ 
        var sele = document.getElementById('cmbTipoDocumentacion');
        var tex = sele.options[sele.selectedIndex].text;
        if(tex === "Manual"){
        
            if(document.forms[0].cmbMotivo){
                if(document.forms[0].cmbMotivo.value == 0){
                    document.forms[0].cmbMotivo.focus();
                    alert("Debe seleccionar motivo");
                    return false;
                }                
            }
        }
        }
    
    }
    var arrayOriginal = [];

      if(document.getElementsByName('txtNameSubcategorias[]').length>0){
        var totalElementosKit = document.getElementsByName('txtNameSubcategorias[]').length;
            var indice = 0;
            for(var i=0; i < totalElementosKit; i++){
                    var imei = 	document.getElementsByName('txtNameSubcategorias[]')[i].value;
                    arrayOriginal[indice] = imei;
                    indice++;
            }
      }
    
    var pre = "Prepago";
    var pos = "Postpago";
    var post = "PostPago";

    for(var i=0; i < arrayOriginal.length; i++){
                   
                   if(arrayOriginal[i].indexOf(pre) > -1){
                        var vOrderNumber = $.trim(document.forms[0].txtOrderNumber.value);
                        if(vOrderNumber == "")
                        {
                            alert("Debe ingresar el Número de Orden Prepago");
                            document.forms[0].txtOrderNumber.focus();
                            return false;
                        }
                   }
                   
                   if(arrayOriginal[i].indexOf(pos) > -1 || arrayOriginal[i].indexOf(post) > -1){
                        var vOrderNumberPos = $.trim(document.forms[0].txtOrderNumberPostpago.value);
                        if(vOrderNumberPos == "")
                        {
                            alert("Debe ingresar el Número de Orden PostPago");
                            document.forms[0].txtOrderNumberPostpago.focus();
                            return false;
                        }
                   }
                   
            }
            
    var tipoDocumento = document.forms[0].txtCustomerDocumentType.value;         
    var pagoAnticipado = document.forms[0].radioAnticipado.value;
    var totalAnticipado = document.forms[0].txtPagoAnticipadoTotal.value;
    
    if (!$('input[name="pagoAnticipado"]').is(':checked') && tipoDocumento!='RUC'  ) {
        alert("Seleccionar ::: Aplicar Pago Anticipado ");
        return false;
        }       
           
   //JESPINOZA PRY-0890 SE VALIDA QUE SI ES SI EL MONTO ANTICIPADO SEA MAYOR A 0
   if(pagoAnticipado == "SI" && totalAnticipado =="0.0"){
      alert("La Suma Total de Pago Anticipado es 0, debe seleccionar NO. ");
      return false;
   }
    
    
    var result = false;
    var rucTemp = document.forms[0].txtCustomerDocumentNumber.value;
    var subCategoria = document.forms[0].cmbSubCategoria.value;	
    var categoria = document.forms[0].cmbCategoria.value;
	
	/*mespinoza REQ-0204*/
    var subCategoriaFinal = subCategoria.split("|");//Obtenemos el código de la subcategoria
    if(categoria == 3){
    if(!verifyPhoneEvaluation(subCategoriaFinal[1])){
          return false;
        }
    }    

    /*fin mespinoza*/
    //document.getElementById("btnProcesar").disabled = true;
    document.getElementById('ocultar_Procesar').style.display = 'none';
    /* FBERNALES - LIMPIAMOS LOS CAMPOS DE VALIDACION DE LIMITE DE TIEMPO*/   

    var req = newXMLHttpRequest();  
    req.onreadystatechange = getReadyStateHandler(req,ValidateProcessTimeLimitExceededp);
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=ValidarTimeLimitFromJsp&cmbSubCategoria=" + subCategoria+"&tipoValidacionHora=CREACION",true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);   
}
/*mespinoza*/
function verifyPhoneEvaluation(categoryId){
        var userLogin = document.forms[0].userLogin.value;
	var imei;
	var strImei = "";
	var resultado = true;
	if(document.getElementsByName('txtIMEIArrayFinal[]').length>0){
    var totalElementos = document.getElementsByName('txtIMEIArrayFinal[]').length;
	
	for(var i=0; i < totalElementos; i++){
		var imei = 	document.getElementsByName('txtIMEIArrayFinal[]')[i].value;
		strImei = strImei + ',' + imei;
	}
  }
	
  var strSubcategorias = "";
  if(document.getElementsByName('txtNameSubcategorias[]').length>0){
    var totalElementosKit = document.getElementsByName('txtNameSubcategorias[]').length;
	for(var i=0; i < totalElementosKit; i++){
		var imei = 	document.getElementsByName('txtNameSubcategorias[]')[i].value;
               //  var tempResult = imei.split(",");
		//strSubcategorias = strSubcategorias + ',' + imei;
                if (imei=="Postpago Retail"){
                    categoryId = <%= Constant.SPECIFICATION_PORTABILITY %>;
                    break;
                }
                               
	}
  }
	
	
	strImei = strImei.substring(1,strImei.length);//quita la coma principal
	strSubcategorias = strSubcategorias.substring(1,strSubcategorias.length);
	
	$.ajax({
		type: 'POST',
           	async:false, 
           	contentType: "text/json,ISO-8859-1",
           	url: '<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=verifyPhonePorta&imei=' + strImei+'&userLogin='+userLogin+'&categoryId='+categoryId,
           	data: null,
           	success:function(data){
           		//alert('ESTOY DENTRO');
				
				resultado = true;
				var temp = data.getElementsByTagName("portabilidad")[0];
				var tempData = temp.getElementsByTagName("data")[0];
									
				var tempResult = tempData.firstChild.nodeValue.split("|");
									
				if(tempResult[0] =="1"){                    
					resultado = true;
				}else{
					resultado = false;
					alert(tempResult[1]);
				}
           	},
           	error: function(xhr, status, error) {
				resultado = false;
	               alert(status);
	               alert(xhr.responseText);
	        } 

	});
        
        return resultado;

}
/*fin mespinoza*/

/* FIN */ 
function validarNumeroOrden()
{
    var linea=<%=request.getAttribute("linea_producto")%>;
    //if(document.forms[0].txtOrderNumber.value=="")
    var vOrderNumber = $.trim(document.forms[0].txtOrderNumber.value);
    document.forms[0].txtOrderNumber.value = vOrderNumber;
    
    //AGN Comentado
    /*if(linea!=2056 && vOrderNumber == "")
    {
        alert("Debe ingresar el Número de Orden");
        document.forms[0].txtOrderNumber.focus();
        return false;
    }*/
    return true;
}

function ImprimirVoucher()
{
    window.open("OrderActionMultiple.do?metodo=orderPrint","","width=415,height=300,scrollbars=auto,modal=yes");        
}


function fBotonPopup(fOrdenId,fRespuestaReniecIdData,fBotonRespuesta)
{
    var req = newXMLHttpRequest();          
        
    var cmbMotivrechazo=$('select[name="cmbMotivoRechazo"]')[0].value;    
    
    req.onreadystatechange = getReadyStateHandler(req,updateCategoria);
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=ValidarReniec&sOrdenId=" +fOrdenId+"&sRespuestaReniecIdData="+fRespuestaReniecIdData+"&sBotonRespuesta="+fBotonRespuesta+"&sMotivorechazo="+cmbMotivrechazo,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
    
}


function ValidarReniec(resultado){
    if(DatosReniec()==true)
    {
      document.forms[0].resultadoReniec.value=resultado
      document.forms[0].action="<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=ValidarReniec";    
      document.forms[0].submit();
    }
}
function DatosReniec()
{
    return true;
}


function AgregarDetalleOrden(cmbSoluction,cmbLineaProducto){
    
    var tipoOperacion = $("#tipoOperacionHdn2").val(); // MESPINOZA REQ-0204
    
    if(validar()==true){    
         if(document.forms[0].cmbCategoria.value=="3"){
            var totalElementos = document.getElementsByName('txtIdKitArrayFinal[]').length;
            /* if(totalElementos>0){
                 alert("Solo puede ingresar un items orden de portabilidad");
                 return false ;
             }*/
         }        
    }
    else{
        return false ;
    }
    
    /* FBERNALES - LIMPIAMOS LOS CAMPOS DE VALIDACION DE LIMITE DE TIEMPO*/   
    var subCategoria = document.forms[0].cmbSubCategoria.value;
    var req = newXMLHttpRequest();  
    req.onreadystatechange = getReadyStateHandler(req,updatetimeLimitExceeded);
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=ValidarTimeLimitFromJsp&cmbSubCategoria=" + subCategoria+"&tipoValidacionHora=CREACION",true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
  }

function validar()
{
     if(document.forms[0].cmbCategoria.value=="0")
    {
        alert("Debe de seleccionar el tipo de Categoría");
        document.forms[0].cmbCategoria.focus();
        return false;
    }
    
    /*AGN Comentado if(document.forms[0].cmbSubCategoria.value=="0")
    {
        alert("Debe de seleccionar el tipo de Sub Categoría");
        document.forms[0].cmbSubCategoria.focus();
        return false;
    }
    if(document.forms[0].cmbSoluction.value=="0")
    {
        alert("Debe de seleccionar la Solución");
        document.forms[0].cmbSoluction.focus();
        return false;
    }
     if(document.forms[0].cmbLineaProducto.value=="0")
    {
        alert("Debe de seleccionar la Línea de Producto");
        document.forms[0].cmbLineaProducto.focus();
        return false;
    }*/
    
    /*Apolarc Proyecto Telefonia Fija Movil */
        if(document.forms[0].cmbSite.value=="0")     
        {
            alert("Debe de seleccionar un Site");
            document.forms[0].cmbSite.focus();
            return false;
        } 
    /*Fin Apolarc*/
    return true;
}
/* INICIO
* CREATED BY : FBERNALES   --  PROYECTO: PORTABILIDAD  
*                          -- REQUERIMIENTO : LIMITE DE TIEMPO PARA LAS ORDENES DE PORTABILIDAD
*/
function updatetimeLimitExceeded(miXml){
                var LimitExceeded = miXml.getElementsByTagName("limitExceeded")[0];
		var flagTimeLimitExceeded = LimitExceeded.getElementsByTagName("timeLimitExceeded")[0].childNodes[0].nodeValue;		                
                if (flagTimeLimitExceeded=="true"){                  
                    var sBodyMessageToShow = LimitExceeded.getElementsByTagName("sBodyMessageToShow")[0].childNodes[0].nodeValue;
                    alert(sBodyMessageToShow);
                    
                }else if (flagTimeLimitExceeded=="false"){
                    var cmbSoluction=document.forms[0].cmbSoluction.value
                    var cmbLineaProducto=document.forms[0].cmbLineaProducto.value
                    
//AGN
                    var modelo = ""
                    window.open('OrderActionMultiple.do?metodo=orderDetail&cmbSoluction='+cmbSoluction+"&cmbLineaProducto="+cmbLineaProducto+"&modelo="+modelo,'popupDetalle','width=1000,height=500,scrollbars=yes,resizable=yes,modal=yes');
//
                    
                    //Fbernales - REQ- 0363 19/04/2016
                   /* var vtxtDocumentNumber=document.forms[0].txtCustomerDocumentNumber.value;
                    var vtxtDocumentType=document.forms[0].txtCustomerDocumentType.value;
                    window.open('OrderAction.do?metodo=orderDetail&cmbSoluction='+cmbSoluction+"&cmbLineaProducto="+cmbLineaProducto+"&txtDocumentType="+vtxtDocumentType+"&txtDocumentNumber="+vtxtDocumentNumber,'popupDetalle','width=1000,height=500,scrollbars=yes,resizable=yes,modal=yes');
*/
                }
                }
        
        
    //AGN
    function IngresarCPUF(){
        var cpufSelected;
         if(typeof($('input[name=isHome]:checked').val())!="undefined"){
            cpufSelected = $('input[name=isHome]:checked').val();
         }else{
            cpufSelected = "";
         }
       
        window.open('OrderActionMultiple.do?metodo=insertCPUF&cpuf=' + cpufSelected,'popupCPUF','width=1000,height=500,scrollbars=yes,resizable=yes,modal=yes');
    	}
        
    
    //
    
    function validarEmailReturn(email,id) {
        if (email != '') {
            //VALIDANDO SI ESTA BIEN EL FORMATO DEL CORREO
            if (/^[a-zA-Z0-9ñÑ]+([\.-_-]?[a-zA-Z0-9ñÑ]+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)) {
                return true;
            }else{
                document.getElementById(id).focus();
                return false;
            }							
        }
        return false;
    }
    
   function ValidateProcessTimeLimitExceededp(miXml){
   
             var valReturnEmail = false;
             
             //alert(document.forms[0].txtCustomerEmail);
             
    var sele = document.getElementById('cmbTipoDocumentacion');
    var tex = sele.options[sele.selectedIndex].text;

    if(tex === "Automático"){
    
    if(document.forms[0].txtCustomerEmail){
            
        var value = document.getElementById('txtCustomerEmail').value;
 
        if(value.length > 0 ){
            value = trim(value);
            var validEmail =  validarEmailReturn(trim(value), document.forms[0].txtCustomerEmail.name);
            if(validEmail === false){
                mensajeTemp = "Agregar el correo electrónico o el formato de correo incluido es inválido. Verificar o cambiar a generación manual de formatos.";
                document.getElementById('ocultar_Procesar').style.display = 'block';
                alert(mensajeTemp);
            }else{
                valReturnEmail = true;

            }

        } else{   
        
             if(document.forms[0].txtCustomerEmail.length === undefined || value.length === 0 ){
                 mensajeTemp = "Agregar el correo electrónico o el formato de correo incluido es inválido. Verificar ó cambiar a generación manual de formatos";
                document.getElementById('ocultar_Procesar').style.display = 'block';
                valReturnEmail = false;
                alert(mensajeTemp);
             }
        }
    }

    if(valReturnEmail === false){
        return ;
    }
    
    }
      var LimitExceeded = miXml.getElementsByTagName("limitExceeded")[0];
      var flagTimeLimitExceeded = LimitExceeded.getElementsByTagName("timeLimitExceeded")[0].childNodes[0].nodeValue;		
      if (flagTimeLimitExceeded=="true"){                  
         var sBodyMessageToShow = LimitExceeded.getElementsByTagName("sBodyMessageToShow")[0].childNodes[0].nodeValue;
         alert(sBodyMessageToShow);
      }else if (flagTimeLimitExceeded=="false"){                    
         if(validarNumeroOrden()){                        
            document.forms[0].metodo.value="processOrder";
            document.forms[0].radioAnticipado.value=document.forms[0].radioAnticipado.value;
            //document.getElementById('ocultar_Procesar').style.visibility="hidden";
            document.forms[0].submit();
         }else{
            document.getElementById('ocultar_Procesar').style.display = 'block';
         }
      }
      //document.getElementById("btnProcesar").disabled = false;
   }        
/* FIN */
function cerrar()
{
    var entra = confirm("Esta Ud. seguro de cerrar?")
    if(entra)
    {
        document.forms[0].metodo.value="orderClose";
        document.forms[0].submit();
    }
}

function buscarCliente()
{   //PPNN: Se redirecciona al Calificar Cliente
    //document.forms[0].action="<%=request.getContextPath() %>/CustomerAction.do?metodo=customerHome";    
    //if(document.){
    document.forms[0].action="<%=request.getContextPath() %>/CustomerAction.do?metodo=customerPreEvaluation";    
    document.forms[0].submit();
    //}
}

function eliminarDetalleFinal(valor) 
{
    var entra = confirm("Esta Ud. seguro de Eliminar un Item")
    if(entra)
    {
        document.forms[0].idItem.value = valor;
        document.forms[0].metodo.value="deleteItemDetailFinal";
        document.forms[0].submit();
    }
}

function showonlyoneDiv(thechosenone,action,popup) {
     $('.newboxes').each(function(index) {
          if ($(this).attr("id") == thechosenone) {
                if (action=="mostrar"){
                    $(this).show(200);
                    //cargarMotivoRechazo();
                    
                    //deshabilitamos los botones del popup 
                    var divpopupbutton="div"+popup+"Buttons"
                    //var divpopupbutton="#"+divpopupbutton
                    //$('#'+divpopupbutton).prop( "disabled", true );
                    $('#'+divpopupbutton).hide();
                }else if (action=="ocultar"){
                    $(this).hide(600);
                    var divpopupbutton='div'+popup+'Buttons'
                    //var divpopupbutton="#"+divpopupbutton
                    //$('#'+divpopupbutton).prop( "disabled", false );
                    $('#'+divpopupbutton).show();
                }
          }         
     });
}

//Ajax Para cargar el combo Tipo de Linea
/*
function cargarMotivoRechazo()
{
    //document.forms[0].cmbMotivoRechazo.selectedIndex = 0;    
                
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateMotivoRechazo);
    req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=cargarMotivoRechazo",true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);

}

function updateMotivoRechazo(miXml){
                var motivoRechazo = miXml.getElementsByTagName("motivoRechazo")[0];
		var smotivorechazo = motivoRechazo.getElementsByTagName("sMotivoRechazo");
		document.forms[0].cmbMotivoRechazo.length = smotivorechazo.length+1;
		               
		for (var i=0;i<smotivorechazo.length;i++){
                        var item = smotivorechazo[i];
                        var myString = item.firstChild.nodeValue;
                        var trozo = myString.split(";");
                        document.forms[0].cmbMotivoRechazo.options[i+1].value = trozo[0];
                        document.forms[0].cmbMotivoRechazo.options[i+1].text = trozo[1];
		}
	
	}

*/

function cargarCategoria()
{

    document.forms[0].cmbCategoria.selectedIndex = 0;
    document.forms[0].cmbSubCategoria.selectedIndex = 0;
   // document.forms[0].cmbSoluction.selectedIndex = 0;
  //  document.forms[0].cmbLineaProducto.selectedIndex = 0;
    var division = document.forms[0].cmbDivision.value;
    
  
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateCategoria);
    
       //Categoria
           var pageOrig = "<%=request.getRequestURI() %>".replace("<%=request.getContextPath() %>","");
                pageOrig = pageOrig.replace("/","");
                

    
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=cargarCategoria&cmbDivision=" + division + "&pageOrig=" + pageOrig,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);

}

function updateCategoria(miXml){
                var division = miXml.getElementsByTagName("division")[0];
		var cate = division.getElementsByTagName("categoria");
		document.forms[0].cmbCategoria.length = cate.length+1;
		               
		for (var i=0;i<cate.length;i++){
                        var item = cate[i];
                        var myString = item.firstChild.nodeValue;
                        var trozo = myString.split(";");
                        var index = i+1;
                        document.forms[0].cmbCategoria.options[index].value = trozo[0];
                        document.forms[0].cmbCategoria.options[index].text = trozo[1];
                         /*APOLARC*/
                        if(salesrule.category.selected){
                            if($.trim(document.forms[0].cmbCategoria.options[index].value)== salesrule.category.selected ){
                                document.forms[0].cmbCategoria.selectedIndex=index;
                                if(salesrule.category.enable == "0"){
                                    document.forms[0].cmbCategoria.disabled = true;
                                }
                                cargarSubCategoria();
                               
                            }
                       }    
                         /*APOLARC*/
		}
     
	}


function cargarSubCategoria()
{
    /*APOLARC CLEAN COMBOS */
       cleanCombos(3);
       document.forms[0].cmbSubCategoria.disabled = false;
    /*FIN APOLARC*/

    document.forms[0].cmbSubCategoria.selectedIndex = 0;
    document.forms[0].cmbSoluction.selectedIndex = 0;
    document.forms[0].cmbLineaProducto.selectedIndex = 0;
    var categoria = document.forms[0].cmbCategoria.value;
//JARANA FASE III
   
   	var flag = "<%=(String)request.getSession().getAttribute("flag")%>";
    
	var flagTipoDocuemto = "<%=request.getAttribute("status_ce")%>";
    if(categoria==3){
       //document.getElementById("tdporta").style.display="block";
    //JARANA FASE III
      document.getElementById("tdregion").style.display="none";
       var flagTipoDocumentacion = "<%=request.getAttribute("statustipodocumentacion")%>";
       
  if(flag === "display:inline"){
       if(flagTipoDocumentacion==true || flagTipoDocumentacion=="true"){
            mostrarCamposTipoDocumentacion("");
       }else{
            mostrarCamposTipoDocumentacion("none");
       }   
  }
       if(flagTipoDocuemto==true || flagTipoDocuemto=="true"){
            mostrarCamposTipoDocumentacion("none");
        }
    }else if(categoria==0){
        mostrarCamposTipoDocumentacion("none");
    }else {
        //mostrarCamposTipoDocumentacion("none");
        
        if(flagTipoDocuemto==true || flagTipoDocuemto=="true"){
            mostrarCamposTipoDocumentacion("none");
        }else{
             var sel = document.getElementById('cmbDivision');
             var opt = sel.options[sel.selectedIndex];
            if(opt.text.indexOf("Fija")==-1 && opt.text.indexOf("Fijo")==-1) {
                mostrarCamposTipoDocumentacion("");
            }
            
       }
        
       // document.getElementById("tdporta").style.display="none";
         
    }
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateSubCategoria);
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=cargarSubCategoria&cmbCategoria=" + categoria,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
}
function mostrarCamposTipoDocumentacion(value){    
        
    //$("#cmbTipoDocumentacion option[value='3478']").attr("selected", "selected");
    //$("#cmbTipoDocumentacion").trigger("change");
    if(value=='none'){
        document.forms[0].cmbTipoDocumentacion.selectedIndex = 1;
    }else{
        document.forms[0].cmbTipoDocumentacion.selectedIndex = 0;
    }
    //
    //cargarTipoDocumentacion();    
    $("#cmbTipoDocumentacion").trigger("change");    
    document.getElementById('divTipoDocumentacion').style.display=value;
    document.getElementById('divValTipoDocumentacion').style.display=value;   
    document.getElementById('div_cpuf').style.display=value;
    
    if(value=='none'){
        document.getElementById('extra').style.display='';
        document.getElementById('divMotivo').style.display=value;
        document.getElementById('divTxtMotivo').style.display=value;
        document.getElementById('div_cpuf').style.display=value;
    }else{
        document.getElementById('extra').style.display='none';
    }
    
}

function updateSubCategoria(miXml){
                var cate = miXml.getElementsByTagName("categoria")[0];
		var subcate = cate.getElementsByTagName("subcategoria");
		document.forms[0].cmbSubCategoria.length = subcate.length+1;
		               
		for (var i=0;i<subcate.length;i++){
                        var item = subcate[i];
                        var myString = item.firstChild.nodeValue;
                        var trozo = myString.split(";");
                        var index = i+1;
                        document.forms[0].cmbSubCategoria.options[index].value = trozo[0];
                        document.forms[0].cmbSubCategoria.options[index].text = trozo[1];
                      
                    if(document.forms[0].bflagconditionrule.value=="true"){
                        if($.trim(document.getElementById("beannpconditionrule.npvalue3").value=="0")){                            
                            var cmbValueCategoria=document.forms[0].cmbSubCategoria.options[index].value;
                            var idSubcategoria = cmbValueCategoria.split("|");
                            /*Apolarc se comento codigo
                            if($.trim(idSubcategoria[1])==$.trim(document.getElementById("beannpconditionrule.npvalue5").value)){
                                document.forms[0].cmbSubCategoria.selectedIndex=index;
                            }
                            fin Apolarc
                            */
                            /*APOLARC*/
                            if(salesrule.subCategory.selected){
                                if($.trim(idSubcategoria[0]) == salesrule.subCategory.selected ){
                                    document.forms[0].cmbSubCategoria.selectedIndex=index;   
                                    if(salesrule.subCategory.enable == "0"){
                                        document.forms[0].cmbSubCategoria.disabled = true;
                        }
                    }   
		}
                            /*APOLARC*/
                        }
                    }   
		}
	
        var equifaxResult = "<%=(String)request.getSession().getAttribute("equifaxResult")%>";
        var flagSubCategoria = "<%=request.getAttribute("statusCmbSubCategoria")%>";
        document.forms[0].evaluationEquifax.value="<%=(String)request.getSession().getAttribute("equifaxResult")%>";
        //FBERNALES - 04/09/2014 - COMPROBAMOS SI EL FLAG_CREDITOS_DESAPROBADO  
        //if(equifaxResult!=null && (equifaxResult=='DESAPROBADO')){        
        var lFlagCreditosDesaprobado = "<%=(String)request.getSession().getAttribute("lFlagCreditosDesaprobado")%>";
        
        if(document.forms[0].bflagconditionrule.value=="true" && (equifaxResult!=null && equifaxResult!="null")){
            //cargarSolucion();
                if (flagSubCategoria=="true"){
                        $("#cmbSubCategoria").trigger("change");
                        //cargarSolucion();
                    }
                
                //cargarSolucion();
        } else {        
            if(equifaxResult!="null" && equifaxResult!=null && equifaxResult=='DESAPROBADO'){
                if (document.forms[0].cmbCategoria.value=="3"){
                    if  (lFlagCreditosDesaprobado!=null && lFlagCreditosDesaprobado=="0"){            
                         document.forms[0].cmbSubCategoria.remove(2);
                         document.forms[0].cmbSubCategoria.selectedIndex = 1;
                         //cargarSolucion();
                     }
                }else if(document.forms[0].cmbCategoria.value=="1"){
                         document.forms[0].cmbSubCategoria.remove(2);
                         document.forms[0].cmbSubCategoria.selectedIndex = 1;
                         //cargarSolucion();
                }
             
            }
        }
        
        //JROQUE 05/04/2016 PROYECTO DE PRE EVALUACION(REQ-0363)
        var bflagSubCategoryFromPreeval = document.forms[0].flagOrdenPrepago.value;
        var stxtSubCategoryFromPreeval  = document.forms[0].txtSubCategoryFromPreeval.value.split("|");
       
         if (bflagSubCategoryFromPreeval=="true"){
       
            var lista = document.getElementById("cmbSubCategoria");
            for (j=0;j<stxtSubCategoryFromPreeval.length;j++){
                for (i = 0; i < lista.length; i++) {
                    var sOptionSubCategory=lista.options[i].value.split("|");
                        if (sOptionSubCategory[1] == stxtSubCategoryFromPreeval[j]) {
                        
                            document.forms[0].cmbSubCategoria.disabled = true;                        
                            document.forms[0].cmbSubCategoria.selectedIndex = i;
                        }
                }
            }
        }
           
       
        /*APOLARC*/
        if (document.forms[0].cmbSubCategoria.value.toString() != "0") {
            cargarSolucion();
            /*AMATEO REQ-0007*/
            getStatusViewOrdersPrevious();
            /*FIN AMATEO REQ-0007*/
}
        /*FIN APOLARC */
        
        
}

function cargarSolucion()
{
    /*APOLARC CLEAN COMBOS */
       cleanCombos(2);
    /*FIN APOLARC */

    document.forms[0].cmbSoluction.selectedIndex = 0;
    document.forms[0].cmbLineaProducto.selectedIndex = 0;
    var subCategoria = document.forms[0].cmbSubCategoria.value;
    
    
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateSolucion);
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=cargarSolucion&cmbSubCategoria=" + subCategoria,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
    
    if(document.forms[0].cmbSubCategoria.value.toString() != "0"){
        getStatusViewOrdersPrevious();
}
}

function updateSolucion(miXml){
                var subCate = miXml.getElementsByTagName("subcategoria")[0];
		var sol = subCate.getElementsByTagName("solucion");
		document.forms[0].cmbSoluction.length = sol.length+1;
		               
		for (var i=0;i<sol.length;i++){
                        var item = sol[i];
                        var myString = item.firstChild.nodeValue;
                        var trozo = myString.split(";");
                        document.forms[0].cmbSoluction.options[i+1].value = trozo[0];
                        document.forms[0].cmbSoluction.options[i+1].text = trozo[1];
		}
	
	}

function cargarLineaProducto()
{
    /*APOLARC CLEAN COMBOS */
       cleanCombos(1);
    /*FIN APOLARC*/
    document.forms[0].cmbLineaProducto.selectedIndex = 0;
    var cmbSoluction = document.forms[0].cmbSoluction.value;
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateLineaProducto);
    req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=cargarLineaProducto&cmbSoluction=" + cmbSoluction,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
}

function updateLineaProducto(miXml){
                var solu = miXml.getElementsByTagName("solucion2")[0];
		var linea = solu.getElementsByTagName("linea");
		document.forms[0].cmbLineaProducto.length = linea.length+1;
		               
		for (var i=0;i<linea.length;i++){
                        var item = linea[i];
                        var myString = item.firstChild.nodeValue;
                        var trozo = myString.split(";");
                        document.forms[0].cmbLineaProducto.options[i+1].value = trozo[0];
                        document.forms[0].cmbLineaProducto.options[i+1].text = trozo[1];
		}
	
	}


/* Ya no se usa
function cargarTipo()
{
    document.forms[0].cmbTipo.selectedIndex = 0;
    var solucion = document.forms[0].cmbSoluction.value;
                
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateTipo);
    req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=cargarTipo&cmbSoluction=" + solucion,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
   
}

function updateTipo(miXml){
                var sol = miXml.getElementsByTagName("sol")[0];
		var tipos = sol.getElementsByTagName("tipo");
		document.forms[0].cmbTipo.length = tipos.length+1;
		               
		for (var i=0;i<tipos.length;i++){
                        var item = tipos[i];
                        var myString = item.firstChild.nodeValue;
                        var trozo = myString.split(";");
                        document.forms[0].cmbTipo.options[i+1].value = trozo[0];
                        document.forms[0].cmbTipo.options[i+1].text = trozo[1];
		}
	
	}*/
        
 /*-RPASCACIO 23-07-2014 Creación Pop-pup Verificación Cliente--------------------------------------------*/
 
     $(document).ready(function()
        {
	//Mostrar ventana Modal cuando se hace clic en Iniciar
	/*$(".login_link").click(
            function() {
            var indice=$(".login_link").index(this);
            var checks = document.getElementsByName('checkbox'); 
            checks[indice].checked = true ;
              if(SeleccionarProductoPorta(true)){
            // alert($.get( $(this).attr('value')));
             document.getElementById('txtnumeroPortabilidad').value="";    
             var txtTelefonoAPortar = document.getElementById('txtnumeroPortabilidad').value ; 
           //  document.getElementById('cmbCedente').value="";    
                var cmbCedente = document.getElementById('txtcedente').value ; 
                var cmbOrigen = document.getElementById('txtoperadora').value ;
                 var frm = document.forms[0];
                 frm.indice.value =  indice;
                //("cedentePortability")[indice].value;
                 var imei = document.getElementsByName('txtIMEIArray[]')[indice].value
          //   request.getSession().setAttribute("listaModelo",orderForm.getLstModel());   
                 
          //  <%=request.getSession().getAttribute("statusSeccionDigitalizacion")%>
            //    alert(imei);
             var req = newXMLHttpRequest();          
              req.onreadystatechange = getReadyStateHandler(req,updatePorta);
                        req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=PortabilidadAnt&imei=" + imei+"&txtnumeroPortabilidad="+txtTelefonoAPortar+"&cmbCedente="+cmbCedente+"&cmbOrigen="+cmbOrigen,true);
                        req.setRequestHeader("Content-Type","application/ISO-8859-1");
                        req.send(null);
           
                document.getElementById("hddIndicePortability").value=indice;
                $('#login_form').modal();             
                }
            }
         );*/
             
      	$(".popup_view").click(
            function() {
                 var indice=$(".popup_view").index(this);
                 var imei = document.getElementsByName('txtIMEIArrayFinal[]')[indice].value
                 
                        var req = newXMLHttpRequest();          
                        req.onreadystatechange = getReadyStateHandler(req,ViewPorta);
                        req.open("GET","<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=PortabilidadView&imei=" + imei,true);
                        req.setRequestHeader("Content-Type","application/ISO-8859-1");
                        req.send(null);  
                 
                $('#popup_view_form').modal();             
                }
         );                 
}); 
        
        
function newXMLHttpRequest(){
		var xmlreq = false;
		if (window.XMLHttpRequest){
			xmlreq = new XMLHttpRequest();
		}else if (window.ActiveXObject){
			try{
				xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e1){
				try{

					xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
				}catch(e2){
					xmlreq = false;
				}
			}
		}

		return xmlreq;

	}
        
       

	

	function getReadyStateHandler(req, responseXmlHandler){
		return function(){
			if (req.readyState == 4){
				if (req.status == 200){
					responseXmlHandler(req.responseXML);
				}else{
					alert("HTTP error " + req.status + ":" + req.statusText);
				}
			}
		}
	}

 /*APOLARC FUNCTION CLEAN COMBOS SOLUTION Y PRODUCTO */
 function cleanCombos(n){
    var opt = '<option value="0">--Seleccionar--<//option>';
    if(n == 4 ) {
     $("#cmbCategoria").html(opt);
   }
    if(n == 3 || n == 4){
      $("#cmbSubCategoria").html(opt);
    }
    if(n == 2 || n == 3 || n == 4){
      $("#cmbSoluction").html(opt);
    }
    if(n == 1 || n == 2 || n == 3 || n == 4){
     $("#cmbLineaProducto").html(opt);
    }
 }
 /*FIN APOLARC*/ 
/*NORMALIZACION DE DIRECIONES*/
 function normalizacionOK(){
 }
 
 function mostrarNormalizacionDirecciones(){
    var numdoc = document.getElementById('txtCustomerDocumentNumber').value;
    var tipodoc = document.getElementById('txtCustomerDocumentType').value;
    var numorder = document.getElementById('hidOrderIdToDelete').value;
	var promoter = document.getElementById('cmbPromoter').value;
   
    var arrayOriginal = [];

      if(document.getElementsByName('txtNameSubcategorias[]').length>0){
        var totalElementosKit = document.getElementsByName('txtNameSubcategorias[]').length;
            var indice = 0;
            for(var i=0; i < totalElementosKit; i++){
                    var imei = 	document.getElementsByName('txtNameSubcategorias[]')[i].value;
                    arrayOriginal[indice] = imei;
                    indice++;
            }
      }
    
    var preIden = "Prepago";
    var posIden = "Postpago";
    var postIden = "PostPago";
    var totalPre = 0;
    var totalPos = 0;
        for(var i=0; i < arrayOriginal.length; i++){
           if(arrayOriginal[i].indexOf(preIden) > -1){
               totalPre++;
           }
           
           if(arrayOriginal[i].indexOf(posIden) > -1 || arrayOriginal[i].indexOf(postIden) > -1){
               totalPos++;
           }                   
        }
        
        var params;
        if(totalPos>0){
            params = document.getElementById('cmbDivision').value + '|' + document.getElementById('cmbCategoria').value + '|' + '2';
        } else{
            params = document.getElementById('cmbDivision').value + '|' + document.getElementById('cmbCategoria').value + '|' + '1';
        }

    //var params = document.getElementById('cmbDivision').value + '|' + document.getElementById('cmbCategoria').value + '|' + (document.getElementById('cmbSubCategoria').value).split("|")[0];

    cargarPopupNormalizacion(tipodoc,numdoc,numorder,params,promoter);
}
 
 //AGN
 function verDocumentosAGenerar(){
    window.open('OrderActionMultiple.do?metodo=verDocumentos','popupDetalle','width=500,height=300,scrollbars=yes,resizable=yes,modal=yes');

 }
 
 
 
 //END AGN
 

 function errorNormalizacion(){
 }
 

 /*NORMALIZACION DE DIRECIONES FIN*/
 
 /*AMATEO REQ-0007*/
 function viewPopupOrdenesPrevias(){
    var url = '<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=viewWindowPOrders';   
    var num = document.getElementById("numPreviousOrders").value;

    if (num > 0){
        window.open(url,"","toolbar=no,location=no,directories=no,status=no,menubar=0,scrollbars=yes,resizable=no,screenX=100,top=80,left=100,screenY=80,width=750,height=300,modal=yes");
    }else{
        alert("No existen ordenes previas para este cliente");
    }
 }
 
 
 function getStatusViewOrdersPrevious(){

    var divisionid = document.forms[0].cmbDivision.value;
    var categoriaid = document.forms[0].cmbCategoria.value;
    var subcategoriaid = document.forms[0].cmbSubCategoria.value;
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateStatusPOrders);
    req.open("GET",'<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=getStatusPreviousOrder&division='+divisionid+'&categoria='+categoriaid+'&subcategoria='+subcategoriaid,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
 }
 
 function updateStatusPOrders(data){
	  var subcategoriaid = document.forms[0].cmbSubCategoria.value;
      var temp = data.getElementsByTagName("statusViewPreviousOrders")[0];
      var temp2 = temp.getElementsByTagName("data")[0];
      var resultado =	temp2.firstChild.nodeValue;
      	 if (subcategoriaid == resultado && subcategoriaid != 0){
            document.getElementById('div_ordenes_previas').style.display='block';
            getListPreviousOrders();
        }else{
            document.getElementById('div_ordenes_previas').style.display='none';
        }		      
 }
 
 function noneViewPreviousOrder(){
    var sel = document.getElementById('cmbDivision');
    var opt = sel.options[sel.selectedIndex];
    
    var docu = document.getElementById('cmbTipoDocumentacion');
    var opt2 = docu.options[docu.selectedIndex];
    var flagTipoDocuemto = "<%=request.getAttribute("status_ce")%>";
    if(flagTipoDocuemto!==true && flagTipoDocuemto!=="true"){
        if(opt.text.indexOf("Fija")!=-1 || opt.text.indexOf("Fijo")!=-1) {
            document.getElementById('divTipoDocumentacion').style.display='none';
            document.getElementById('divValTipoDocumentacion').style.display='none';
            document.getElementById('divEmail').style.display='none';
            document.getElementById('divTxtEmail').style.display='none';
            document.getElementById('divMotivo').style.display='none';
            document.getElementById('divTxtMotivo').style.display='none';
            document.getElementById('div_cpuf').style.display='none';
            document.getElementById('extra').style.display='';
            $("#txtOrderNumber").attr("disabled",false);
            $("#txtOrderNumberPostpago").attr("disabled",false);
            //pry 02082016
            document.forms[0].cmbTipoDocumentacion.selectedIndex = 1;
    
        }else{
           document.getElementById('divTipoDocumentacion').style.display='';
            document.getElementById('divValTipoDocumentacion').style.display='';
            document.getElementById('extra').style.display='none';
    
            if(opt2.text === "Manual"){
                document.getElementById('div_cpuf').style.display='none'; 
                document.getElementById('divEmail').style.display='none';
                document.getElementById('divTxtEmail').style.display='none';
                document.getElementById('divMotivo').style.display='';
                document.getElementById('divTxtMotivo').style.display='';
            }else{
                document.getElementById('div_cpuf').style.display=''; 
                document.getElementById('divEmail').style.display='';
                document.getElementById('divTxtEmail').style.display='';
                document.getElementById('divEmail').style.display='';
                document.getElementById('divMotivo').style.display='none';
                document.getElementById('divTxtMotivo').style.display='none';
                $("#txtOrderNumber").attr("disabled",true);
                $("#txtOrderNumberPostpago").attr("disabled",true);
            }
    
        }
    }//Proy 0275 Obs: 6254 VFCONS - INICIO
    else{
        document.getElementById('divTipoDocumentacion').style.display='none';
        document.getElementById('divValTipoDocumentacion').style.display='none';
        document.getElementById('divEmail').style.display='none';
        document.getElementById('divTxtEmail').style.display='none';
        document.getElementById('divMotivo').style.display='none';
        document.getElementById('divTxtMotivo').style.display='none';
        document.getElementById('div_cpuf').style.display='none';
        document.getElementById('extra').style.display='';
    }
            
    if(document.forms[0].cmbDivision.value == "0"){
        document.getElementById('divTipoDocumentacion').style.display='none';
        document.getElementById('divValTipoDocumentacion').style.display='none';
        document.getElementById('divEmail').style.display='none';
        document.getElementById('divTxtEmail').style.display='none';
        document.getElementById('divMotivo').style.display='none';
        document.getElementById('divTxtMotivo').style.display='none';
        document.getElementById('div_cpuf').style.display='none';
        document.getElementById('extra').style.display='';
    }
    //Proy 0275 Obs: 6254 VFCONS - FIN
 }
 
 function getListPreviousOrders(){
    var customerretailid = '<%= request.getSession().getAttribute("idCustomerRetail").toString() %>';
    var divisionid = document.forms[0].cmbDivision.value;
    var categoriaid = document.forms[0].cmbCategoria.value;
    var subcategoriaid = document.forms[0].cmbSubCategoria.value;
 
    var req = newXMLHttpRequest();          
    req.onreadystatechange = getReadyStateHandler(req,updateListPOrders);
    req.open("GET",'<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=listPreviousOrders&customer='+customerretailid+'&division=' + divisionid+'&categoria='+categoriaid+'&subcategoria='+subcategoriaid,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
 }
 
 function updateListPOrders(data){
    var temp = data.getElementsByTagName("listPreviousOrders")[0];
    var temp2 = temp.getElementsByTagName("length")[0];
    var resultado = temp2.firstChild.nodeValue;
    
    document.getElementById("numPreviousOrders").value = resultado;
    document.getElementById("link_Previous_Orders").innerHTML = 'Ver Solicitudes ('+resultado+')';
 }
 /*FIN AMATEO REQ-0007*/
 
 
  function ActualizarNoTotalAPagar(){                      
            var costoOrden= document.forms[0].txtTotalCostOrder.value;

            document.forms[0].txtTotalCost.value = costoOrden; 
            document.forms[0].radioAnticipado.value="NO";
            document.getElementById('txtPagoAnticipadoTotal').value="0.0";
            
  }
 
  function ActualizarSiTotalAPagar(){
            var montoAnticipado= document.forms[0].txtTotalCostAnticipado.value;                        
            var costoOrden= document.forms[0].txtTotalCostOrder.value;
            
            totalpagar=parseFloat(costoOrden)+parseFloat(montoAnticipado);     
            document.forms[0].txtTotalCost.value = parseFloat(totalpagar).toFixed(1);    
            document.forms[0].radioAnticipado.value="SI";  
            document.getElementById('txtPagoAnticipadoTotal').value=montoAnticipado;
  }
  
  
  
  
  
 
</script>


<html:form action="/OrderActionMultiple.do" method="post">
<html:hidden property="metodo" />
<html:hidden property="idItem" />
<input type="hidden" name="specialprice" />
<input type="hidden" name="deposite" />
<input type="hidden" name="tipoMovimiento" />
<input type="hidden" name="popupcancel" />
<input type="hidden" name="messagebody" />
<input type="hidden" name="userLogin" value='<bean:write name="CodePromoter" scope="session" />'/>
<input type="hidden" id="numPreviousOrders" name="numPreviousOrders"/>
<html:hidden property="validationTimeLimit" />
<html:hidden property="messageBody" />
<html:hidden property="hidOrderId" />
<html:hidden property="hidOrderIdToDelete" styleId="hidOrderIdToDelete"/>
<html:hidden property="costoTotalPlan" />
<html:hidden property="resultadoReniec" />
<html:hidden property="evaluationEquifax" />
<html:hidden property="txtCustomerType" />
<html:hidden property="stypeoperation" />
<html:hidden property="stypecustomer" />
<html:hidden property="bflagconditionrule" />
<html:hidden property="flagOrdenPrepago" />
<html:hidden property="txtSubCategoryFromPreeval" />
<html:hidden property="idOrderManual" />
<html:hidden property="multipleOrderIdManual" />
<html:hidden property="multipleManual" />
<html:hidden property="errorNoBio" />
<html:hidden property="initOrder" />
<html:hidden property="txtTotalCostOrder" />
<html:hidden property="radioAnticipado" />
<html:hidden property="txtTotalCostAnticipado" />


<logic:equal name="OrderForm" property="bflagconditionrule" value="true" >
    <bean:define id="ConditionRule" name="OrderForm" property="beannpconditionrule" />
    <html:hidden property="beannpconditionrule.npvalue1" styleId="beannpconditionrule.npvalue1" />
    <html:hidden property="beannpconditionrule.npvalue2" styleId="beannpconditionrule.npvalue2" />
    <html:hidden property="beannpconditionrule.npvalue3" styleId="beannpconditionrule.npvalue3" />
    <html:hidden property="beannpconditionrule.npvalue4" styleId="beannpconditionrule.npvalue4" />
    <html:hidden property="beannpconditionrule.npvalue5" styleId="beannpconditionrule.npvalue5" />
    <html:hidden property="beannpconditionrule.npvalue6" styleId="beannpconditionrule.npvalue6" />    
</logic:equal>
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
      <td height="22" colspan="4" class="PortletHeaderColor"><div class="PortletHeaderText">&nbsp;&nbsp;Orden de Venta</div></td>
    </tr>
    <tr class="ListRow1">
      <td colspan="4" class="PortletText1">Informaci&oacute;n de la Orden</td>
    </tr>
 </table>
 <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="13%" class="LeftSubTab">
      <logic:equal value="1" property="opcion" name="OrderForm"> 
      <a href="javascript:buscarCliente();"><strong>Raz&oacute;n Social / Nombre </strong></a>
      </logic:equal> 
      <logic:equal value="2" property="opcion" name="OrderForm">
      <strong>Raz&oacute;n Social / Nombre </strong>
      </logic:equal>
      </td>
      <td width="18%"><html:text property="txtCustomerFullName" readonly="true" maxlength="100" size="30"/></td>
      <td width="12%" class="LeftSubTab"><strong>Tipo de Documento</strong></td>
      <td width="17%"><html:text property="txtCustomerDocumentType" styleId="txtCustomerDocumentType" readonly="true" size="10" maxlength="60"/></td>
      <td width="13%" class="LeftSubTab"><strong>Nro. Documento</strong></td>
      <td width="31%"><html:text property="txtCustomerDocumentNumber" styleId="txtCustomerDocumentNumber" readonly="true" maxlength="20" size="30"/></td>
    </tr>
  </table>
  
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="13%" class="LeftSubTab"><strong>Cadena</strong></td>
      <td width="18%"><html:text property="txtRetailer" readonly="true" size="30" maxlength="100"/></td>
      <td width="12%" class="LeftSubTab"><strong>Sucursal</strong></td>
      <td width="17%"><html:text property="txtStore" readonly="true" size="20" maxlength="100"/></td>
      <td width="13%" class="LeftSubTab"><strong>Punto de Venta </strong></td>
      <td width="31%"><html:text property="txtPOS" readonly="true" size="20" maxlength="100"/></td>
    </tr>
  </table>
  
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="13%" class="LeftSubTab"><strong>Promotor</strong></td>
      <td width="18%">
      <bean:define id="promotor" name="OrderForm" property="lstPromoter"/>
      <html:select property="cmbPromoter" styleId="cmbPromoter" disabled="${statusCmbPromoter}">
      <html:optionsCollection name="promotor" value="nppromoterid" label="nppromotercode" />
      </html:select>
      </td>
     <logic:equal value="0" property="estadoAprobado" name="OrderForm"> 
        <td width="69%"></td>        
     </logic:equal>
     <logic:equal value="1" property="estadoAprobado" name="OrderForm">
        <td width="33%" class="LeftSubTab"><strong>Est. Evaluación Crediticia</strong></td>
        <td width="36%"><html:text property="txtEvaluation" disabled="true" size="15"/></td>
     </logic:equal>
     <!-- Apolarc se cambio de posicion Proyecto Telefonia Fija
      
       -->     
    </tr>
  </table>
  
  <% Boolean b = (Boolean) request.getSession().getAttribute("disabledNumbers"); %>
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="13%" class="LeftSubTab"><strong>Nro.Solicitud Prepago</strong></td>
      <td width="18%"><html:text property="txtOrderNumber" disabled="<%=b%>" styleId="txtOrderNumber" maxlength="14" size="30"   onkeypress="alfanumerico2(this);"/></td>
    <td width="12%" class="LeftSubTab"><strong>División</strong></td>
      <td width="17%">
      <bean:define id="division" name="OrderForm" property="lstDivision"/>
      <html:select property="cmbDivision"  styleId="cmbDivision" disabled="${statusCmbDivision}" onchange="javascript:noneViewPreviousOrder();">
      <option value="0" >--Seleccionar--</option>
      <html:optionsCollection name="division" value="npdivisionid" label="npdivisionname" />
      </html:select>
      </td>
      <td width="13%" class="LeftSubTab"><strong>Categoría</strong></td>
      <td width="31%">
      <html:select property="cmbCategoria" onchange="javascript:cargarSubCategoria();" styleId="cmbCategoria" disabled="${statusCmbCategoria}">
      <option value="0" >--Seleccionar--</option>
      <html:options collection="listaCategoria" property="npcategoryid" labelProperty="npcategoryname" />
      </html:select>
      </td>
    </tr>
  </table>
  
  <% Boolean c = (Boolean) request.getSession().getAttribute("disabledNumbers"); %>

  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="13%" class="LeftSubTab"><strong>Nro.Solicitud Postpago</strong> </td>
      <td width="18%"><html:text property="txtOrderNumberPostpago" disabled="<%=c%>" styleId="txtOrderNumberPostpago" maxlength="100" size="30" /></td>
      <td width=69% id="extra" style="${statussddextra}"> &nbsp; </td>
      <td width="12%" class="LeftSubTab" id="divTipoDocumentacion" style="${statussdd}"><strong>Tipo Documentación</strong></td>
      <td width="17%" id="divValTipoDocumentacion" style="${statussdd}"> 
           <bean:define id="tipoDocumentacion" name="OrderForm" property="lstTipoDoc"/>
      <html:select property="cmbTipoDocumentacion" disabled="${statusManual}" styleId="cmbTipoDocumentacion"  onchange="javascript:cargarTipoDocumentacion();">
      
      <html:optionsCollection name="tipoDocumentacion" value="npparameterid" label="npparametervalue1" />
      </html:select>
      </td>
      <td width="13%" class="LeftSubTab" id="divEmail" style="<%=request.getSession().getAttribute("automatica")%>"><strong>Email</strong></td>
      <td width="31%" id="divTxtEmail" style="<%=request.getSession().getAttribute("automatica")%>"><html:text property="txtCustomerEmail" styleId="txtCustomerEmail" maxlength="50" size="30"/></td>
    
      <td width="13%" class="LeftSubTab" id="divMotivo" style="<%=request.getSession().getAttribute("manual")%>"><strong>Motivo</strong></td>
      <td width="31%" id="divTxtMotivo" style="<%=request.getSession().getAttribute("manual")%>">
          <bean:define id="tipoMotivo" name="OrderForm" property="lstMotivos"/>
          <html:select property="cmbMotivo"  styleId="cmbMotivo" disabled="${statusManual}">
          <option value="0" >--Seleccionar--</option>
          <html:optionsCollection name="tipoMotivo" value="npparameterid" label="npparametervalue1" />
          </html:select>      
      </td>

    </tr>
    
  </table>
  
  <div id="div_cpuf">

  <table width="100%"  border="0">
    
    <tr class="ListRow1">
    <td id="td_cpuf" style="<%=request.getSession().getAttribute("automatica")%>">
            <html:radio property="isHome" value="NT"/> 
                    <label>No tengo CPUF</label>        
                    <br>
                    <html:radio property="isHome" value="NC"/> 
                    <label>No conozco CPUF</label> 
                    <br>
           <input type="button" value="Ingresar CPUF" style="width:100px" onClick="javascript:IngresarCPUF();" >

      </td>
      <td width="13%">&nbsp;</td>
      <td width="18%">&nbsp;</td>
      <td width="12%">&nbsp;</td>
      <td width="17%" id="documentosAGenerar" style="<%=request.getSession().getAttribute("statusDocumentos")%>">
         <a href="javascript:verDocumentosAGenerar();"><strong>Ver documentos a generar </strong></a>

      </td>
    </tr>
  </table>
  </div>
  
  <table width="100%"  border="0" style="display:none">
    <tr class="ListRow1">
      
      <td width="13%" class="LeftSubTab" ><strong>Sub Categoría</strong></td>
      <td width="31%">
      <html:select property="cmbSubCategoria" onchange="javascript:cargarSolucion();" styleId="cmbSubCategoria" disabled="${statusCmbSubCategoria}">
      <option value="0" >--Seleccionar--</option>
      <html:options collection="listaSubCategoria" property="idcompleto" labelProperty="npsubcategoryname" />
      </html:select>
      </td>
    </tr>
  </table>
  <table width="100%"  border="0">
  <tr class="ListRow1">
      <td width="13%" class="LeftSubTab" style="display:none"><strong>Soluci&oacute;n</strong></td>
      <td width="18%" style="display:none">
      <html:select property="cmbSoluction" onchange="javascript:cargarLineaProducto();" styleId="cmbSoluction" disabled="${statusCmbSolucion}">
      <option value="0" >--Seleccionar--</option>
      <html:options collection="listaSolucion" property="npidcompleto" labelProperty="npsolutionname"/>
      </html:select>
      </td>  
      <td width="12%" class="LeftSubTab" style="display:none"><strong>Línea de Producto</strong>
                      </td>
      <td width="17%" style="display:none">
      <html:select property="cmbLineaProducto" styleId="cmbLineaProducto" disabled="${statusCmbLineaProducto}">
      <option value="0" >--Seleccionar--</option>
      <html:options collection="listaLineaProducto" property="idCompleto" labelProperty="productLineaName"/>
      </html:select>
      </td>      
      <!--Apolarc Cambio de posicion Proyecto Telefonia Fija-->
      
      <td width="70%">
      <table width="100%"  border="0">
      <tr class="ListRow1">	  
	  
	  <td width="32%" class="LeftSubTab hide" id="labelTxtCentroCosto"><strong>Centro de Costo</strong></td>
      <td width="68%" class="hide" id="wrapperCentroCosto">
        <html:select property="cmbSite"  styleId="cmbSite">
           </html:select>
      </td>
	  
	  </tr>  
      </table>
      </td>
      
      <!--Fin Apolarc -->
    </tr>
    
    </table>
    <!-- AMATEO -->
    <div id="div_ordenes_previas" style="display:none;">
    <table width="100%"  border="0">
            <tr class="ListRow1">
            <td width="100%" align="right">
                <html:link href="javascript:viewPopupOrdenesPrevias();">
                <h4 id="link_Previous_Orders"></h4>
                </html:link>
            </td>
        </tr>
    </table>
    </div>
    <!-- FIN AMATEO -->
    
    <table width="100%"  border="0">
    <tr class="ListRow1">
      <td colspan="8"><span class="PortletText1">Detalle de Orden</span></td>
    </tr>
    <tr class="ListRow1">
    <td height="30" colspan="8">
      <!-- PPNN: Se muestra boton Agregar Detalle-->
      <div id="ocultar_botonDetalle" style="<%=request.getAttribute("statusAgregarDetalle")%>">
      
      <input type="button" value="Agregar Detalle" id="btnOpenAddItem" style="width:100px" onClick="javascript:AgregarDetalleOrden(document.forms[0].cmbSoluction.value,document.forms[0].cmbLineaProducto.value);" >
      <!-- PPNN: Se oculta boton el ValidarCliente   -->   
      </div>
      
      </td>
    </tr>
        
    <!-- @RQuispe  -->
    
    <tr id="trAnticipado"  style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" class="ListRow1">
      <td width="20%" style="font-size:9px" class="LeftSubTab"><strong>Calcular Pago Acticipado</strong></td>      
      <td width="10%" style="font-size:8px ; border:1px solid #FF6702">
        <html:radio property="pagoAnticipado" value="SI" onclick="ActualizarSiTotalAPagar()"  />SI 
            <html:radio property="pagoAnticipado" value="NO"  onclick="ActualizarNoTotalAPagar()" />NO
      </td>      
      <td width="10%"></td>
      <td width="10%"></td>
      <td width="20%" style="font-size:9px" class="LeftSubTab"><strong>Monto Total Anticipado:</strong></td>
      <td width="10%"><input type="text"  disabled="true"  size="10" id="txtPagoAnticipadoTotal" value="<bean:write name="OrderForm" property="txtTotalCostAnticipado" />" /></td>
      <td width="10%"></td>
      <td width="10%"></td>
    </tr>
    
        
  </table>
  <!--EQUIPOS -->
   
    <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="4%" class="LeftSubTab"><div align="center"><strong>Eliminar</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>SubCategoria</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>Solución</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>Línea de Producto</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>Promoci&oacute;n</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>Precio</strong></div></td>
      <td width="10%" class="LeftSubTab"><div align="center"><strong>Plan</strong></div></td>
      
      
      <td width="8%"  class="LeftSubTab" id="tdskuAnticipado"  style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" ><div align="center"><strong>SKU  <br/>  Pago <br/> Anticipado</strong></div></td>
      <td width="11%" class="LeftSubTab" id="tdPagoAnticipado"  style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>" ><div align="center"><strong>Pago <br/> Anticipado</strong></div></td>        
      
      
      <td width="10%" class="LeftSubTab"><div align="center"><strong>Modelo</strong></div></td>
      <td width="10%" class="LeftSubTab"><div align="center"><strong>IMEI</strong></div></td>
      <td width="10%" class="LeftSubTab"><div align="center"><strong>SIM</strong></div></td>
      <td width="14%" class="LeftSubTab" id="tdregion" style="display:none;background-color:#B4B3B2;"><div align="center"><strong>Regi&oacute;n</strong></div></td>
      
	  </tr>
  </table>
  <logic:notEmpty name="OrderForm" property="listaOrdenes">
      <%
       java.lang.String productoAnterior = "ninguna";
       
      %>
      <div id="capa" style="width:100%; height:100px; z-index:1 ;overflow:auto" class="ListRow1" >    
      <logic:iterate id="detailFinal" property="listaOrdenes" name="OrderForm" indexId="indice2">
      <bean:define id="idItem" name="detailFinal" property="idItem"/>
      <div id="div_product_<%=idItem%>">
      <table width="100%" border="0" cellpadding="0">
      <TR>
      <%
         if(!idItem.toString().equals(productoAnterior)){%>
      <td width="4%" class="ListRow1"><div align="center" id="ocultar_imagen" style="<%=request.getAttribute("statusAgregarDetalle")%>"><input name='txtIdKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="idKit"/>"><a href='javascript:eliminarDetalleFinal(<%=idItem%>);'><img src='images/Eliminar.gif' width='16' height='15' title='Eliminar' border='0'></a></div></td>
      <td width="7%" class="ListRow1"><div align="center"><input name='txtNameKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="subcategoria"/>"><bean:write name="detailFinal" property="subcategoria"/></div></td>
      <td width="0%" class="ListRow1" style="display:none"><input name='txtNameSubcategorias[]' type='hidden' value="<bean:write name="detailFinal" property="subcategoria"/>"><bean:write name="detailFinal" property="subcategoria"/></td>

      <td width="7%" class="ListRow1"><div align="center"><input name='txtNameKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="solucion"/>"><bean:write name="detailFinal" property="solucion"/></div></td>
      <td width="7%" class="ListRow1"><div align="center"><input name='txtNameKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="lineaProducto"/>"><bean:write name="detailFinal" property="lineaProducto"/></div></td>

      <td width="7%" class="ListRow1"><div align="center"><input name='txtNameKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="nameKit"/>"><bean:write name="detailFinal" property="nameKit"/></div></td>
      <td width="7%" class="ListRow1"><div align="center"><input name='txtSkuKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="skuKit"/>"><bean:write name="detailFinal" property="skuKit"/></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtCurrencyArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="currency"/>"></div></td>
      <td width="7%" class="ListRow1"><div align="right"><input name='txtCostKitArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="cost"/>"><bean:write name="detailFinal" property="cost"/></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtSolutionCodeFinal[]' type='hidden' value="<bean:write name="detailFinal" property="codeSolution"/>"></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtProductLineFinal[]' type='hidden' value="<bean:write name="detailFinal" property="productLineId"/>"></div></td>
      <%}else{%>
       <td width="7%" class="ListRow1"><div align="center"></div></td>
       <td width="16%" class="ListRow1"><div align="center"></div></td>
       <td width="14%" class="ListRow1"><div align="center"></div></td>
       <td width="10%" class="ListRow1"><div align="center"></div></td>
       <%}productoAnterior = idItem.toString();%>       
      <td width="0%" class="ListRow1"><div align="center"><input name='txtIdPlanArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="idPlan"/>"></div></td>
      <td width="10%" class="ListRow1"><div align="center"><input name='txtPlanNameArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="namePlan"/>"><bean:write name="detailFinal" property="namePlan"/></div></td>           
      <td width="7%" class="ListRow1"><div align="center"  style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>"><input name='txtSkuAnticipadoArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="skuAnticipado"/>"><bean:write name="detailFinal" property="skuAnticipado"/></div></td>
      <td width="7%" class="ListRow1"><div align="center" style="<%=request.getSession().getAttribute("flagTdMontoAnticipado")%>"><input name='txtMontoAnticipadoArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="montoAnticipado"/>"><bean:write name="detailFinal" property="montoAnticipado"/></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtEstadoAnticipadoArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="estadoAnticipado"/>"></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtMontoAnticipadoThinkisArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="montoAnticipadoThinkis"/>"></div></td>     
      <td width="0%" class="ListRow1"><div align="center"><input name='txtBillcycleOrigenArrayFinal[]' type='hidden'  value="<bean:write name="detailFinal"  property="cicloOrigen"/>"></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtBillcycleDestinoArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="cicloDestino"/>"></div></td>
      <td width="0%" class="ListRow1"><div align="center"><input name='txtDescripcionErrorArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="messageErrorThinkis"/>"></div></td>         
      <td width="0%" class="ListRow1"><div align="center"><input name='txtCustomerIDArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="idCustomer"/>"></div></td>       
      <td width="0%" class="ListRow1"><div align="center"><input name='txtIdProductArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="idProduct"/>"></div></td>
      <td width="10%" class="ListRow1"><div align="center"><input name='txtModelNameArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="nameModel"/>"><bean:write name="detailFinal" property="nameModel"/></div></td>
      <td width="10%" class="ListRow1"><div align="center"><input name='txtIMEIArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="imei"/>"/><bean:write name="detailFinal" property="imei"/></div></td>
      <td width="10%" class="ListRow1"><div align="center"><input name='txtSIMArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="sim"/>"/><bean:write name="detailFinal" property="sim"/></div></td>
      <td width="14%" class="ListRow1"><div align="center"><input name='txtNombresArrayFinal[]' type='hidden' value="<bean:write name="detailFinal" property="nombreRegionSeleccion"/>"><bean:write name="detailFinal" property="nombreRegionSeleccion"/></div></td>
     
     <%
     if(idSpecification_product_prePago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection") || idSpecification_product_postPago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection"))                  
     { %> 
       <td width="4%"  class="ListRow1"> <a id="idportabilidad" name="idportabilidad" data="<bean:write name="detailFinal" property="idKit"/>" class="popup_view" value="aaaa"  href="#" title="Iniciar Sesi&oacute;n">Portabilidad</a></td>
           <% } %>  
      </tr></table></div>
      </logic:iterate>
      </div>
      </logic:notEmpty>
  <table width="100%"  border="0">
    
    <tr class="ListRow1">
      <td width="8%" align="center" class="ListRow1">&nbsp;</td>
      <td width="18%" class="ListRow1"><div align="center"></div></td>
      <td width="15%" class="ListRow1"><div align="center"><strong>Total a Pagar:</strong></div></td>
      <td width="11%"><div align="right">
        <html:text property="txtTotalCost" disabled="true" size="10"/>
      </div></td>
      <td width="12%"><div align="center"></div></td>
      <td width="12%"><div align="center"></div></td>
      <td width="11%"><div align="center"></div></td>
      <td width="13%"><div align="center"></div></td>
      </tr>
    <tr class="ListRow1">
      <td colspan="8"> 
      </td>
      </tr>

  </table>    
  <table width="100%"  border="0">
    
    <tr class="ListRow1">
      <td width="37%" >&nbsp;</td>
      <!-- <logic:equal value="1" name="OrderForm" property="activarProcesar"> -->
      <td width="13%" class="ListRow1" align="center">
      <!-- PPNN -->
      <logic:notEmpty name="OrderForm" property="listaOrdenes">
      <div id="ocultar_Procesar" style="<%=(request.getAttribute("statusProcesar")!=null)?request.getAttribute("statusProcesar"):"display:inline"%>"> 
        <input type="button" value="Procesar" id="btnProcesar" style="width:80px" onclick="javascript:ProcesarOrden()">
      </div>
      </logic:notEmpty>
      <!-- -->
      </td>
      <!-- </logic:equal> -->
      
      <logic:equal value="1" name="OrderForm" property="activarImprimir">
      <td width="13%" class="ListRow1" align="center">
      <input type="button" id="btnImprimirVoucher" value="Imprimir" style="width:80px" onclick="javascript:ImprimirVoucher()">
      </td>
      </logic:equal> 
      
      
      <!--<td width="13%" align="center"><div align="center">
        <input type="button" value="Mostrar Ventana Bio" style="width:80px" onclick="javascript:mostrarValdiacionBiometrica()">
      </div></td>-->
      <td width="13%" align="center"><div align="center">
        <input type="button" value="Cerrar" style="width:80px" onclick="javascript:cerrar()">
      </div></td>
      <td width="37%"><div align="center"></div></td>
      </tr>
    <tr class="ListRow1">
      <td colspan="4">&nbsp;</td>
      </tr>
  </table>
</td>
    </tr>
    </table>
</td>
  </tr>
</table>
  <logic:notEmpty scope="request" name="AlertImeiRepetido">
  <script type="text/javascript">
    
  var imei='<%=request.getAttribute("IMEI").toString()%>';
  alert('Los Productos: '+imei+' ya fueron asignados a otro Producto de la grilla');
  </script>
  </logic:notEmpty>
  <logic:notEmpty scope="request" name="MostrarEvaluacionNoDisponible">
  <script type="text/javascript">
  alert('El servicio fallo intentar mas Tarde');
  </script>
  </logic:notEmpty>              
    <div id="popup_reniec_view" style="display:none; opacity: 0.8; height:350px;" class="popup_reniec_view-overlay" align="center" tabindex='-1'> 
        <div id="box" class="box">
            <div class="PortletHeaderColor" >
                <h1 align="center" class="PortletHeaderColorPopup">Verificaci&oacute;n de Datos del Cliente                 
               </h1> 
            </div>
            <%         
            //request.setAttribute("popupVerificacion","1");        
            java.lang.String smostrarPopupReniec = (String)request.getAttribute("popupVerificacion");
            com.nextel.aditional.OrdenResultReniecIdData respuestaNovatronicReniec= new com.nextel.aditional.OrdenResultReniecIdData();            
            //smostrarPopupReniec
            if(smostrarPopupReniec=="1"){
                respuestaNovatronicReniec = (com.nextel.aditional.OrdenResultReniecIdData)request.getAttribute("respuestaNovatronic");                             
            
            %>   
           <table width="100%">
            <tr>
                <td align="center" width="40%">
                    <div align="center">
                        <table  align="left">
                            <tr>
                                <td class="LeftSubTab">
                                    
                                        <img src="OrderActionMultiple.do?metodo=imageGetter&pTypeImg=foto" height="250" width="250">    
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    
                                        <img src="OrderActionMultiple.do?metodo=imageGetter&pTypeImg=firma" height="80" width="250">
                                    
                                </td>         
                            </tr>
                        </table>
                    </div>
                </td>
                <td align="left">
                    <table align="left" width="100%">  
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Número de DNI</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getNumeroDNI(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getNumeroDNI(),2)%>
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Apellido Paterno</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getApellidoPaterno(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getApellidoPaterno(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Apellido Materno</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                 <% if(!StringUtils.notNull(respuestaNovatronicReniec.getApellidoMaterno(),2).equalsIgnoreCase("null")){%>
                                     <%=StringUtils.notNull(respuestaNovatronicReniec.getApellidoMaterno(),2)%> 
                                <% } %>   
                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left">
                                    <strong>Nombres</strong>
                                </div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getNombres(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getNombres(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left">
                                    <strong>Nombre Del Padre</strong>
                                </div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getNombrePadre(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getNombrePadre(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left">
                                    <strong>Nombre De La Madre</strong>
                                </div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getNombreMadre(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getNombreMadre(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                           <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Fecha de Nacimiento</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getFechaNacimiento(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getFechaNacimiento(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="30%" class="LeftSubTab">
                                <div align="left"><strong>Sexo</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getSexoDescripcion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getSexoDescripcion(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Estado Civil</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getEstadoCivilDescripcion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getEstadoCivilDescripcion(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab"><div align="left">
                                <strong>Grado de Instruccion</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getGradoInstruccion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getGradoInstruccion(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Estatura</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getEstatura(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getEstatura(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="30%" class="LeftSubTab">
                                <div align="left"><strong>Departamento de Nacimiento</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getDepartamentoNacimiento(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getDepartamentoNacimiento(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Provincia de Nacimiento</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getProvinciaNacimiento(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getProvinciaNacimiento(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Distrito de Nacimiento</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getDistritoNacimiento(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getDistritoNacimiento(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab"><div align="left">
                                <!--strong>Fecha de Expedicion</strong></div-->
                                <strong>Fecha de Emisión</strong></div>
                            </td>
                            <td style="width:40%">
                            <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getFechaExpedicion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getFechaExpedicion(),2)%> 
                                <% } %>
                            
                            </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Departamento de Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getDepartamentoDomicilio(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getDepartamentoDomicilio(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="30%" class="LeftSubTab">
                                <div align="left"><strong>Provincia de Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getProvinciaDomicilio(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getProvinciaDomicilio(),2)%> 
                                <% } %>
                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Distrito de Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getDistritoDomicilio(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getDistritoDomicilio(),2)%> 
                                <% } %>
                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getDireccionDomicilio(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getDireccionDomicilio(),2)%> 
                                <% } %>
                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Restriccion</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getRestriccionesDesc(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getRestriccionesDesc(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <!--tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Caducidad</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicReniec.getCaducidadDescripcion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicReniec.getCaducidadDescripcion(),2)%> 
                                <% } %>
                                
                                </strong>
                            </td>
                        </tr-->                           
                    </table>
                </td>
            </tr>
            <tr class="ListRow1">
                <td  colspan="2" align="center">
                    <div id="divReniecButtons">
                        <table width="100%">
                            <tr align="center">
                                <td>
                                    <input type="button" value="Aceptar" style="width:80px" class="simplemodal-close" onclick="javascript:fBotonPopup('<%=respuestaNovatronicReniec.getIDOrden()%>','<%=respuestaNovatronicReniec.getFuenteReal()%>','A','#popup_reniec_view')">                                    
                                    <input type="button" value="Rechazar" style="width:80px" onclick="javascript:showonlyoneDiv('divMotivoRechazoReniec','mostrar','Reniec');" >
                                </td>
                            </tr>
                        </table>
                    </div>                    
                    <div class="newboxes" id="divMotivoRechazoReniec" style="display:none;">
                    <table width="100%">
                        <tr align="center">
                            <td>
                                <bean:define id="idmotivorechazoreniec" name="OrderForm" property="lstMotivoRechazo"/>
                                <html:select property="cmbMotivoRechazo">
                                    <option value="00" >--Seleccionar--</option>
                                    <html:optionsCollection name="idmotivorechazoreniec" value="npparametervalue1" label="npparametername" />
                                </html:select>
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <input type="button" value="Guardar" style="width:80px" class="simplemodal-close" onclick="javascript:fBotonPopup('<%=respuestaNovatronicReniec.getIDOrden()%>','<%=respuestaNovatronicReniec.getFuenteReal()%>','R','#popup_reniec_view')">
                                <input type="button" value="Cancelar" style="width:80px" onclick="javascript:showonlyoneDiv('divMotivoRechazoReniec','ocultar','Reniec');">
                            </td>                    
                        </tr>
                    </table>
                     </div>   
                </td>                
            </tr>                
           </table>           
        <%    
        }
        %>
     </div>
     </div>
        
    <div id="popup_reniec_view_IdData" style="display:none; opacity: 0.8;" class="popup_reniec_view-overlay" align="center" tabindex='-1'> 
        <div id="box" class="box">
            <div class="PortletHeaderColor" >
                <h1 align="center" class="PortletHeaderColorPopup">Verificaci&oacute;n de Datos del Cliente            
               </h1> 
           </div>       
      <%
        java.lang.String smostrarPopupIdData = (String)request.getAttribute("popupVerificacion");
        com.nextel.aditional.OrdenResultReniecIdData respuestaNovatronicIdData= new com.nextel.aditional.OrdenResultReniecIdData();
        //smostrarPopupReniec        
        if(smostrarPopupReniec=="2"){
            respuestaNovatronicIdData = (com.nextel.aditional.OrdenResultReniecIdData)request.getAttribute("respuestaNovatronic");                         
        %>   
           <table width="100%">
            <tr>
                <td align="center" width="40%">
                    <div align="center">
                        <table  align="left">
                            <tr>
                                <td class="LeftSubTab">
                                    <% if (respuestaNovatronicIdData.getLogitudFirma()>0){ %>
                                          <img src="OrderActionMultiple.do?metodo=imageGetter&pTypeImg=foto" height="250" width="250">                                                                        
                                    <% }%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <% if (respuestaNovatronicIdData.getLongitudFoto()>0){%>
                                        <img src="OrderActionMultiple.do?metodo=imageGetter&pTypeImg=firma" height="80" width="250">
                                    <% }%>
                                    
                                </td>         
                            </tr>
                        </table>
                    </div>
                </td>
                <td align="left">
                    <table align="left" width="100%">  
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Número de DNI</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getNumeroDNI(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getNumeroDNI(),2)%>
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Apellido Paterno</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getApellidoPaterno(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getApellidoPaterno(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Apellido Materno</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getApellidoMaterno(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getApellidoMaterno(),2)%> 
                                <% } %>
                                </strong>
                                    
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left">
                                    <strong>Nombres</strong>
                                </div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getNombres(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getNombres(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                           <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Fecha de Nacimiento</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getFechaNacimiento(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getFechaNacimiento(),2)%> 
                                <% } %>
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="30%" class="LeftSubTab">
                                <div align="left"><strong>Sexo</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getSexoDescripcion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getSexoDescripcion(),2)%> 
                                <% } %>                                    
                                </strong>
                            </td>
                        </tr>
                         <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Grupo de Votacion</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                <% if(!StringUtils.notNull(respuestaNovatronicIdData.getGrupoVotacion(),2).equalsIgnoreCase("null")){%>
                                    <%=StringUtils.notNull(respuestaNovatronicIdData.getGrupoVotacion(),2)%> 
                                <% } %>                                
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Ubigeo de Votacion</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                    <% if(!StringUtils.notNull(respuestaNovatronicIdData.getUbigeoVotacion(),2).equalsIgnoreCase("null")){%>
                                        <%=StringUtils.notNull(respuestaNovatronicIdData.getUbigeoVotacion(),2)%>
                                    <% } %>                                    
                                </strong>
                            </td>
                        </tr>                  
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Departamento de Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                    <% if(!StringUtils.notNull(respuestaNovatronicIdData.getDepartamentoDomicilio(),2).equalsIgnoreCase("null")){%>
                                        <%=StringUtils.notNull(respuestaNovatronicIdData.getDepartamentoDomicilio(),2)%> 
                                    <% } %>                                      
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="30%" class="LeftSubTab">
                                <div align="left"><strong>Provincia de Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                    <% if(!StringUtils.notNull(respuestaNovatronicIdData.getProvinciaDomicilio(),2).equalsIgnoreCase("null")){%>
                                        <%=StringUtils.notNull(respuestaNovatronicIdData.getProvinciaDomicilio(),2)%>
                                    <% } %>                                    
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Distrito de Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                    <% if(!StringUtils.notNull(respuestaNovatronicIdData.getDistritoDomicilio(),2).equalsIgnoreCase("null")){%>
                                        <%=StringUtils.notNull(respuestaNovatronicIdData.getDistritoDomicilio(),2)%> 
                                    <% } %>                                                                    
                                </strong>
                            </td>
                        </tr>
                        <tr class="ListRow1">
                            <td width="40%" class="LeftSubTab">
                                <div align="left"><strong>Domicilio</strong></div>
                            </td>
                            <td style="width:40%">
                                <strong> 
                                    <% if(!StringUtils.notNull(respuestaNovatronicIdData.getDireccionDomicilio(),2).equalsIgnoreCase("null")){%>
                                        <%=StringUtils.notNull(respuestaNovatronicIdData.getDireccionDomicilio(),2)%>
                                    <% } %> 
                                </strong>
                            </td>
                        </tr>
                                
                    </table>
                </td>
            </tr>
            <tr class="ListRow1">
                <td  colspan="4" align="center">
                    <div id="divIdDataButtons">
                        <table>
                            <tr>
                                <td>                                                                      
                                    <input type="button" value="Aceptar" style="width:80px" class="simplemodal-close" onclick="javascript:fBotonPopup('<%=respuestaNovatronicIdData.getIDOrden()%>','<%=respuestaNovatronicIdData.getFuenteReal()%>','A')">                                    
                                    <input type="button" value="Rechazar" style="width:80px" onclick="javascript:showonlyoneDiv('divMotivoRechazoIdData','mostrar','IdData');" >
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="newboxes" id="divMotivoRechazoIdData" style="display:none;">
                       <table width="100%" align="center">
                            <tr class="ListRow1" align="center">
                                <td> 
                                    <bean:define id="idmotivorechazoiddata" name="OrderForm" property="lstMotivoRechazo"/>
                                    <html:select property="cmbMotivoRechazo">
                                        <option value="00" >--Seleccionar--</option>
                                        <html:optionsCollection name="idmotivorechazoiddata" value="npparametervalue1" label="npparametername" />
                                    </html:select>
                                </td>
                            </tr>   
                            <tr class="ListRow1" align="center">
                            <td>
                                <input type="button" value="Guardar" style="width:80px" class="simplemodal-close" onclick="javascript:fBotonPopup('<%=respuestaNovatronicIdData.getIDOrden()%>','<%=respuestaNovatronicIdData.getFuenteReal()%>','R')">
                                <input type="button" value="Cancelar" style="width:80px" onclick="javascript:showonlyoneDiv('divMotivoRechazoIdData','ocultar','IdData');">
                            </td>
                        </tr>   
                       </table>
                   </div>
                </td>
                
            </tr>                
           </table>
           
         <%                         
        }
        %> 
     </div>
    </div>

  <div id="popup_view_form" style="display:none; opacity: 0.8;" class="popup_portablity_view-overlay" align="center" tabindex='-1'> 
              <div id="box1" class="box1">
                 
                   <h1 align="center" class="PortletHeaderText PortletHeaderColor" >Portabilidad</h1>
                  
                         <table align="center">  
                              <tr class="ListRow1">
                                    <td class="LeftSubTab"><strong>Cedente</strong></td>
                                    <td><bean:define id="idcedenteview" name="OrderForm" property="lstCedentes"/>
                                        <html:select property="txtCedenteview">
                                            <option value="0" >--Seleccionar--</option>
                                            <html:optionsCollection name="idcedenteview" value="npparameterid" label="npparametername" />
                                        </html:select>
                                    </td>
                             </tr>
                             <tr class="ListRow1">
                                    <td class="LeftSubTab"><strong>Telefono a portar</strong></td>
                                    <td><label class="txtFormLogin" id="lblTelefonoview"></label></td>
                                    <td></td>
                             </tr>
                             
                             <tr class="ListRow1">
                                    <td class="LeftSubTab"><strong>Origen</strong></td>
                                    <td><bean:define id="idorigenview" name="OrderForm" property="lstOrigenes"/>
                                        <html:select property="txtOperadoraView">
                                            <option value="0" >--Seleccionar--</option>
                                            <html:optionsCollection name="idorigenview" value="npparameterid" label="npparametername" />
                                        </html:select>
                                    </td>
                             </tr> 
                             
                             <tr class="ListRow1">
                                <td class="LeftSubTab"><strong>Tipo de Documento</strong></td>
                                <td><bean:define id="idTipoDocumento" name="OrderForm" property="lstTipoDocumento"/>
                                    <html:select property="txtTipoDocumento">
                                       <!-- <option value="0" >--Seleccionar--</option>-->
                                        <html:optionsCollection name="idTipoDocumento" value="npparameterid" label="npparametername" />
                                    </html:select>
                                </td>
                            </tr>
                            
                             <tr class="ListRow1">
                                <td class="LeftSubTab"><strong>N&uacute;mero de Documento</strong></td>
                                <td>
                                    <label name="txtNumeroDocumento" id="txtNumeroDocumento" class="txtFormLogin"
                                    onkeypress="return soloNumeros(event);" size="11">xxx</label>
                                </td>
                             </tr>  
                              <!--Inicio RPASCACIO 11-09-2014 Agregar Boton Cerrar y darle funcionalidad-->
                              <tr><td>&nbsp;</td></tr>               
                              <tr class="ListRow1">                    
                                  <td colspan="2" align="center">
                                        <input value="Cerrar"  type="button" name="btnCerrar" id="btnCerrar" class="simplemodal-close" style="width: 100px;"/>                       
                                 </td>  
                              </tr> 
                               <!--Inicio RPASCACIO 11-09-2014 Agregar Boton Cerrar y darle funcionalidad-->
                        </table>                   
               </div>             
 </div>  
<!--Apolarc Proyecto fija movil -->
  <input name='txtOperationType' id="txtOperationType" type='hidden' style='width:150px' readonly='true' 
value='<%=request.getAttribute("tipoOperacion")%>'>
  <input name='txtResultEval' id="txtResultEval" type='hidden'  readonly='true' 
value='<%=request.getAttribute("resultEval")%>' />
  <!-- Fin -->       
</html:form>


<script defer="defer" type="text/javascript" language="javascript">

    function mensaje1(){
        alert("Usted esta aceptado");
    }
    
    function mensaje2(){
        alert("Esta seguro que no acepte los datos de verificacion del cliente");
    }    
    //PPNN-DESCOMENTAR
    /*Apolarc Comentado Proyecto telefonia Fija*/
    //initCmb();

    function loadSubCategoria(categoria)
    {       
        //SubCategoria
        var flagSubCategoria = "<%=request.getAttribute("statusCmbSubCategoria")%>";
        var pages = "<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=cargarSubCategoria&cmbCategoria=" + categoria;
        
        $.ajax({  
           type: 'POST',
           contentType: "text/xml,ISO-8859-1",
           url: pages,               
           data:  null,
           success:function(miXml){
                    updateSubCategoria(miXml);
                    // document.forms[0].cmbSubCategoria.remove(4|2068);
                    //document.forms[0].cmbSubCategoria.disabled=true;
                    //Solución
                     if (flagSubCategoria=="true"){
                        cargarSolucion();
                    }   
           },
           error: function(xhr, status, error) {
               alert(status);
               alert(xhr.responseText);
           }                           
        });            
    }        
    /* Apolar Comentado Proyecto Telefonia Fija
    function initCmb(){                 
        var equifaxResult = "<%=(String)request.getSession().getAttribute("equifaxResult")%>";
        var flagCategoria = "<%=request.getAttribute("statusCmbCategoria")%>";
        var flagSubCategoria = "<%=request.getAttribute("statusCmbSubCategoria")%>";
        if(document.forms[0].bflagconditionrule.value=="true" && (equifaxResult!=null && equifaxResult!="null")){
            //División de Negocio
           document.forms[0].cmbDivision.selectedIndex = 1;
           document.forms[0].cmbDivision.disabled=true;
           
           var division = document.forms[0].cmbDivision.value;                              
           
           //Categoria
           var pageOrig = "<%=request.getRequestURI() %>".replace("<%=request.getContextPath() %>","");
                pageOrig = pageOrig.replace("/","");
           
           var pages = "<%=request.getContextPath() %>/OrderAction.do?metodo=cargarCategoria&cmbDivision=" + division + "&pageOrig=" + pageOrig;               
           $.ajax({  
               type: 'POST',  
               contentType: "text/xml,ISO-8859-1",
               url: pages,               
               data:  null,
               success:function(miXml){
                        if (flagCategoria=="true"){
                            updateCategoria(miXml);                      
                        }
                        var categoria = document.forms[0].cmbCategoria.value;
                        //FBERNALES - No es necesario cargar el combo de subcategoria en este punto
                        if (flagSubCategoria="true"){
                            loadSubCategoria(categoria);
                        }
                        
               },
               error: function(xhr, status, error) {
                   alert(status);
                   alert(xhr.responseText);
               }                           
           });
          
        } else {        
            if(equifaxResult!=null && (equifaxResult=='DESAPROBADO')){
               //División de Negocio
               document.forms[0].cmbDivision.selectedIndex = 1;
               document.forms[0].cmbDivision.disabled=true;
               
               var division = document.forms[0].cmbDivision.value;                              
               
               //Categoria
               
               var pageOrig = "<%=request.getRequestURI() %>".replace("<%=request.getContextPath() %>","");
                pageOrig = pageOrig.replace("/","");              
               var pages = "<%=request.getContextPath() %>/OrderAction.do?metodo=cargarCategoria&cmbDivision=" + division + "&pageOrig=" + pageOrig;               
               $.ajax({  
                   type: 'POST',  
                   contentType: "text/xml,ISO-8859-1",
                   url: pages,               
                   data:  null,
                   success:function(miXml){                            
                            updateCategoria(miXml);                            
                            // document.forms[0].cmbCategoria.selectedIndex = 1;
                            // document.forms[0].cmbCategoria.disabled=true;
                            //  document.forms[0].cmbCategoria.remove(3);
                            var categoria = document.forms[0].cmbCategoria.value;
                            //FBERNALES - No es necesario cargar el combo de subcategoria en este punto
                            //loadSubCategoria(categoria);
                            
                   },
                   error: function(xhr, status, error) {
                       alert(status);
                       alert(xhr.responseText);
                   }                           
               });  
            }  
        }
    }  */    
	
/*Apolarc proyecto Telefonia fija*/
var salesrule;

$(function(){

    var division = {
        cmb:$("#cmbDivision")
    },
    centroCostos = {
        lblCentroCosto:$("#labelTxtCentroCosto"),
        wpCentroCosto: $("#wrapperCentroCosto"),
        cmb:$("#cmbSite"),
        proxy:$.post
    },
    log = function(msj){
        //alert(msj);
    };
    
    centroCostos.exist = (function(){
        //var exist = centroCostos.cmb.val()?true:false;
        var exist = true;
        log("centroCostos.exist \n  exist " + exist );
        return exist;
    })()
    
    centroCostos.loadXdivision = function(id){
        log("centroCostos.loadXdivision \n  division " + id);
        var idDivision = id;
        if(typeof idDivision == "undefined" || idDivision==0){
            centroCostos.hide();
            return false;
        } 
        centroCostos.listarXdivision(idDivision); 
    }
    
    centroCostos.listarXdivision = function(idDivision){
        log("centroCostos.listarXdivision \n division " + idDivision);
        var url = "<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=listarCentroCostos";        
        centroCostos.proxy(url,{cmbDivision:idDivision},function(lstCentroCosto){
            log("centroCostos.proxy \n Ajax url ");
            if(centroCostos.insert(lstCentroCosto)){
                centroCostos.show();
            }else{
                centroCostos.hide();
            }
        },"xml");     
    }
   
    centroCostos.insert = function(miXml){
                var division = miXml.getElementsByTagName("division")[0];
		var centro = division.getElementsByTagName("centro");
                var l=centro.length;
                var item,myString,trozo,option = "";
		
                centroCostos.cmb.html("");	

                if(l==0){
                    log("No cuenta con centros de costos de idDivision " + $("#cmbDivision").val());
                    centroCostos.hide();
                    return false;
                }
                
                option = '<option value="0" >--Seleccionar--<//option>';
                centroCostos.cmb.append(option);
		for (var i=0;i<l;i++){
                        item = centro[i];
                        myString = item.firstChild.nodeValue;
                        trozo  = myString.split(";");
                        option = '<option value='+trozo[0]+'>'+trozo[1]+'<//option>';
                        centroCostos.cmb.append(option);          
		}
                
                return true;
    }
    
    centroCostos.hide = function(){
        log("centroCostos.hide");
        centroCostos.lblCentroCosto.css("display","none");
        centroCostos.wpCentroCosto.css("display","none");
    }
    
     centroCostos.show = function(){
        log("centroCostos.show ");
        centroCostos.lblCentroCosto.css("display","block");
        centroCostos.wpCentroCosto.css("display","block");
    }

    division.cmb.change(function(){
    
    cargarCategoria();
    
        if(centroCostos.exist){
            log("division.cmb.change \n Division " + division.cmb.val());
            centroCostos.loadXdivision(division.cmb.val());
        }
        
     //Clean Combos
       cleanCombos(4);
        
     /*Habilitar Categoria y SubCategoria*/
     document.forms[0].cmbCategoria.disabled = false;
     document.forms[0].cmbSubCategoria.disabled = false;
     
     var tipoOpe = $("#txtOperationType").val();
     var resultEva = $("#txtResultEval").val();
     centroCostos.applySalesRule(division.cmb.val(),tipoOpe,resultEva);
        
        
 
        
    })
    
    centroCostos.condition = {};
    centroCostos.applySalesRule = function(idDivision,tipoOperacion,resultEval){
        var url = "<%=request.getContextPath() %>/OrderActionMultiple.do?metodo=getSalesRule";        
        $.post(url,{cmbDivision:idDivision,tipoOperacion:tipoOperacion,resultEval:resultEval},function(rule){
   
            log("centroCostos.proxy \n Ajax url ");
            
                var xrule = rule.getElementsByTagName("rule")[0];
		var xcondition = xrule.getElementsByTagName("condition");
                var l=xcondition.length;
                var item,myString,trozo,option = "";
                
                if(l==0){
                    log("No cuenta con rule para la division " + idDivision);
                    salesrule = {
                      category:{selected:"",enable:""},
                      subCategory:{selected:"",enable:""}
                    };
                }else{
                    item = xcondition[0];
                    myString = item.firstChild.nodeValue;
                    trozo  = myString.split(";");
                 
                    centroCostos.condition.category={
                       selected : trozo[0],
                       enable   : trozo[1]
                    };
                 
                    centroCostos.condition.subCategory={
                       selected : trozo[2],
                       enable   : trozo[3]
                    };
                    
                    salesrule = centroCostos.condition;
                 }
                 
             cargarCategoria();   
                 
      
        },"xml");     
    }
   
})
    /*fin Apolarc*/
       
</script>
<%@include file="ValidacionBiometrica.jsp" %>
<%@include file="ValidacionDireccionNormalizada.jsp" %>
<%@include file="ValidacionDireccionJuridica.jsp" %>
<script type="text/javascript" language="javascript">
    /*NORMALIZACION DE DIRECCIONES*/
    var validaPerfilPromotor = '<%=(String)request.getAttribute("validaPerfilPromotor")%>';
    if(validaPerfilPromotor == '0'){
        mostrarNormalizacionDirecciones();
    }
</script>
</body>
</html>