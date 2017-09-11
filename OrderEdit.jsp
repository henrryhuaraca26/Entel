<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.util.List"%>
<%@ page import="com.nextel.bean.NpParameter"%>
<%@ page import="com.nextel.service.NpParameterService"%>
<%@ page import="com.nextel.service.NpOrderService"%>
<%@ page import="com.nextel.utilities.Constant"%>
<%@ page import="com.nextel.utilities.DateUtils"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="./WEB-INF/tld/estadoportabilidad.tld" prefix="portabilidad_estado"%>
<%@ taglib uri="./WEB-INF/tld/motivorechazo.tld" prefix="portabilidad_motivo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Nextel</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/callAjax.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/calendario.js"></script>      
<script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>      
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.simplemodal.js"></script> 
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.10.4.min.css">  
<link type='text/css' href='css/modal.css' rel='stylesheet' media='screen' />
<script type="text/javascript" src="js/jquery.hashchange.min.js"></script> 
<script type="text/javascript" src="js/jquery.easytabs.min.js"></script> 
    
<!-- % if (new Integer(request.getSession().getAttribute("digiFlag").toString()) ==1){ //JTORRESC 16-02-2012 digitalizacion %>
<link type="text/css" rel="stylesheet" href="css/jquery.lightbox-0.5.css">
<script type="text/javascript" src="js/deployJava.js"></script>
<script type="text/javascript" src="js/jquery.lightbox-0.5.min.js"></script>
}  -->
<style type="text/css">
    .LeftSubTabWhite {
        background-color: #FFFFFF;
        border-collapse:collapse;
    }
</style>
<OBJECT classid='CLSID:592B9D7E-51C9-401F-A03C-4DE61FF7008D' name="Autentia" id='Autentia'></OBJECT>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
</head>
<body>
<EMBED id="plgAutentia" TYPE="application/x-proxyautentiasocket-plugin" ALIGN=CENTER WIDTH=0 HEIGHT=0>		
<bean:define id="listaLugarPago" name="OrderForm" property="lstPaymentSite" type="java.util.List<NpParameter>"/>
<script type="text/javascript" language="javascript">
//$(document).ready(function(){
	//Mostrar ventana Modal cuando se hace clic en Iniciar
//	$("#portabilidad_link").click(function(){
  //      $('#portabilidad_form').modal();
    //                                    }
      //                                  );
        //        });


	// Link to open the dialog
 
  $(function() {
                $(".portabilidad_link").click(
                       function() {
                        var indice=$(".portabilidad_link").index(this);  
                        var idItem = document.getElementsByName('txtIdItemArray[]')[indice].value
			CargarDataAjax(idItem);
                        $('#popup_view_form').modal(); 
		});
	});	


if(<%=request.getAttribute("mostrarDetalle")%>==1)
{   //ventana('OrderAction.do?metodo=infoActivationHome','popDetalleOrden','410','200','no','no');
    ventana('OrderActivationDetail.jsp','popDetalleOrden','410','200','no','no');
}
if(<%=request.getAttribute("mostrarDetalle")%>==2)
{   //ventana('OrderAction.do?metodo=infoActivationHome','popDetalleOrden','410','200','no','no');
    //alert('No se encontraron resultados y se enviaran los números telefónicos por correo'); 
    alert('Se activará en unos minutos, los números serán enviados por mensaje de texto'); 
}
if(<%=request.getAttribute("mostrarDetalle")%>==3)
{   //ventana('OrderAction.do?metodo=infoActivationHome','popDetalleOrden','410','200','no','no');
    //alert('No se encontraron resultados y se enviaran los números telefónicos por correo'); 
    alert('<%=request.getAttribute("mostrarDetalleBody")%>'); 
}

function mostrarValdiacionBiometrica(){
    $("#popup_identificacion_view").modal({
        show: false,
        width: 'auto',
        height: 'auto',
        backdrop: 'static',
		/*NORMALIZACION DE DIRECCIONES*/
        onClose: function (dialog) {
            if(autentiBiometricaOK == true && '<%=(String)request.getSession().getAttribute("validaDireccion")%>' == '0' ){
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
    $("#ordenIdValidBiomTxt").val("<%=(String)request.getAttribute("ordenGenerada")%>");
    $("#initOrder").val("E");
    
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
	}
    
}

function metodoExtraAnulacion(){
    if(document.getElementById('btnProcesar')!=null){
        document.getElementById('btnProcesar').style.display = 'none';
    }
    if(document.getElementById('btnLanzarValidacionCliente')!=null){
        document.getElementById('btnLanzarValidacionCliente').style.display = 'none';
    }
}

function metodoExtraOK(){
	//NORMALIZACION DE DIRECIONES
    autentiBiometricaOK = true;
    //NORMALIZACION DE DIRECIONES FIN
    $("#btnProcesar").attr("disabled",false);
    if(document.getElementById('btnLanzarValidacionCliente')!=null){
        document.getElementById('btnLanzarValidacionCliente').style.display = 'none';
    }
}

function CargarDataAjax(item){
 var req = newXMLHttpRequest(); 
    req.onreadystatechange = getReadyStateHandler(req,Recarga);
    req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=orderPrintPortabilidad&itemid="+item,true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null);
}


function Recarga(miXml){
               
                var porta = miXml.getElementsByTagName("portabilidad")[0];
                var data = porta.getElementsByTagName("data");
               
                for (var i=0;i<data.length;i++){
                        var item = data[i];
                        var myString = item.firstChild.nodeValue;
                        var campo = myString.split(";");
                        var indice = campo[0];  
                        //Recarga ajax 
                          document.getElementById('lbltelefono').innerHTML = campo[1];
                          //INICIO--RPASCACIO 28-08-2014
                          $('select[name="txtOperadoraView"]')[0].value=campo[2];
                          document.getElementById('lblestado').innerHTML = campo[3];
                         // document.getElementById('lblmotivorechazo').innerHTML = campo[4];
                         // document.getElementById('lblmotivoadeudado').innerHTML = campo[5];                      
                          $('select[name="txtTipoDocumentoView"]')[0].value=campo[4];            
                          document.getElementById('lblnumerodocumento').innerHTML = campo[5];       
                          //FIN--RPASCACIO 28-08-2014
                          //Paul Rivera 09/09/2014 Inicio
                          document.getElementById('lblmotivorechazo').innerHTML = campo[6];
                          //Paul Rivera 09/09/2014 Fin 
                          //Paul Rivera 17/09/2014 Inicio
                          document.getElementById('lblcedente').innerHTML = campo[7];
                          //Paul Rivera 17/09/2014 Fin                           
                }                                              
	}
 

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


function AsociarVoucher(){    
    var valido = false;
    var valido2 = false;
    var total_text = 0;
    
    //Paul Rivera 18/08/2014
    //Si se trata de "Renta Adelantada" el número de voucher items de orden será 
    //del mismo value que voucher pago de garantia
    //inicio seteo en input text
    var sStatusGarranty='<%=Constant.P_ORDER_DEP_GUARANTEE%>';
    if(document.forms[0].estadoOrdenSearch.value==sStatusGarranty){
        if(document.forms[0].cmbTipDeposito.value=='<%=(String)request.getSession().getAttribute("rentaadelantada")%>'){
            document.forms[0].txtGuaranteeVoucher.value=document.forms[0].txtVoucher.value;
        }
    }
    //fin seteo en input text

    for (var i=0;i < document.forms[0].elements.length;i++) {
        var elemento = document.forms[0].elements[i];
        if (elemento.type == "checkbox"){
            if(elemento.checked==true){
                valido = true;              
            }
        }
    }
    
    document.forms[0].txtVoucher.value = TrimLeftRight(document.forms[0].txtVoucher.value);
    var vVoucher = document.forms[0].txtVoucher.value;
    
    if(vVoucher != ""){
        valido2 = true;
    }

    if( (valido==true) && (valido2==true)) {
        for (var i=0;i < document.forms[0].elements.length;i++){
            var elemento = document.forms[0].elements[i];
            if (elemento.type == "checkbox"){
                if(elemento.checked==true){
                    document.getElementsByName('txtVoucherTemp[]')[elemento.value].value = vVoucher;
                    document.getElementsByName('hidVoucher[]')[total_text].value = vVoucher;
                }
                elemento.checked=false;
            }
            
            if(elemento.type=="hidden" && elemento.name=="hidVoucher[]"){
                total_text=total_text+1;
            }
        }
        document.forms[0].txtVoucher.value="";
        document.forms[0].txtVoucher.focus();
    }else{
        alert("Debe Seleccionar un detalle de Orden y un valor de Voucher.");
    }
}

/* INICIO
* CREATED BY : FBERNALES   -- PROYECTO: PORTABILIDAD  
*                          -- REQUERIMIENTO : LIMITE DE TIEMPO PARA LAS ORDENES DE PORTABILIDAD
*/
function ValidateTimeLimitExceeded(){
/* FBERNALES - LIMPIAMOS LOS CAMPOS DE VALIDACION DE LIMITE DE TIEMPO*/
    
    var subCategoria = document.forms[0].cmbSubCategoria.value;
    /*alert("subCategoria = "+subCategoria);*/
    var req = newXMLHttpRequest();  
    req.onreadystatechange = getReadyStateHandler(req,ValidateUpdateProcessTimeLimitExceeded);
    req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=ValidarTimeLimitFromJsp&cmbSubCategoria=" + subCategoria+"&tipoValidacionHora=ACTIVACION",true);
    req.setRequestHeader("Content-Type","application/ISO-8859-1");
    req.send(null); 
}

function ValidateUpdateProcessTimeLimitExceeded(miXml){
                var LimitExceeded = miXml.getElementsByTagName("limitExceeded")[0];
		var flagTimeLimitExceeded = LimitExceeded.getElementsByTagName("timeLimitExceeded")[0].childNodes[0].nodeValue;		
                if (flagTimeLimitExceeded=="true"){                  
                    var sBodyMessageToShow = LimitExceeded.getElementsByTagName("sBodyMessageToShow")[0].childNodes[0].nodeValue;
                    alert(sBodyMessageToShow);
                    
                }else if (flagTimeLimitExceeded=="false"){
                    ActualizarOrdenVenta();
                }
	}

function ActualizarOrdenVenta(){

    document.forms[0].Submit.disabled = true; //jtorresc sar 0037-177552 24-01-2012
    var mensajeTemp = "";
    var valido = ValidaDatos(document.forms[0],1);
    
    if(valido) {   
              
        if ('<%=request.getSession().getAttribute("digiFlag")%>' == '1') { //JTORRESC 16-02-2012 digitalizacion        
        if ('<%=request.getSession().getAttribute("statusSeccionDigitalizacion")%>' != 'display:none') {
            
            var cargaAutomatica = $("#rbAutomaticUpload").attr("checked"),cargaManual = $("#rbManualUpload");
            
            if ($('#manualUpload').is(":visible")) {               
                if (validateManualFiles()) {
                    sendManuallySelectedFiles();
                } else {
                    //alert('Seleccione todos los archivos de la carga manual');
                    alert('Seleccione las imágenes - Digitalización de Documentos');
                    document.forms[0].Submit.disabled = false; //jtorresc sar 0037-177552
                    return;
                }
            }
            /*else if ($('#automaticUpload').is(":visible")) {               
                if (!validateSendFilesExecuted()) {                    
                    alert('Presione el botón "Cargar Archivos"');
                    document.forms[0].Submit.disabled = false; //jtorresc sar 0037-177552
                    return;
                }
            } */
            else {
                alert('Termine de seleccionar una de las dos modalidades de carga de los archivos de imágenes');
                document.forms[0].Submit.disabled = false; //jtorresc sar 0037-177552
                return;
            }
                        
        }
        }//Fin del digiFlag
    
        var sw=true;
           
        for (var i=0;i < document.forms[0].elements.length;i++){
            var elemento = document.forms[0].elements[i];
            if(elemento.type=="hidden" && elemento.name=="hidVoucher[]"){
                if(TrimLeftRight(elemento.value) == ""){
                    mensajeTemp = "Asociar el nro del Voucher de los item(s) de la Orden.";//jtorresc sar 0037-177552
                    document.forms[0].txtVoucher.focus();
                    sw = false;
                }
            }             
        }           
          
        var flag = true;
        var sStatusGarranty='<%=Constant.P_ORDER_DEP_GUARANTEE%>';
        if(document.forms[0].estadoOrdenSearch.value==sStatusGarranty){
            if(document.forms[0].cmbPaymentSite){
                if(document.forms[0].cmbPaymentSite.value == 0 && document.forms[0].cmbTipDeposito.value != '<%=(String)request.getSession().getAttribute("rentaadelantada")%>'){
                    document.forms[0].cmbPaymentSite.focus();
                    mensajeTemp = "Seleccione el Lugar de Pago Garantia.";
                    flag = false;
                }
            }
            
            if (document.forms[0].cmbPaymentSite.value=='<%=(String)request.getSession().getAttribute("depositocadenaid")%>'){
                if (document.forms[0].txtGuaranteeVoucher){
                    document.forms[0].txtGuaranteeVoucher.value = TrimLeftRight(document.forms[0].txtGuaranteeVoucher.value);
                    //INI: Alvaro Leiva SAR 0037-195040.
                    //Paul Rivera 29/08/2014 se añade la validación de Renta Adelantada "RA" después del comodín &&
                    if ((document.forms[0].txtGuaranteeVoucher.value.length != 8) && (document.forms[0].cmbTipDeposito.value != '<%=(String)request.getSession().getAttribute("rentaadelantada")%>')){
                        flag = false;
                        mensajeTemp = "El número de transacción debe contener 8 dígitos.";
                        document.forms[0].txtGuaranteeVoucher.focus();
                    }//FIN: Alvaro Leiva SAR 0037-195040.
                }
            }	
            
            if(document.forms[0].txtDateGuaranteePayment){
                if(TrimLeftRight(document.forms[0].txtDateGuaranteePayment.value) == ""){
                    document.forms[0].txtDateGuaranteePayment.focus();                
                    flag = false;
                    mensajeTemp = "Ingrese la Fecha de Pago Garantia.";
                }else{
                    var fecha = new Date();
                    var fechaActual = fecha.getDate()+"/"+(fecha.getMonth()+1)+"/"+(fecha.getFullYear());
                    var fechaDeposito = document.forms[0].txtDateGuaranteePayment.value;
                    var fechaOrden = document.forms[0].orderDate.value;
                                    
                    var diffOfDatesActual = diffBetweenTwoDates(fechaActual, fechaDeposito,'0', 0);                                
                    var diffOfDatesOrden = diffBetweenTwoDates(fechaOrden, fechaDeposito,'0', 0);
                                                    
                    if (diffOfDatesOrden < 0){
                        flag = false;
                        mensajeTemp = "La fecha de Deposito debe ser mayor o igual a la orden.";
                        document.forms[0].txtDateGuaranteePayment.focus();
                    }else if(diffOfDatesActual > 0){
                        flag = false;
                        mensajeTemp = "La fecha de Deposito debe ser menor o igual a la actual.";
                        document.forms[0].txtDateGuaranteePayment.focus();
                    }                
                }
            }
            
            //FBERNALES - 01/01/2014 -> VALIDACION DE 8 DIGITOS CUANDO EN EL COMBO DE LUGAR DE PAGO EN GARANTIA
            //                          ES INTERBANK            
            var labelInterbank = '<%=Constant.DEPOSITO_INTERBANK_LABEL%>';
            
            if (document.forms[0].txtGuaranteeVoucher.value.length != 8 && $('#cmbPaymentSite').children(':selected')[0].label==labelInterbank){
                flag = false;
                mensajeTemp = "El número de transacción debe contener 8 dígitos.";
                document.forms[0].txtGuaranteeVoucher.focus();
            }                                                               
        }
        
        if(document.forms[0].cmbPaymentType){
            if(document.forms[0].cmbPaymentType.value == 0){
                document.forms[0].cmbPaymentType.focus();
                mensajeTemp = "Seleccione el Tipo de Pago.";
                flag = false;
            }                
        }                
        
        if( (sw==true) && (flag == true)) {                
            document.forms[0].metodo.value="orderUpdate";
            document.getElementById('div_btnProcesar').style.visibility="hidden";
            
            
            /*FBR*/
            //obtenemos los tipos de las imagenes que se han adicionado a las normales 
            <% if (new Integer(request.getSession().getAttribute("digiFlag").toString()) == 1){ %> //JTORRESC 16-02-2012 digitalizacion 
            GetElementDocTypeAdd();        
            <% } %> //JTORRESC 16-02-2012 digitalizacion 
            /*FBR*/
                        
            document.forms[0].Submit.disabled = true; //luisina rasetta sar 0037-177552
            document.forms[0].submit();
        } else {
            document.forms[0].Submit.disabled = false; //jtorresc sar 0037-177552 24-01-2012
            if (mensajeTemp !=""){
                alert(mensajeTemp);   
            }else{
                alert("Debe completar toda la información necesaria");
            }
        }
    }else{
        document.forms[0].Submit.disabled = false; //jtorresc sar 0037-177552 24-01-2012
    }
}

function Cancelar(){
    var entrar = confirm("Esta Ud. seguro de que desea Cancelar")
	if (entrar){    
            document.forms[0].metodo.value="orderCancelSelect";
            document.forms[0].submit();
        }
    return false;    
}

function setPaths(paths) {
    //imagesApplet.setPathsString(paths);
}

function setDocumentTypes(types) {
    //imagesApplet.setTypesString(types);
}

function setDocumentNames(names) {
    //imagesApplet.setNamesString(names);
}

function sendFiles() {
    //imagesApplet.sendImage();   
    $('#sendFilesExecuted').val('1');
}

function checkFiles() {
    var valido = false;
    
    //imagesApplet.checkFiles();
    //var flagExito = imagesApplet.getFilePathChecked();
    //var filePathNotFound = imagesApplet.getFilePathNotFound();
    
     
    if (flagExito=='OK'){
        valido = true;
    }else{
        valido = false;
        alert("Debe completar toda la información necesaria. No se encontro "+filePathNotFound);
    }
        
    return valido;
}

function verifySentFiles() {
    var valido = false;
    
    //var flagExito = imagesApplet.getFlagSentWithErrors();
    //var filePathSentWithErrors = imagesApplet.getFilePathSentWithErrors();
               
    if (flagExito=='OK'){
        valido = true;
    }else{
        valido = false;
        alert("Existen archivos que no se enviaron correctamente: "+filePathSentWithErrors );
    }
        
    return valido;
}

function showFiles(){
            var url="OrderAction.do?metodo=listFile&ie="+(new Date()).getTime();
            window.open(url,"","width=700,height=600,scrollbars=yes,resizable=yes");
            //window.open("OrderAction.do?metodo=listFile","","width=700,height=600,scrollbars=yes,resizable=yes");
}
function saveImage(){
    document.forms[0].metodo.value="saveImage";
    document.forms[0].submit();
}

function validateManualFiles() {    
    var valido = true;
    
    $('input[type=file]').each( function(a) { 
                                if ($(this).val() === '') {
                                    valido = false;
                                }
                              }
                            );
                            
    return valido;
}

function validateSendFilesExecuted() {    
    return ($('#sendFilesExecuted').val() === '1');
}

function extractFileName(path) {
    var pathParts = path.split('\\'),
        filePart = pathParts[pathParts.length - 1];
    
    return filePart;
}

function manualFileNameExists(fileName){
    var count = 0
        repetido = false;
    
    $('input[type=file]').each( function(a) {
                                    
                                    var currentPath = $(this).val(), 
                                        realName = extractFileName(currentPath);
                                    
                                    if (realName === fileName) {
                                        count = count + 1;
                                    }
                                    
                                    if (count >= 2) {
                                        repetido =  true;
                                    }
                              }
                            );
    
    return repetido;
}

function setDocumentDataFromManualFiles() {    
    var paths = '',        
        prefix = '',
        names = '',        
        types = '',
        documentoIdentidad = '<bean:write name="OrderForm" property="txtCustomerDocumentNumber"/>';
    
    $('input[type=file]').each( function(a) {
                                    
                                    var currentPath = $(this).val(), 
                                        realName = extractFileName(currentPath),
                                        documentData = ($(this).attr('name')).split(','),
                                        expectedName = documentData[0],
                                        currentType = documentData[1];
                                    
                                    if (currentPath !== '') {
                                        names = names + prefix + realName;
                                        types = types + prefix + currentType;
                                        paths = paths + prefix + currentPath;
                                        prefix = ',';
                                    }
                                                                                                            
                              }
                            );
                            
    setPaths(paths);
    setDocumentNames(names);
    setDocumentTypes(types);
            
    return paths;
}

function setImageSectionAppearance() {
    //$("#manualUpload").hide();
    //$("#automaticUpload").hide();
					
    $("#rbAutomaticUpload").attr("checked", false);
    $("#rbManualUpload").attr("checked", false);
    
    $("#rbManualUpload").click( function () { 
                                                            $("#manualUpload").show();
                                                         //   $("#automaticUpload").hide();
                                               } );
    $("#rbAutomaticUpload").click( function () { 
                                                           // $("#automaticUpload").show();
                                                            $("#manualUpload").hide();
                                            } );
                                            
   
}

function reasignPreviousPaths(paths) {
    //Para actualizar la variable de sesión:    
    $.ajax({
      type: "POST",
      url: "<%=request.getContextPath()%>/OrderAction.do",
      data: "metodo=reasignPreviousPaths&paths=" + paths,
      success: function(rpta){
                null;
              }
    });
}

function sendManuallySelectedFiles() {    
    
    var paths = setDocumentDataFromManualFiles();
    
    //sendFiles();   
    reasignPreviousPaths(paths);
}

function validateImageSize(path, size) {
    
    //var valida = imagesApplet.validateImage(path, size);
    var valida = 0;
    var respuesta = false;
    
    if (valida === '1') {
        respuesta = true;
    }
    
    return respuesta;
}

function sendAutomaticallySelectedFiles() {        
    if ( checkFiles() ) {
            sendFiles(); 
            if ( verifySentFiles() ){ //verificar si todas las imagenes se enviaron correctamente.
            showFiles();
            }
            
    }
    
}

function showImage(index) {
    var inputName="file["+index+"]";
       
    var inputValue=$("input[name='"+inputName+"']").val(); 
    var fileName=extractFileName(inputValue);
    var ruta=$("input[name='"+inputName+"']").val();    
    var file    = document.querySelector('input[type=file]').files[0];    
   
   
    if ( ruta !== '') {            
        var url="OrderAction.do?metodo=listFile&tipoCarga=M&rutaManual="+ruta+"&nameFile="+fileName;        
        window.showModalDialog(url,"","dialogWidth:800 px,dialogHeight:520 px,resizable: NO");            
        
    } else {
        alert('Debe seleccionar primero la imágen');
    }
        
}

function cleanImageField(index, expectedFields) {
    $('#file_' + index).replaceWith('<input type="file" id="file' + index + '" name="' + expectedFields +'"/>');
}

if ('<%=request.getSession().getAttribute("digiFlag")%>' == '1') { //JTORRESC 16-02-2012 digitalizacion
$(document).ready(
				function (){ 
                                        if('<%=request.getAttribute("clientIdentification")%>'=="0")
                                        {   //ventana('OrderAction.do?metodo=infoActivationHome','popDetalleOrden','410','200','no','no');
                                            //alert('No se encontraron resultados y se enviaran los números telefónicos por correo'); 
                                            $("#btnProcesar").attr("disabled",true);
                                            $("#btnLanzarValidacionCliente").show();
                                        }else{
                                            $("#btnLanzarValidacionCliente").hide();
                                        }
                                        
                                        /*NORMALIZACION DE DIRECCIONES*/    
       
                                          if('<%=(String)request.getSession().getAttribute("validaDireccion")%>' == '0' ){
                                                if('<%=request.getAttribute("clientIdentification")%>'!="0"){
                                                    $("#btnNormalizarDirecciones").show();
                                                }
                                                 $("#btnProcesar").attr("disabled",true);
                                         }
                                          /*NORMALIZACION DE DIRECCIONES END*/
                                          
                                        if ( '<%=request.getAttribute("mensajeFallaImagenes")%>' === '1') {
                                            alert('No se pudo realizar la operación. Ocurrió un error al insertar las imágenes');                                        
                                        }
                                
					setImageSectionAppearance();
                                        
                                        //Con la función live de jquery se asocian eventos dinamicamente, incluso sobre elementos que aun no existen
                                        $('input:file').live('change', function() {
                                                                    var maxSize = '<%=request.getSession().getAttribute("maxSize")%>',
                                                                        sizeKB,
                                                                        path = $(this).val(),
                                                                        realName = extractFileName(path),
                                                                        expectedFields = $(this).attr('name'),
                                                                        inputId = $(this).attr('id');
                                                                                                                                                                         
                                       
                                                                    if (manualFileNameExists(realName)){
                                                                        alert('Ya existe un archivo con ese nombre');
                                                                        $(this).replaceWith('<input type="file" id="' + inputId + '" name="' + expectedFields +'"/>');
                                                                    }
                                                                    
                                                                }
                                                               );
                                                               
                              }                                                  
                    );
}//fin digiFlag  

//###### INICIO N_O000026564-[Migración Applet]  ######
var indiceCloneRow=2;

function GetElementDocTypeAdd(){
//alert(document.getElementsByName("cboTypeDocument[]"));
var list = new Array();
var b=document.getElementsByName("cboTypeDocument[]");
var concat="";
var texto="";
var pathsToImg="";
var lstdocTypesadd;
$("select[name='cboTypeDocument[]']").each(function() {
        var select = $(this);       
        var indice= select[0].selectedIndex;
        if(concat!=""){
            concat+=",";
            texto+=","
        }           
        texto += $.trim(select[0].options[indice].text);
        concat+=$.trim(select[0].value);
        $.trim(concat);
        $.trim(texto);
    });

document.forms[0].strDocTypesId.value=concat;
document.forms[0].strDocTypesName.value=texto;

var paths = '',
    realnamesimg= '',
    prefix = '';

 $('input[type=file]').each( function(a) {
                                    var currentPath = $(this).val();                                    
                                    if (currentPath !== '') {                                        
                                        paths =  $.trim(paths) +  $.trim(prefix) +  $.trim(currentPath);
                                        realnamesimg =  $.trim(realnamesimg) +  $.trim(prefix) +  $.trim(extractFileName(currentPath));
                                        prefix = ',';
                                    }
                                                                                                            
                              }
                            );
document.forms[0].strFileName.value=realnamesimg;                            
document.forms[0].strDocTypesPaths.value=paths;

}


function cloneRow(){
    var countAddImage=indiceCloneRow;
    indiceCloneRow+=1;
    var row = document.getElementById("rowToClone"); // find row to copy
    var table = document.getElementById("ImagenesDigi"); // find table to append to
     
     var tr = document.createElement('tr');            
        var td = document.createElement('td');
               
        var rowCount = table.rows.length;
        var row = table.insertRow(rowCount);
        row.className = "ListRow1";     
        
        
        var cadena="<strong><select id='cboTypeDocument[]' name='cboTypeDocument[]'>";
        var idcobcl='toClon';
        var first = document.getElementById(idcobcl);
        cadena+=first.innerHTML;
        cadena+="<"+"/strong>";;
        //td.innerHTML+=cadena;           
        //td.width="14%";
        //td.setAttribute("class", "LeftSubTab");
        //tr.appendChild(td);
        
        var i=0;
        var newcell = row.insertCell(i);
        newcell.innerHTML =cadena;        
        newcell.setAttribute("width", "14%");
        newcell.calssName="LeftSubTab";
        
        i++;
        newcell = row.insertCell(i);        
        //var td2 = document.createElement('td');
        cadena = "<label><input type='hidden' id='imageFielHidden' value='"+indiceCloneRow+"' />";         
        cadena += "<input name='file["+indiceCloneRow+"]' type='file' accept='image/jpeg'/></"+"label>";
        //tr.appendChild(td2);
        newcell.innerHTML=cadena;        
              
        
        //var td3 = document.createElement('td'); 
        i++;
        newcell = row.insertCell(i);
		    cadena = " ";
        //cadena = "<a href='javascript:showImage("+indiceCloneRow+")'><img src='images/viewDetail.gif' width='16' height='15' border='0' title='Detalle'/><"+"/a>"            
        newcell.innerHTML=cadena;
        //tr.appendChild(td3);            
        
        //var td4=document.createElement("td");
        i++;
        newcell = row.insertCell(i)
        var txtLabel="";
        cadena="<a id='deleteRow_"+indiceCloneRow+"' href='javascript:deleteRow("+indiceCloneRow+")'><img src='images/Eliminar.gif' width='16' height='15' border='0'/><"+"/a>";                
        newcell.innerHTML=cadena;
        //tr.appendChild(td4);
        
        //var td5=document.createElement("td");
        i++;
        newcell = row.insertCell(i)
        newcell.innerHTML="";
        //td5.width="70%"; 
        //tr.appendChild(td5);                        
       // var s = tr.innerHTML;
     var tbody = document.getElementById('tbImagenesDigi').tBodies[0];
     //tbody.appendChild(tr);
     //getElementById("deleteRow_"+indiceCloneRow).setAttribute("href", "javascript:cleanImageField("+indiceCloneRow+",'"+getElementById("cboTypeDocument_"+indiceCloneRow).value+","+countAddImage"'))";
    
}


function getRowIndex( el ) {
    while( (el = el.parentNode) && el.nodeName.toLowerCase() !== 'tr' );
    
    if( el ) 
        return el.rowIndex;
}

function deleteRow(index)
{

var row = document.getElementById("deleteRow_"+index);
var idx = getRowIndex( row );


document.getElementById("tbImagenesDigi").deleteRow(idx);
}
//###### FIN N_O000026564-[Migración Applet]  ######
//Paul Rivera 03/09/2014 Inicio render
function roundNumber(rnum) { // Renderiza el decimal a dos dígitos
   var newnumber = Math.round(rnum*Math.pow(10,2))/Math.pow(10,2);
   //para el campo costo
   document.forms[0].txtGuaranteeCost.value=parseFloat(newnumber);
}
//Paul Rivera 03/09/2014 Fin render
//Paul Rivera 11/08/2014
//Rutina que permite alternar Depósito en Garantía y Renta Adelantada
<%
String renta_adelantada=(String)request.getSession().getAttribute("rentaadelantada");
String deposit_garantia=(String)request.getSession().getAttribute("depositogarantia");
String deposit_nextel_id=(String)request.getSession().getAttribute("depositonextelid");
String deposit_nextel_value=(String)request.getSession().getAttribute("depositonextelvalue");
String deposit_interbank_id=(String)request.getSession().getAttribute("depositointerbankid");
String deposit_interbank_value=(String)request.getSession().getAttribute("depositointerbankvalue");
String renta_adelantada_cadena_id=(String)request.getSession().getAttribute("depositocadenaid");
String renta_adelantada_cadena_value=(String)request.getSession().getAttribute("depositonextelvalue");
String nuevo = (String)request.getSession().getAttribute("nuevo");
String putVoucher = (String)request.getSession().getAttribute("nuevoVoucher");
String lugarPagoRA = (String)request.getSession().getAttribute("lugarPagoRA");
String deposit_cadena_value = (String)request.getSession().getAttribute("depositocadenavalue");
%>
$(document).ready(function() {
    if('<%=request.getAttribute("clientIdentification")%>'=="0")
    {   //ventana('OrderAction.do?metodo=infoActivationHome','popDetalleOrden','410','200','no','no');
        //alert('No se encontraron resultados y se enviaran los números telefónicos por correo'); 
        $("#btnProcesar").attr("disabled",true);
    }else{
        $("#btnLanzarValidacionCliente").hide();
    }
	/*NORMALIZACION DE DIRECCIONES*/    
       
      if('<%=(String)request.getSession().getAttribute("validaDireccion")%>' == '0' ){
            if('<%=request.getAttribute("clientIdentification")%>'!="0"){
                $("#btnNormalizarDirecciones").show();
            }
             $("#btnProcesar").attr("disabled",true);
     }
      /*NORMALIZACION DE DIRECCIONES END*/  
	  
    if(document.getElementById("tipoDepositoStr").value="<%=deposit_garantia%>" &&
       "<%=deposit_garantia%>"!=null && "<%=deposit_garantia%>"!="null"
       ){
        //Renderiza a dos decimales
        roundNumber(document.forms[0].txtGuaranteeCost.value);   
        //se sobreecribe el tipo de depósito como renta adelantada
        //o depósito en garantía: "según el combo"
        document.getElementById("tipoDepositoStr").value=document.forms[0].txtOrderStatus.value;        
    }
    if(<%=nuevo%>==<%=renta_adelantada%> && <%=nuevo%>!=null){
        //Renderiza a dos decimales
        roundNumber(document.forms[0].txtGuaranteeCost.value);
        //Renta Adelantada
        document.getElementById("divRentaLbl").className = "LeftSubTabWhite";
        //Paul Rivera 25/08/2014 pone el valor de cadena en el combo "lugar de pago"
        //en el caso de renta adelantada el valor será de el id
        //oculta controles
        $('#divRentaLbl').css("display","none");
        $('#divRentaTxt').css("display","none");
        document.getElementById("divLuPagoGaranLbl").className = "LeftSubTabWhite";
        //se oculta el combo "lugar de pago"
        $('#divLuPagoGaranLbl').css("display","none");
        $('#divLuPagoGaranCmb').css("display","none");
        document.forms[0].txtGuaranteeVoucher.value="<%=putVoucher%>";
        document.getElementById("lugarPagoStr").value="<%=lugarPagoRA%>";
    }
    $(function() {  
        $("select#cmbTipDeposito").change(function() {
            var variable = $(this).attr("value");
            var sStatusGarranty='<%=Constant.P_ORDER_DEP_GUARANTEE%>';
            if(document.forms[0].estadoOrdenSearch.value==sStatusGarranty){
                if(variable==<%=renta_adelantada%>){
                    //Renta Adelantada
                    document.getElementById("divRentaLbl").className = "LeftSubTabWhite";
                    //Paul Rivera 25/08/2014 pone el valor de cadena en el combo "lugar de pago"
                    //en el caso de renta adelantada el valor será de el id
                    document.getElementById("lugarPagoStr").value="<%=renta_adelantada_cadena_id%>";
                    //se sobreecribe el tipo de depósito como renta adelantada
                    document.getElementById("tipoDepositoStr").value="<%=renta_adelantada%>";
                    //oculta controles
                    $('#divRentaLbl').css("display","none");
                    $('#divRentaTxt').css("display","none");
                    document.getElementById("divLuPagoGaranLbl").className = "LeftSubTabWhite";
                    //se oculta el combo "lugar de pago"
                    $('#divLuPagoGaranLbl').css("display","none");
                    $('#divLuPagoGaranCmb').css("display","none");                
                    //Paul Rivera 25/08/2014 se graba SYSDATE en el control del calendario
                    <%
                        String today="";
                         
                            NpOrderService servicio=new NpOrderService();
                            //Conversión a formato dd/mm/yyyy
                            today=DateUtils.convertFechaFormatoSimple(servicio.getTodayRent());
                         
                    %>
                     document.forms[0].txtDateGuaranteePayment.value="<%=today%>";
                     document.forms[0].txtGuaranteeVoucher.value="<%=putVoucher%>";
                }
                if(variable==<%=deposit_garantia%>){
                    document.forms[0].txtGuaranteeVoucher.value="";
                    //Depósito en Garantía
                    //oculta el option "Cadena"
                    document.getElementById("divRentaLbl").className = "LeftSubTab";
                    document.getElementById("tipoDepositoStr").value=<%=deposit_garantia%>;
                    ///document.getElementById("lugarPagoStr").value="";
                    $('#divRentaLbl').css("display","block");
                    $('#divRentaTxt').css("display","block");
                    document.getElementById("divLuPagoGaranLbl").className = "LeftSubTab";
                    $('#divLuPagoGaranLbl').css("display","block");
                    $('#divLuPagoGaranCmb').css("display","block");
                    //se pone en blanco para que poder poner una fecha nueva
                    document.forms[0].txtDateGuaranteePayment.value="";
                }
            }
        })
        $("select#cmbPaymentSite").change(function() {
            var variabl = $(this).attr("value");            
            if(variabl==<%=deposit_nextel_value%>){
                //Nextel
                document.getElementById("lugarPagoStr").value=<%=deposit_nextel_id%>;
            }
            if(variabl==<%=deposit_interbank_value%>){
                //Interbank
               document.getElementById("lugarPagoStr").value=<%=deposit_interbank_id%>;
            }
            if((variabl!=<%=deposit_interbank_value%>)&&(variabl!=<%=deposit_nextel_value%>)){
                document.getElementById("lugarPagoStr").value="";
            }            
        })          
    })  
});
//FBERNALES - DEPOSITO EN GARANTIA 26/08/2014
$( function() {
 /*   
 $("select#cmbPaymentSite").change(function(){
   var labelInterbank = '<%=Constant.DEPOSITO_INTERBANK_LABEL%>';
    
    if (document.forms[0].txtGuaranteeVoucher.value.length != 8 && $('#cmbPaymentSite').children(':selected')[0].label==labelInterbank){
	flag = false;
        alert ("El número de transacción debe contener 8 dígitos.");
        document.forms[0].txtGuaranteeVoucher.focus();
    } 
 });
 $( "#txtGuaranteeVoucher" ).blur(function() {
    var labelInterbank = '<%=Constant.DEPOSITO_INTERBANK_LABEL%>';
    
    if (this.value.length != 8 && $('#cmbPaymentSite').children(':selected')[0].label==labelInterbank){
	flag = false;
        alert ("El número de transacción debe contener 8 dígitos.");
        document.forms[0].txtGuaranteeVoucher.focus();
    }
  });
  */
 $('.two-digits').keyup(function(){
        var val = this.value;
        var re = /^([0-9]+[\.]?[0-9]?[0-9]?|[0-9]+)$/g;
        var re1 = /^([0-9]+[\.]?[0-9]?[0-9]?|[0-9]+)/g;
        if (re.test(val)) {
            //do something here
    
        } else {
            val = re1.exec(val);
            if (val) {
                this.value = val[0];
            } else {
                this.value = "";
            }
        }   
 });
});
//FBERNALES - DEPOSITO EN GARANTIA 26/08/2014

//NORMALIZACION DE DIRECCIONES

function mostrarNormalizacionDirecciones(){
    var sele = document.getElementById('cmbDocumentType');
    var tex = sele.options[sele.selectedIndex].text;
    var tipoDoc = tex.replace(/\./g,'');
    var numOrder = document.getElementById('hidOrderId').value;
    var numdoc = document.getElementById('txtCustomerDocumentNumber').value;
    cargarPopupNormalizacion(tipoDoc,numdoc,numOrder,null,null);
}

 function normalizacionOK(){
    $("#btnProcesar").attr("disabled",false);
    if(document.getElementById('btnNormalizarDirecciones')!=null){
        document.getElementById('btnNormalizarDirecciones').style.display = 'none';
    }
 }
 
 function errorNormalizacion(){
    $("#btnProcesar").attr("disabled",false);
    if(document.getElementById('btnNormalizarDirecciones')!=null){
        document.getElementById('btnNormalizarDirecciones').style.display = 'none';
    }
 }
 
       
 /*NORMALIZACION DE DIRECIONES END*/
</script>
<html:form action="/OrderAction.do" method="post" enctype="multipart/form-data">
<script type="text/javascript" language="javascript">
    if ('<%=request.getSession().getAttribute("digiFlag")%>' == '1') { //JTORRESC 16-02-2012 digitalizacion
        $("#manualUpload").show();
        //$("#automaticUpload").hide();
    }
</script>
<html:hidden property="metodo" />
<html:hidden property="hidOrderId" styleId="hidOrderId"/>
<html:hidden property="typeOrder" />
<html:hidden property="cmbSubCategoria" />
<html:hidden property="iFlagSubmitImg" value="0"/>
<html:hidden property="estadoOrdenSearch"/>
<html:hidden property="orderDate" styleId="orderDate" />
<html:hidden property="idOrderManual" />
<html:hidden property="multipleOrderIdManual" />
<html:hidden property="multipleManual" />
<html:hidden property="errorNoBio" />
<html:hidden property="initOrder" />

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
      <td height="22" colspan="4" class="PortletHeaderColor"><div class="PortletHeaderText">&nbsp;&nbsp;Detalle Orden de Venta</div></td>
    </tr>
    <tr class="ListRow1">
      <td colspan="4" class="PortletText1">Informaci&oacute;n Cliente </td>
    </tr>
    <tr class="ListRow1">
      <td width="21%" class="LeftSubTab"><strong>Documento</strong></td>
      <td width="18%">
          <div align="left">
                                 
              <%
              String idDocumento = (String)request.getSession().getAttribute("Id_documento");
              %>
              <bean:define id="documento" name="OrderForm" property="lstDocumentType"/>
              <html:select property="cmbDocumentType" styleId="cmbDocumentType" disabled="true" value="<%=idDocumento%>">
              <html:optionsCollection name="documento" value="npparameterid" label="npparametername" />
              </html:select>         
        </div></td>
      <td width="17%" class="ListRow1"><html:text property="txtCustomerDocumentNumber" styleId ="txtCustomerDocumentNumber" readonly="true" size="15" maxlength="20" styleClass="cellDisabled"/></td>
        <td width="44%">
          <div align="left">        </div></td></tr>
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Raz&oacute;n Social / Nombre </strong></td>
      <td colspan="3" class="ListRow1">
          <div align="left">
            <html:text property="txtCustomerFullName" readonly="true" size="40" maxlength="100" styleClass="cellDisabled"/>
</div>
          <div align="left">        </div></td>
      </tr>
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Promotor</strong></td>
      <td colspan="3" class="ListRow1">
      <html:text property="txtPromoter" readonly="true" size="40" maxlength="100" styleClass="cellDisabled"/>
      </td>
    </tr>
  </table>
  
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Cadena</strong></td>
      <td><html:text property="txtRetailer" readonly="true" size="20" maxlength="100" styleClass="cellDisabled"/></td>
      <td class="LeftSubTab"><strong>Sucursal</strong></td>
      <td><html:text property="txtStore" readonly="true" size="20" maxlength="100" styleClass="cellDisabled"/></td>
      <td class="LeftSubTab"><strong>Punto de Venta </strong></td>
      <td ><html:text property="txtPOS" readonly="true" size="20" maxlength="100" styleClass="cellDisabled"/></td>      
    </tr>
      
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Nro. Solicitud </strong></td>
      <td><html:text property="txtOrderNumber" styleId="txtOrderNumber" readonly="true" size="20" maxlength="100" styleClass="cellDisabled"/></td>
      
      
      <logic:notEqual name="OrderForm" property="txtOrderStatus" value="">
      <logic:notEqual name="OrderForm" property="newGuaranteeDeposit" value="true">
      <td class="LeftSubTab"><strong>Pago En Garantía</strong></td>
      <%//Paul Rivera 25/08/2014 se coloca a dos decimales%>
      <td>
      
      <!-- FBERNALES -- VALIDACION DE 2 DECIMALES/-->
     <html:text property="txtGuaranteeCost" size="20" maxlength="100" title="*" styleClass="two-digits" /> 
      </td>
      </logic:notEqual>
      <logic:equal name="OrderForm" property="newGuaranteeDeposit" value="true">
      <td class="LeftSubTab"><strong>Pago En Garantía</strong></td>
      <td>
         <!-- FBERNALES -- VALIDACION DE 2 DECIMALES/-->
        <html:text property="txtGuaranteeCost" readonly="true" size="20" styleClass="two-digits" maxlength="100" title="*"/>
        </td>
      </logic:equal>
      <td><div id="divRentaLbl"><strong>Voucher Pago Garantía </strong></div></td>      
      <td><div id="divRentaTxt"><html:text property="txtGuaranteeVoucher" size="20" value="" maxlength="100" title="*" styleId="txtGuaranteeVoucher"/></div></td>
      
      </logic:notEqual>
      <logic:equal name="OrderForm" property="txtOrderStatus" value="">
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        
      </logic:equal>      
    </tr>
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Tipo de Pago </strong></td>
      <td>
        <div align="left">
          <bean:define id="pago" name="OrderForm" property="lstPaymentType"/>          
          <logic:equal value="1" name="OrderForm" property="activarTipoPago">
          <html:select property="cmbPaymentType" disabled="true">
          <option value="0" >--Seleccionar--</option>
          <html:optionsCollection name="pago" value="npparameterid" label="npparametername" />
          </html:select>
          </logic:equal>
          <logic:notEqual value="1" name="OrderForm" property="activarTipoPago">
          <html:select property="cmbPaymentType" disabled="${statusProcesar}">
          <option value="0" >--Seleccionar--</option>
          <html:optionsCollection name="pago" value="npparameterid" label="npparametername" />
          </html:select>
          </logic:notEqual>          
          </div></td>
      <logic:notEqual name="OrderForm" property="txtOrderStatus" value="">
      <logic:equal name="OrderForm" property="newGuaranteeDeposit" value="true">
      <td class="LeftSubTab"><strong>Producto Garantía</strong></td>
      <td><html:text property="txtGuaranteeProduct" readonly="true" size="50" maxlength="100"/></td>
      <td class="LeftSubTab"><strong>SKU Producto Garantía</strong></td>
      <td><html:text property="txtGuaranteeSku" readonly="true" size="20" maxlength="100"/></td> 
      </logic:equal>
      <logic:notEqual name="OrderForm" property="newGuaranteeDeposit" value="true">
        <td class="LeftSubTab"><strong>Fecha de Pago Garantía</strong></td>
        <td><html:text property="txtDateGuaranteePayment" size="10" maxlength="10" onkeypress="mascara2(this,'/',patron2,true,event)" onblur="javascript:esFechaValida(this)"/>
        <a href="javascript:show_Calendario('forms[0].txtDateGuaranteePayment');"><img src="images/show-calendar.gif"  alt="" border="0" style="vertical-align:bottom;"></a></td>

        <bean:define id="sitiopago" name="OrderForm" property="lstPaymentSite"/>
        <td><div id="divLuPagoGaranLbl"><strong>Lugar de Pago Garantía</strong></div></td>
        <td>
        <%--Paul Rivera 25/08/2014 Inicio de combo dinámico.        
        En caso se seleccione "Depósito en Garantía", debe ocultarse un solo option de la lista--%>
        <div id="divLuPagoGaranCmb">
            <SELECT id="cmbPaymentSite" name="cmbPaymentSite">
            <option value="0">--Seleccionar--</option>
            <%for(int i=0;i<listaLugarPago.size();i++){
                NpParameter npParameter=(NpParameter)listaLugarPago.get(i);
                //EL if es para que muestre dos options en el combo, en lugar de tres
                if(!(npParameter.getNpparametervalue1()).equals(deposit_cadena_value)){ %>
                    <OPTION id="<%=npParameter.getNpparameterid()%>" value="<%=npParameter.getNpparametervalue1()%>" label="<%=npParameter.getNpparametername()%>"/>
                <%}%>
            <%}%>
            </SELECT>
        </div>
        <%--Paul Rivera 25/08/2014 Fin de combo dinámico--%>
        </td>   
      </logic:notEqual>  
      </logic:notEqual>
      <logic:equal name="OrderForm" property="txtOrderStatus" value="">      
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>       
      </logic:equal>
    </tr>
<tr class="ListRow1">
        <!--Paul Rivera 14/08/2014. Inicio label: Se oculta-->
        <logic:notEqual name="OrderForm" property="txtOrderStatus" value="">
        <td class="LeftSubTab"><strong>Tipo de Dep&oacute;sito</strong></td>
        </logic:notEqual>
        <logic:equal name="OrderForm" property="txtOrderStatus" value="">
        <td></td>
        </logic:equal>
        <!--Paul Rivera 14/08/2014. Fin label: Se oculta-->
        <td>
        <!--Paul Rivera 07/08/2014. Inicio de Combo: Deposito en Garantia/Renta Adelantada-->
        <logic:notEqual name="OrderForm" property="txtOrderStatus" value="">                        
            <bean:define id="myid" name="OrderForm" property="lstTipoDeposito" type="java.util.List<NpParameter>"/>            
            <html:select property="txtOrderStatus" styleId="cmbTipDeposito">
                <html:optionsCollection name="myid" value="npparameterid" label="npparametername"/>
            </html:select>
        </logic:notEqual>
         <!--Paul Rivera 07/08/2014. Fin de Combo: Deposito en Garantia/Renta Adelantada-->
        </td>
        <td>
        <!--Paul Rivera 14/08/2014. Inicio de hiddens-->
        <input type="hidden" id="tipoDepositoStr" name="tipoDepositoStr" value="<%=deposit_garantia%>"/>
        <input type="hidden" id="lugarPagoStr" name="lugarPagoStr" value=""/>
        <!--Paul Rivera 14/08/2014. Fin de hiddens-->
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>       
        <td>&nbsp;</td>      
    </tr>
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Voucher Item(s) de Orden</strong></td>
      <td>
        <logic:equal value="1" name="OrderForm" property="activarVoucher">
        <html:text property="txtVoucher" size="20" maxlength="50" disabled="true" />
        </logic:equal>     
        <logic:notEqual value="1" name="OrderForm" property="activarVoucher">
        <html:text property="txtVoucher" size="20" maxlength="50" disabled="${statusProcesar}"/>
        </logic:notEqual>
        </td>
      <td colspan="4" class="ListRow1">
        <div id="div_btnAsociar" style="<%=request.getAttribute("statusBtnProcesar")%>">
        <input type="button" name="Submit4" value="Asociar" onClick="javascript:AsociarVoucher()"/>
        </div>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>
    <tr class="ListRow1">
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <logic:notEqual name="OrderForm" property="txtOrderStatus" value="">
            <logic:equal name="OrderForm" property="newGuaranteeDeposit" value="true">
            <td class="LeftSubTab"><strong>Cantidad Productos Garantía</strong></td>
            <td><html:text property="txtGuaranteeQuantity" readonly="true" size="20" maxlength="100"/></td>
            <td class="LeftSubTab"><strong>Moneda Depósito Garantía</strong></td>
            <td><html:text property="txtmonedaDepo" readonly="true" size="20" maxlength="100" title="*"/></td>
            </logic:equal>
            <logic:notEqual name="OrderForm" property="newGuaranteeDeposit" value="true">
            <!--td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td-->
            </logic:notEqual>
        </logic:notEqual>
        <logic:equal name="OrderForm" property="txtOrderStatus" value="">
        <!--td>&nbsp;</td>
        <td>&nbsp;</td>    
        <td>&nbsp;</td>
        <td>&nbsp;</td-->
        </logic:equal>        
    </tr>
    
    
    <tr class="ListRow1"   style="<%=request.getSession().getAttribute("tdflagAnticipado")%>"  >
      <td width="20%" style="font-size:10px" class="LeftSubTab"><strong>Pago Total Anticipado</strong></td>      
      <td width="10%" style="font-size:10px"> <html:text property="totalAproximadoProrrateo" disabled="true" size="20" maxlength="100" />
      <td width="10%" style="font-size:10px"></td>
      <td width="10%" style="font-size:10px"></td>
      
      <td width="10%" style="font-size:10px">Monto Total </td>
      <td width="10%" style="font-size:10px"><html:text property="montoTotal" disabled="true" size="20" maxlength="100" />          
      <td width="10%" style="font-size:10px"></td>
      <td width="10%"></td>      
      <td width="10%"></td>
    </tr>
    
    
    
  </table>
  
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td><div align="center"></div>
          <div align="left" class="PortletText1">Detalle de Orden </div></td>
    </tr>
  </table>
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="4%" class="LeftSubTab"><div align="center">
        <label/>
      </div></td>
      <td width="4%" class="LeftSubTab"><div align="center"><strong>Nro. Voucher </strong></div></td>
      <td width="11%" class="LeftSubTab"><div align="center"><strong>Promoci&oacute;n</strong></div></td>
      <td width="11%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>
      <td width="11%" class="LeftSubTab"><div align="center"><strong>Precio(S/.)</strong></div></td>
      <td width="9%" class="LeftSubTab"><div align="center"><strong>Soluci&oacute;n</strong></div></td>
      <td width="9%" class="LeftSubTab"><div align="center"><strong>Plan</strong></div></td>      
      
      <!-- Ricardo -->
      <td width="9%" class="LeftSubTab" style="<%=request.getSession().getAttribute("tdflagAnticipado")%>"><div align="center"><strong>SKU <br/> Pago <br/> Anticipado</strong></div></td>      
      <td width="9%" class="LeftSubTab" style="<%=request.getSession().getAttribute("tdflagAnticipado")%>"><div align="center"><strong>Pago <br/> Anticipado</strong></div></td>
           
      <td width="12%" class="LeftSubTab"><div align="center"><strong>Modelo</strong></div></td>
      <td width="14%" class="LeftSubTab"><div align="center"><strong>IMEI</strong></div></td>
      <td width="12%" class="LeftSubTab"><div align="center"><strong>SIM</strong></div></td>
      <%
    if(request.getSession().getAttribute("TypeOrder").equals("Portabilidad"))                  
     { %>
     <td width="12%" class="LeftSubTab"><div align="center"><strong>Portabilidad</strong></div></td>  
    <% } else { %>
        <td width="12%" class="LeftSubTab"><div align="center"><strong>Regi&oacute;n</strong></div></td>
        <td width="12%" class="LeftSubTab"><div align="center"><strong>Provincia</strong></div></td>
        <td width="12%" class="LeftSubTab"><div align="center"><strong>Distrito</strong></div></td>
    <%}%>
      </tr>
    <logic:empty name="OrderForm" property="listOrderDetails">
    <tr><td colspan="9" class="ListRow1">
    <div align="center">No se encontraron Resultados</div>
    </td></tr>
    </logic:empty>
    
    <% java.lang.String productoAnterior = "ninguna"; 
       java.lang.Integer contCheck =0;
    %>
      
    <logic:notEmpty name="OrderForm" property="listOrderDetails">
    <logic:iterate id="order" property="listOrderDetails" name="OrderForm" indexId="indice">
    <bean:define id="codorder" name="order" property="orderItemId"/>
    <bean:define id="nroVoucher" name="order" property="voucher"/>    
    <!--bean:define id="codorder" name="order" property="an_nporderitemid"/-->
   <!--bean:define id="nroVoucher" name="order" property="av_npvoucher"/--> 
   
    <tr class="ListRow1">    
    
    <% if(!codorder.toString().equals(productoAnterior)){%>
      <td><div align="center">
      <input type="hidden"  name="hidcodorder[]" value="<bean:write name="codorder"/>" />
      
      <%-- if(nroVoucher.toString().equals("")||(nroVoucher==null)){--%>
      <input type="checkbox" name="chkAsociar" id="chkAsociar" value="<%= contCheck++ %>">
      <%-- } --%>
      
      </div></td>
      <td>
      
      <!--logic:equal name="order" property="av_npVoucher" value=""-->
      <logic:equal name="order" property="voucher" value="">
      <div align="center">
      <input type="text"  name="txtVoucherTemp[]" id="txtVoucherTemp[]" size="10" readonly="readonly" class="cellDisabled"/><input type="hidden"  name="hidVoucher[]" />
      </div>
      </logic:equal>
      
      <logic:notEqual name="order" property="voucher" value="">
      <div align="center">
      <bean:write name="order" property="voucher"/><input type="hidden"  name="hidVoucher[]" value="<bean:write name="order" property="voucher"/>" /></div>
      </logic:notEqual>
       
      </td>
      <td><div align="center"><bean:write name="order" property="productName"/></div></td>
      <td><div align="center"><bean:write name="order" property="sku"/></div></td>
      <td><div align="right"><bean:write name="order" property="amount"/></div></td>
      <%}
      else
      %>      
      <td></td><td></td><td></td><td></td><td></td>
      <% productoAnterior = codorder.toString();%>
      <td><div align="center"><bean:write name="order" property="solution"/></div></td>
      <td><div align="center"><bean:write name="order" property="planName"/></div></td>            
      <!-- Rquispe -->
      <td style="<%=request.getSession().getAttribute("tdflagAnticipado")%>" ><div align="center"><bean:write name="order" property="skuprorrateo"/></div></td>      
      <td style="<%=request.getSession().getAttribute("tdflagAnticipado")%>" ><div align="center"><bean:write name="order" property="aproximadoprorrateo"/></div></td>                  
      <td><div align="center"><bean:write name="order" property="productModel"/></div></td>
      <td><div align="center"><bean:write name="order" property="imei"/></div></td>
      <td height="20"><div align="center"><input name='txtIdItemArray[]' type='hidden'   value="<bean:write name="order" property="orderItemId"/>"><bean:write name="order" property="sim"/></div></td>
    <!-- <td height="20"><div align="center"><a id="portabilidad_link" href="javascript:void(0)" onclick="CargarDataAjax();">Portabilidad</a></div></td> !-->
        <%
    if(request.getSession().getAttribute("TypeOrder").equals("Portabilidad"))                  
     { %>
      <td height="20"><div align="center"><a id="portabilidad_link" class="portabilidad_link" href="#">Portabilidad</a></div></td> 
     <% } else{ %>        
        <td><div align="center"><bean:write name="order" property="nombreZona"/></div></td>  
        <td><div align="center"><bean:write name="order" property="nombreProvincia"/></div></td> 
        <td><div align="center"><bean:write name="order" property="nombreDistrito"/></div></td> 
     <%
      }
     %>
    </tr>

     </logic:iterate>
    </logic:notEmpty>  
      
  </table>
  
  <%-- Información de Verificaci&oacute;n de Identidad > detalle --%>
  <table width="100%"  border="0"> 
      <tr>
          <td colspan="8"> 
          </td>
      </tr>
      <tr class="ListRow1">
          <td><div align="center"></div>
              <div align="left" class="PortletText1">Verificaci&oacute;n de Identidad > detalle</div></td>
      </tr>
      <tr>
          <td colspan="8"> 
          </td>
      </tr>
  </table>

  <table width="100%"  border="0">    
      <tr class="ListRow1">
          <td class="LeftSubTab"><strong>Nombres y Apellidos:</strong></td>
          <td><html:text size="40" maxlength="100" property="identityVerificationDetailBean.nombresApellidos" disabled="true" /></td>
          <td class="LeftSubTab"><strong>Tipo de documento:</strong></td>
          <td><html:text size="20" maxlength="100" property="identityVerificationDetailBean.tipoDocumento" disabled="true" /></td>
          <td class="LeftSubTab"><strong>Nro. de documento:</strong></td>
          <td><html:text size="20" maxlength="100" property="identityVerificationDetailBean.nroDocumento" disabled="true" /></td>
      </tr>
      <tr class="ListRow1">
          <td class="LeftSubTab"><strong>Tipo de verificaci&oacute;n exitosa:</strong></td>
          <td><html:text size="30" maxlength="100" property="identityVerificationDetailBean.tipoVerificacionExitosa" disabled="true" /></td>
          <td class="LeftSubTab"><strong>Registrado por:</strong></td>
          <td><html:text size="20" maxlength="100" property="identityVerificationDetailBean.registradoPor" disabled="true" /></td>
          <td class="LeftSubTab"><strong>Modificado por:</strong></td>
          <td><html:text size="20" maxlength="100" property="identityVerificationDetailBean.modificadoPor" disabled="true" /></td>
      </tr>
  </table>

  <table width="100%"  border="0">
      <tr>
          <td colspan="5"> 
          </td>
      </tr>
      <tr><td colspan="5" class="ListRow1">
          <div align="center"><strong>Historial de validaci&oacute;n biometrica</strong></div>
      </td></tr>
      <tr class="ListRow1">
          <td width="10%" class="LeftSubTab"><div align="center"><strong>Id</strong></div></td>
          <td width="20%" class="LeftSubTab"><div align="center"><strong>Resultado de verificaci&oacute;n</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Origen</strong></div></td>
          <td width="20%" class="LeftSubTab"><div align="center"><strong>Fecha de verificaci&oacute;n</strong></div></td>
          <td width="35%" class="LeftSubTab"><div align="center"><strong>Motivos de verificaci&oacute;n</strong></div></td>
      </tr>
      
      <logic:empty name="OrderForm" property="identityVerificationDetailBean.listBiometricValidation">
        <tr><td colspan="5" class="ListRow1">
        <div align="center">No se encontraron registros</div>
        </td></tr>
      </logic:empty>
      
      <% java.lang.Integer counterBiometricValidation =0;%>
      
      <logic:notEmpty name="OrderForm" property="identityVerificationDetailBean.listBiometricValidation">
        <logic:iterate id="order" property="identityVerificationDetailBean.listBiometricValidation" name="OrderForm" indexId="indice">
            <tr class="ListRow1">
                <td><div align="center"><%= ++counterBiometricValidation %></div></td>
                <td><div align="center"><bean:write name="order" property="verificationResult"/></div></td>
                <td><div align="center"><bean:write name="order" property="source"/></div></td>
                <td><div align="center"><bean:write name="order" property="verificationDate" format="dd/MM/yyyy hh:mm:ss a" /></div></td>
                <td><div align="center"><bean:write name="order" property="verificationMotive"/></div></td>
            </tr>
        </logic:iterate>
      </logic:notEmpty>
  </table>

  <table width="100%"  border="0">
      <tr>
          <td colspan="6"> 
          </td>
      </tr>
      <tr><td colspan="6" class="ListRow1">
          <div align="center"><strong>Historial de validaci&oacute;n no biometrica</strong></div>
      </td></tr>
      <tr class="ListRow1">
          <td width="10%" class="LeftSubTab"><div align="center"><strong>Id</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Resultado de verificaci&oacute;n</strong></div></td>
          <td width="10%" class="LeftSubTab"><div align="center"><strong>Origen</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Fecha de verificaci&oacute;n</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Nro. de pregunta acertada</strong></div></td>
          <td width="35%" class="LeftSubTab"><div align="center"><strong>Motivos de verificaci&oacute;n</strong></div></td>
      </tr>

      <logic:empty name="OrderForm" property="identityVerificationDetailBean.listNoBiometricValidation">
        <tr><td colspan="6" class="ListRow1">
        <div align="center">No se encontraron registros</div>
        </td></tr>
      </logic:empty>
      
      <% java.lang.Integer counterNoBiometricValidation =0;%>
    
      <logic:notEmpty name="OrderForm" property="identityVerificationDetailBean.listNoBiometricValidation">
        <logic:iterate id="order" property="identityVerificationDetailBean.listNoBiometricValidation" name="OrderForm" indexId="indice">
            <tr class="ListRow1">
                <td><div align="center"><%= ++counterNoBiometricValidation %></div></td>
                <td><div align="center"><bean:write name="order" property="verificationResult"/></div></td>
                <td><div align="center"><bean:write name="order" property="source"/></div></td>
                <td><div align="center"><bean:write name="order" property="verificationDate" format="dd/MM/yyyy hh:mm:ss a" /></div></td>
                <td><div align="center"><bean:write name="order" property="nroPreguntaAcertada"/></div></td>
                <td><div align="center"><bean:write name="order" property="verificationMotive"/></div></td>
            </tr>
        </logic:iterate>
      </logic:notEmpty>
  </table>
  <!--Detalle de verificacion Externa -->
  <table width="100%"  border="0">
      <tr>
          <td colspan="8"> 
          </td>
      </tr>
      <tr><td colspan="8" class="ListRow1">
          <div align="center"><strong>Historial de Verificaci&oacute;n Externa</strong></div>
      </td></tr>
      <tr class="ListRow1">
          <td width="10%" class="LeftSubTab"><div align="center"><strong>Id</strong></div></td>
          <td width="13%" class="LeftSubTab"><div align="center"><strong>ID verificaci&oacute;n externa</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Resultado de verificaci&oacute;n</strong></div></td>
          <td width="10%" class="LeftSubTab"><div align="center"><strong>Origen</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Fecha de verificaci&oacute;n</strong></div></td>
          <td width="10%" class="LeftSubTab"><div align="center"><strong>Documento</strong></div></td>
          <td width="18%" class="LeftSubTab"><div align="center"><strong>Nombre Persona</strong></div></td>
          <td width="15%" class="LeftSubTab"><div align="center"><strong>Proveedor</strong></div></td>
      </tr>
  
      <logic:empty name="OrderForm" property="identityVerificationDetailBean.listVerificationExternal">
        <tr><td colspan="8" class="ListRow1">
        <div align="center">No se encontraron registros</div>
        </td></tr>
      </logic:empty>
      
      <% java.lang.Integer counterVerificationExternalBean =0;%>
    
      <logic:notEmpty name="OrderForm" property="identityVerificationDetailBean.listVerificationExternal">
        <logic:iterate id="order" property="identityVerificationDetailBean.listVerificationExternal" name="OrderForm" indexId="indice">
            <tr class="ListRow1">
                <td><div align="center"><%= ++counterVerificationExternalBean %></div></td>
                <td><div align="center"><bean:write name="order" property="npverificationextcod"/></div></td>
                <td><div align="center"><bean:write name="order" property="verificationResult"/></div></td>
                <td><div align="center"><bean:write name="order" property="source"/></div></td>
                <td><div align="center"><bean:write name="order" property="verificationDate" format="dd/MM/yyyy hh:mm:ss a" /></div></td>
                <td><div align="center"><bean:write name="order" property="nroDocumento"/></div></td>
                <td><div align="center"><bean:write name="order" property="nombresApellidos"/></div></td>
                <td><div align="center"><bean:write name="order" property="npprovider"/></div></td>
            </tr>
        </logic:iterate>
      </logic:notEmpty>
  </table>
  <!-- fin -->
  
  <% if (new Integer(request.getSession().getAttribute("digiFlag").toString()) == 1){ //JTORRESC 16-02-2012 digitalizacion %>
  <div id="digitalizacion" style="<%=request.getSession().getAttribute("statusSeccionDigitalizacion")%>">
  <input type="hidden" id="sendFilesExecuted" />
  <table width="100%"  border="0">    
  <tbody style="display:none">
    <tr class="ListRow1">
      <td colspan="4" class="PortletText1">Digitalizaci&oacute;n de Documentos</td>
    </tr>
    <tr class="ListRow1">
      <td class="LeftSubTab"><strong>Carga Automática: </strong></td>
      <td><input name="radiobutton" type="radio" value="radiobutton" id="rbAutomaticUpload" ></td>
    </tr>
    <tr class="ListRow1">
      <td width="13%" class="LeftSubTab"><strong>Carga Manual:</strong></td>
      <td width="87%"><label>
        <input name="radiobutton" type="radio" value="radiobutton" id="rbManualUpload" checked="true">        
      </label></td>
      </tr> 
      </tbody>
  </table>
  
  <div id="manualUpload">
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="100%" colspan="4" class="PortletText1">Digitalizaci&oacute;n de Documento - Carga de Imagenes: </td>
    </tr>
  </table>  
  <table width="100%"  border="0" id="tbImagenesDigi"> 
  <tbody id="ImagenesDigi">

    <logic:notEmpty name="OrderForm" property="lstImages">
    <tr class="ListRow1">
      <td width="14%" colspan="2"></td>
      <td width="44%" colspan="6">
        <div align="left">                
        <!-- ###### INICIO N_O000026564-[Migración Applet]  ###### -->
        <a href="javascript:cloneRow();" style="visibility:hidden"><img src="images/netvibes.gif" width="20" height="20" border="0" title="Detalle"/></a>
               
        <html:text property="strDocTypesId" size="20" maxlength="100" style="visibility:hidden" />        
        <html:text property="strDocTypesName" size="20" maxlength="100" style="visibility:hidden" />                
        <html:text property="strDocTypesPaths" size="20" maxlength="100" style="visibility:hidden" />
        <html:text property="strFileName" size="20" maxlength="100" style="visibility:hidden" />        
        
        <select id="toClon" name="toClon" style="visibility:hidden">
        
        <logic:iterate id="image" property="lstImages" name="OrderForm" indexId="indice">
        <option value='<bean:write name="image" property="npparametervalue1"/> '>    
                <bean:write name="image" property="npparametername"/>
        </option>
         </logic:iterate>         
        </select>
        <!-- ###### Fin N_O000026564-[Migración Applet]  ###### -->
        </div>
      </td>
    </tr>
    
 
    <logic:iterate id="image" property="lstImages" name="OrderForm" indexId="indice">
        <tr class="ListRow1" id="rowToClone">
          <td width="14%" class="LeftSubTab">
            <strong><bean:write name="image" property="npparametername"/></strong>
            
            
          </td> 
          <td>     
            <!-- ###### INICIO N_O000026564-[Migración Applet]  ###### -->
                <html:file property='<%="file["+indice+"]" %>' accept="image/jpeg" />
                 <input type="hidden" id="imageFielHidden" value='<%=indice %>' />
            <!-- ###### Fin N_O000026564-[Migración Applet]  ###### -->
          </td>
          <td><label>          
            <!--<a href="javascript:showImage(<%=indice%>)"><img src="images/viewDetail.gif" width="16" height="15" border="0" title="Detalle"/></a-->           
          </label></td>
          <td><label>
            <a id="deleteRow" style="visibility:hidden" href="javascript:cleanImageField(<%=indice%>, '<bean:write name="image" property="npparametername"/>,<bean:write name="image" property="npparametervalue1"/>')"><img src="images/Eliminar.gif" width="16" height="15" border="0" /></a>        
          </label></td>          
          <td width="70%"> </td>
        </tr>
    </logic:iterate>  
    </logic:notEmpty>    
    </tbody>
  </table>
  </div> 
  <!--<div id="automaticUpload">
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="100%" colspan="4" class="PortletText1">Digitalizaci&oacute;n de Documentos - Carga Automática: </td>
    </tr>
  </table>  
  <table width="100%"  border="0">
    <tr class="ListRow1">  
      <td width="13%"><INPUT type="button" value="Cargar archivos" onClick = "sendAutomaticallySelectedFiles()">        </td>
      <td><label>
            
          </label>
      </td>          
    </tr>
  </table>
  
  </div>-->
  </div>    
  <% }//JTORRESC 16-02-2012 digitalizacion %>
  <table width="100%"  border="0">
    <tr>
      <td width="46%">
		<div align="right">
			<%
            String statusBtnProcesar = (String)request.getAttribute("statusBtnProcesar");
            if("display:inline".equals(statusBtnProcesar)) {
            %>
				<!-- Normalizacion de Direcciones -->
				<div id="div_btnNormalizarDirecciones">
					<input type="button" id="btnNormalizarDirecciones" value="Normalizar Direccion" onClick="javascript:mostrarNormalizacionDirecciones()" style="display:none;">
				</div>
				<!-- FIN -->
				<div id="div_btnValdiacionBiometrica">
        <!--<input type="button" name="Submit" value="Procesar" onClick="javascript:ActualizarOrdenVenta()">-->
					<input type="button" id="btnLanzarValidacionCliente" value="Identificacion Cliente" onClick="javascript:mostrarValdiacionBiometrica()" style="display:none;">
        </div>
			<% } %>
		</div>
	  </td>
      <td width="12%"><div align="center">
        <div id="div_btnProcesar" style="<%=request.getAttribute("statusBtnProcesar")%>">
        <!--<input type="button" name="Submit" value="Procesar" onClick="javascript:ActualizarOrdenVenta()">-->
        <input type="button" id="btnProcesar" name="Submit" value="Procesar" onClick="javascript:ValidateTimeLimitExceeded()">
        
        </div>
      </div></td>
      <td width="12%"><div align="center">
        <input type="button" name="Submit2" value="Cancelar" onClick="javascript:Cancelar()">
      </div></td>
      <td width="42%">&nbsp;</td>
    </tr>
  </table>
  <p>&nbsp;</p>

</td>
    </tr>
    </table>

</td>
  </tr>
</table>
        <!-- POPUP PORTABILIDAD --> 
        
    <div id="popup_view_form" style="display:none; opacity: 0.8;" class="popup_portablity_view-overlay" align="center" tabindex='-1'> 
    <div id="box1" class="box1">       
    <h1 align="center" class="PortletHeaderText PortletHeaderColor" >Detalle de Portabilidad</h1>
        <table align="center">  
           <tr class="ListRow1"> 
                <td class="LeftSubTab"><strong>Teléfono a Portar :</strong></td>                        
                <td><label class="txtFormLogin" id="lbltelefono"></label></td>
           <tr/>
           
           <tr class="ListRow1"> 
                <td class="LeftSubTab"><strong>Origen :</strong> </td>
                <td>
                <bean:define id="idorigenview" name="OrderForm" property="lstOrigenes"/>
                                <html:select property="txtOperadoraView" disabled="true">
                                    <option value="0" >--Seleccionar--</option>
                                    <html:optionsCollection name="idorigenview" value="npparameterid" label="npparametername" />
                                </html:select>
                </td>               
           <tr/>  
           
           <tr class="ListRow1">
                <td class="LeftSubTab">                
                    <!--//FBERNALES 20/02/2015 Se cambia el tag del estado de portabilidad -->
                    <strong>Estado Portabilidad</strong>
                </td>
                <td>
                    <label class="txtFormLogin" id="lblestado"></label>
                </td>                
           <tr/>   
         <!--  <tr> 
                 <td class="LeftSubTab">  
                    <label class="txtFormLogin">Motivo de rechazo :</label>
                    <label class="txtFormLogin" id="lblmotivorechazo"></label>
                 </td>
               <tr/> 
               
               <tr> 
                 <td class="LeftSubTab">
                     <label class="txtFormLogin">Motivo adeudados :</label>
                     <label class="txtFormLogin" id="lblmotivoadeudado"></label>
                 </td>
               <tr/>
          -->
           <tr class="ListRow1"> 
               
                <td class="LeftSubTab"><strong>Tipo de Documento :</strong></td>
                <td>
               
                <bean:define id="idTipoDocumentoView" name="OrderForm" property="lstTipoDocumento"/>
                      <html:select property="txtTipoDocumentoView" disabled="true">
                         <option value="0" >--Seleccionar--</option>
                         <html:optionsCollection name="idTipoDocumentoView" value="npparameterid" label="npparametername" />
                      </html:select>
                </td> 
            <tr/>
            <tr class="ListRow1"> 
                 <td class="LeftSubTab"><strong>Numero de Documento :</strong></td>
                 <td><label class="txtFormLogin" id="lblnumerodocumento"></label></td>
            <tr/>
            <%--//Paul Rivera 09/09/2014 Inicio de motivo de rechazo--%>
            <tr class="ListRow1">
                <!--td colspan="2" width="100%"-->                    
                    <!--table cellpadding="0" cellspacing="0" width="100%"-->                    
                    <!-- //FBERNALES 20/02/2015 Se cambia el tag del Motivo de Reachazo de portabilidad -->
                    <td class="LeftSubTab"><strong> Motivo de Rechazo </strong>
                    </td>
                    <td>
                        <label class="txtFormLogin" id="lblmotivorechazo"></label>
                    </td>                    
                    <!--/table-->
                <!--/td-->
            <tr/>            
            <%--//Paul Rivera 09/09/2014 Fin de motivo de rechazo--%> 
            <%--//Paul Rivera 09/09/2014 Inicio de cedente--%>
            <tr class="ListRow1">
                 <td class="LeftSubTab"><strong>Cedente :</strong></label></td>
                 <td><label class="txtFormLogin" id="lblcedente"></label></td>
            <tr/>            
             <%--//Paul Rivera 09/09/2014 Fin de cedente--%>              
             
           <!--Inicio RPASCACIO 11-09-2014 Agregar Boton Cerrar y darle funcionalidad--> 
             <tr><td>&nbsp;</td></tr>               
                <tr class="ListRow1">                    
                    <td colspan="2" align="center">
                       <input value="Cerrar"  type="button" name="btnCerrar" id="btnCerrar" class="simplemodal-close" style="width: 100px;"/>                       
                    </td>  
              </tr>   
           <!--Fin RPASCACIO 11-09-2014 Agregar Boton Cerrar y darle funcionalidad-->                        
       </table>   
    </div>  
           
  </div> 
<logic:notEmpty scope="request" name="msgCreateOrderCrmProductSerie">
<script type="text/javascript">
    //Mensaje de confirmacion del Deposito en Garantia
    var messageProductSerie = "<%=(String)request.getAttribute("msgCreateOrderCrmProductSerie")%>";
    alert(messageProductSerie);
</script>
</logic:notEmpty>
<logic:notEmpty scope="request" name="MensajeDeposito">
<script type="text/javascript">
    //Mensaje de confirmacion del Deposito en Garantia
    var messageConfirmation = "<%=(String)request.getAttribute("MensajeDeposito")%>";
    alert(messageConfirmation);
</script>
</logic:notEmpty>
<logic:notEmpty scope="request" name="MsgFileSize">
<script type="text/javascript">
    //Mensaje de confirmacion file size
    alert("El tamaño de la imagen es superior al permitido (Ejm:120 KB)");
    
    //Este if permite que no se muestren controles cuando aparece el mensaje de alerta.
    if(document.getElementById('cmbTipDeposito') && document.getElementById('cmbTipDeposito').value == '<%=renta_adelantada%>'){
        if (document.getElementById('divRentaLbl')) {document.getElementById('divRentaLbl').style.display = 'none';}
        if (document.getElementById('divRentaTxt')) {document.getElementById('divRentaTxt').style.display = 'none';}
        if (document.getElementById('divLuPagoGaranLbl')) {document.getElementById('divLuPagoGaranLbl').style.display = 'none';}
        if (document.getElementById('divLuPagoGaranCmb')) {document.getElementById('divLuPagoGaranCmb').style.display = 'none';}
        //if (document.getElementById('automaticUpload')) {document.getElementById('automaticUpload').style.display = 'none';}
    }

</script>
</logic:notEmpty>

</html:form>
<%@include file="ValidacionBiometrica.jsp"%>
<%@include file="ValidacionDireccionNormalizada.jsp" %>
<%@include file="ValidacionDireccionJuridica.jsp" %>
</body>
</html>