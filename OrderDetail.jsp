<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.nextel.utilities.Constant"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Entel Perú</title>
<link type="text/css" rel="stylesheet" href="css/Source.css">
<script type="text/javascript" language="JavaScript1.2" src="js/BasicOperations.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="js/stm31.js"></script>
    <script type="text/javascript" src="js/modernizr.custom.2.6.2.min.js"></script> 
    <script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="js/2jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery.simplemodal.js"></script>
    <link type="text/css" rel="stylesheet" href="css/2jquery-ui.css" />
    <link type="text/css" rel="stylesheet" href="css/jquery-ui-1.10.4.min.css">  
    <link type='text/css' href='css/modal.css' rel='stylesheet' media='screen' />
   
  <style type="text/css">
  .ui-autocomplete-term { font-weight: bold; color: blue; }
  
  .ui-autocomplete-loading {
    background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
  }
  
    .ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
  }
  /* IE 6 doesn't support max-height
   * we use height instead, but this forces the menu to always be this tall
   */
  * html .ui-autocomplete {
    height: 100px;
  }
  .comboProvincia, .comboRegion, .comboDistrito {width: 100%}
  </style>   
   
</head>

<body onload="OcultarAgregar();">
<script type="text/javascript" language="javascript">


 //PRY-0890 - JESPINOZA - CERRAR VENTANA

  function OcultarAgregar()
  {
    window.opener.document.getElementById('btnOpenAddItem').disabled = true;
    //window.opener.$("#btnOpenAddItem").attr("disabled","disabled");
  }
  //FIN PRY-0890 - JESPINOZA
var cont_item=0;
var total_items=0;
var carga_combo=0;                             
        
     var flagActiveBtnOpenAddItem = 1;
    $( window ).unload(function() {
        if(flagActiveBtnOpenAddItem == 1){
        window.opener.$("#btnOpenAddItem").removeAttr("disabled");
        }
    });
        
        $(document).ready(function()
        {
			
    //LESCOBAR
    var division=document.getElementsByName("cmbDivision")[0].value;
    var longitud=9;
    if(division==='8'){
      longitud=8;
    }
    document.getElementById("txtnumeroPortabilidad").maxLength=longitud;
    
	//Mostrar ventana Modal cuando se hace clic en Iniciar
	$(".login_link").click(
            function() {
            var indice=$(".login_link").index(this);
            var checks = document.getElementsByName('checkbox');
            
            checks[indice].checked = true ;
              if(SeleccionarProductoPorta(true)){
            // alert($.get( $(this).attr('value')));
             document.getElementById('txtnumeroPortabilidad').value="";    
             var txtTelefonoAPortar = document.getElementById('txtnumeroPortabilidad').value ; 
           //  document.getElementById('cmbCedente').value="";    
                var cmbCedente = $('select[name="txtcedente"]')[0].value;
                //var cmbCedente = document.getElementById('txtcedente').value ; 
                //var cmbOrigen = document.getElementById('txtoperadora').value ;
                var cmbOrigen = $('select[name="txtoperadora"]')[0].value ;
              //INICIO--RPASCACIO 27-08-2014 
              var cmbTipoDocumento = $('select[name="txtTipoDocumento"]')[0].value;            
              var txtNumeroDocumento = document.getElementById('txtNumeroDocumento').value;
              
              //FIN--RPASCACIO 27-08-2014  
                 var frm = document.forms[0];
                 frm.indice.value =  indice;
                //("cedentePortability")[indice].value;
                 var imei = document.getElementsByName('txtIMEIArray[]')[indice].value
          //   request.getSession().setAttribute("listaModelo",orderForm.getLstModel());   
                 
          //  <%=request.getSession().getAttribute("statusSeccionDigitalizacion")%> .
            //    alert(imei);
            document.forms[0].btnSeleccionar.disabled=true; 
             var req = newXMLHttpRequest();          
              req.onreadystatechange = getReadyStateHandler(req,updatePorta);
              //txtcedente
                        req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=PortabilidadAnt&imei=" + imei+"&txtnumeroPortabilidad="+txtTelefonoAPortar+"&cmbCedente="+cmbCedente+"&cmbOrigen="+cmbOrigen+"&cmbTipoDocumento="+cmbTipoDocumento+"&txtNumeroDocumento="+txtNumeroDocumento,true);
                        req.setRequestHeader("Content-Type","application/ISO-8859-1");
                        req.send(null);
           
                document.getElementById("hddIndicePortability").value=indice;
                $('#login_form').modal();             
                }
            }
         );
             
      	$(".popup_view").click(
            function() {
                 var indice=$(".popup_view").index(this);
                 var imei = document.getElementsByName('txtImeiArray2[]')[indice].value
                 
                        var req = newXMLHttpRequest();          
                        req.onreadystatechange = getReadyStateHandler(req,ViewPorta);
                        req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=PortabilidadView&imei=" + imei,true);
                        req.setRequestHeader("Content-Type","application/ISO-8859-1");
                        req.send(null);  
                 
                $('#popup_view_form').modal();             
                }
         );  
         // INI MLORENZO: trae las provincias de una region a partir del producto y la region
		$(".validateComboRegion").change(function(){
			var idregion = $(this).val();
			var idproducto;
			var cmbProv;
			var listItem = $(this);
			
			var index =  $( "[name='txtRegionArrayFinal[]']"  ).index( listItem  );
			//alert(index);
			var idProductArray = $("[name='txtIdProductArray[]']");
			var countprd = 0;
			idProductArray.each(function(){

				if(countprd==index){
					idproducto = $(this).val();
				}
				countprd++;
			});
			
			var idProvinciaArray = $( "[name='txtProvinciaArrayFinal[]']" );
			var countprv = 0;
			idProvinciaArray.each(function(){

				if(countprv==index){
					cmbProv = $(this);
				}
				countprv++;
			});
			
			var idDistritoArray = $( "[name='txtDistritoArrayFinal[]']" );
			var countdist = 0;
			idDistritoArray.each(function(){

				if(countdist==index){
					cmbDist = $(this);
				}
				countdist++;
			});
			
			var strUrlWithParams = "<%=request.getContextPath()%>/OrderAction.do?metodo=RetornoOrderProvinciaAjax&idregion="+idregion+"&idproducto="+idproducto;
			$.ajax({  
			   type: 'GET',
			   contentType: "text/json,ISO-8859-1",
			   async:false, 
			   url: strUrlWithParams,               
			   data:  null,
			   success:function(data){
			   cmbProv.empty();
			   cmbDist.empty();
			   cmbProv.append('<option value="0" >--Seleccionar--</option>');
			   cmbDist.append('<option value="0" >--Seleccionar--</option>');
			   for(var i=0; i<data.length;i++){
			   cmbProv.append(' <option value="'+data[i].idProvincia+'" >'+data[i].nombreProvincia+'</option>');
			   }
					if(data=="Error"){
						response=false;
					}else{
						response=true;
					}
			   },
			   error: function(xhr, status, error) {
				   alert(status);
				   alert(xhr.responseText);
				   response=true;
			   }                           
			});    

		});
		
		// INI MLORENZO: trae los distritos de una provincia a partir del producto y la provincia
		$(".validateComboProvincia").change(function(){
			var idprovincia = $(this).val();
			var idproducto;
			var cmbDist;
			var listItem = $(this);
			
			var index =  $( "[name='txtProvinciaArrayFinal[]']"  ).index( listItem  );
			//alert(index);
			var idProductArray = $("[name='txtIdProductArray[]']");
			var countdist = 0;
			idProductArray.each(function(){

				if(countdist==index){
					idproducto = $(this).val();
				}
				countdist++;
			});
			
			var idDistritoArray = $( "[name='txtDistritoArrayFinal[]']" );
			var countdist = 0;
			idDistritoArray.each(function(){

				if(countdist==index){
					cmbDist = $(this);
				}
				countdist++;
			});
			
			var strUrlWithParams = "<%=request.getContextPath()%>/OrderAction.do?metodo=RetornoOrderDistritoAjax&idprovincia="+idprovincia+"&idproducto="+idproducto;
			$.ajax({  
			   type: 'GET',
			   contentType: "text/json,ISO-8859-1",
			   async:false, 
			   url: strUrlWithParams,               
			   data:  null,
			   success:function(data){
			   cmbDist.empty();			   
			   cmbDist.append('<option value="0" >--Seleccionar--</option>');
			   for(var i=0; i<data.length;i++){
			   cmbDist.append(' <option value="'+data[i].idDistrito+'" >'+data[i].nombreDistrito+'</option>');
			   }
					if(data=="Error"){
						response=false;
					}else{
						response=true;
					}
			   },
			   error: function(xhr, status, error) {
				   alert(status);
				   alert(xhr.responseText);
				   response=true;
			   }                           
			});    

		});
});      

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
          
                  $('select[name="txtCedenteview"]')[0].value=cedente;
                  //document.getElementById('txtCedenteview').value=cedente;                  
                  $('select[name="txtOperadoraView"]')[0].value=operadora;
                  //document.getElementById('txtOperadoraView').value=operadora;                  
                   document.getElementById('lblTelefonoview').innerHTML=numero;
                  //$('input[name="lblTelefonoview"]')[0].innerHTML=numero;
                  $('select[name="txtTipoDocumentoView"]')[0].value=tipoDocumento;            
                  document.getElementById('txtNumeroDocumentoView').innerHTML=numeroDocumento;
            }
 
            function SeleccionarProductoPorta(valor) 
            {                  
              //if (document.forms[0].hiddenCedente.value==""){
               //   alert("falta ingresar portabilidad");
              //    return false ;
            //  }
             var indices = "" ;
             var contador = cantidadChekeados(); // asigna cantidad de checkboxs marcados.
             var flagPrimero = 1;
             var totalElementos = document.getElementsByName('existe[]').length;
              
             if (contador == 0){  // si no hay checkboxs marcados
                 alert('Seleccionar al menos uno Producto');
             }
             /*else if(contador>1 || totalElementos >0){
                alert("Solo de puede agregar un Item por portabilidad");
             }*/
             else  // si hay 1 o más checkboxs marcados...
             {
                    var checks = document.getElementsByName('checkbox'); // se obtiene la cantidad de checkbox en la grilla.
                    for (var i=0;i<checks.length;i++){
                        if (checks[i].checked){  // si ese check está marcado...                        
                            if (flagPrimero==1){
                                document.forms[0].idKit.value = checks[i].value; // se setea a idKit el valor del checkbox q es el ID del producto.
                                flagPrimero=0;
                            }
                            else{ document.forms[0].idKit.value = document.forms[0].idKit.value + '+' + checks[i].value; } // si ya hay por lo menos 1 checkbox marcado, se concatena a idKit el ID del producto separado por +.
                        }
                    }      
                  
                   //  logica para revisar si todos los cheks estan con un imei
                   var flag=true;       
                   var checks = document.getElementsByName('checkbox'); // se obtiene la cantidad de checkbox en la grilla.
                   var flag2=true;
                   var strImei="";
                   var flag3=true;
                          
                   for(var i=0;i<checks.length;i++) // avanza por cada checkbox de 1 en 1.
                   {            
                        if (checks[i].checked){ // pregunta si esta marcado.                        
                            var valor_chek = checks[i].value;
                            var elementosTemp = document.getElementsByName('temp[]').length;                        
                          
                            for(var j=0;j<elementosTemp;j++)
                            {    
                               
                                if(document.getElementsByName('temp[]')[j].value==valor_chek)
                                {    
                               
                                    if(document.getElementsByName('txtIMEIArray[]')[j].value==""){  flag=false; }   
                                    
                                    if(document.forms[0].planvalor.value!=null && document.forms[0].planvalor.value=='1'){
                                        if(document.getElementsByName('indiceTemp[]')[j].value!="-1"){
                                            var indiceT = document.getElementsByName('indiceTemp[]')[j].value;
                                            if(document.getElementsByName('cmbPlan[]')[indiceT].value=="0"){ flag2=false; }
                                        }                        
                                    }
                                
                                    //////////////////////////// validamos que los imei no se encuentre repetidos  //////////////////////////////////                                            
                                    var checksValida = document.getElementsByName('checkbox');                                            
                                    for(var i=0;i<checksValida.length;i++)
                                    {                                                
                                        if (checksValida[i].checked) {
                                            var valor_chek = checks[i].value;
                                            var elementosTemp = document.getElementsByName('temp[]').length;                                                
                                            for(var j=0;j<elementosTemp;j++)
                                            {            
                                              
                                                if(document.getElementsByName('temp[]')[j].value==valor_chek) 
                                                {       
                                                    indices = indices + j + "," ;
                                                    if(document.getElementsByName('txtIMEIArray[]')[j].value==""){ flag=false; }                                                    
                                                    if(document.forms[0].planvalor.value!=null && document.forms[0].planvalor.value=='1'){
                                                        if(document.getElementsByName('indiceTemp[]')[j].value!="-1"){
                                                            var indiceT = document.getElementsByName('indiceTemp[]')[j].value;
                                                            if(document.getElementsByName('cmbPlan[]')[indiceT].value=="0"){ flag2=false; }
                                                        }
                                                    }
                                                      
                                                    // validamos que los imeis no esten repetidos //
                                                    if(flag && flag2) {
                                                        if(strImei.indexOf(document.getElementsByName('txtIMEIArray[]')[j].value)==-1 && flag3==true){
                                                            strImei = strImei+","+document.getElementsByName('txtIMEIArray[]')[j].value;
                                                        }
                                                        else{ flag3=false; }
                                                    }
                                                }
                                            }
                                        }
                                    }       
                                }
                            }
                        }
                   }       
                    if(flag && flag2 && flag3 && !valor){
                        strImei = strImei.substring(1,strImei.length);
                        var req = newXMLHttpRequest();          
                        req.onreadystatechange = getReadyStateHandler(req,ValidaPorta);
                        req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=ValidaPorta&imei=" + strImei,true);
                        req.setRequestHeader("Content-Type","application/ISO-8859-1");
                        req.send(null);           
                    }
                    else
                    {  
                       if(!flag){                
                            alert("Debe de Ingresar el Nro de IMEI para el Item Seleccionado");
                            return false;
                       }
                       else{                
                            if(!flag2){ 
                                alert("Debe seleccionar un plan para el producto seleccionado");
                                return false;
                           }
                           else
                           {
                                if(!flag3){
                                    alert("No puede ingresar valores IMEI repetidos");      
                                    return false;
                                    }
                            }
                           
                       } 
                     if (valor)
                     return true;
                       
                    }
                }
            }

            function ValidaPorta(xml){
                
                var portabilidad = xml.getElementsByTagName("portabilidad")[0];
                var data = portabilidad.getElementsByTagName("data");
                
            for(var i = 0 ; i<data.length ; i++)
                {
                    var item = data[i];
                    var result = item.firstChild.nodeValue;     
                }
            
             if(result=="true"){
                document.forms[0].total.value= '1';
                document.forms[0].metodo.value = 'orderProductSelect'; 
                document.forms[0].submit();
                }
           else 
               alert("Faltan datos de portabilidad");
           
            }

      function updatePorta(Portaxml){
                 
                var portabilidad = Portaxml.getElementsByTagName("portabilidad")[0];
                var data = portabilidad.getElementsByTagName("data");
               
                for(var i = 0 ; i<data.length ; i++)
                {
                    var item = data[i];
                    var myString = item.firstChild.nodeValue;
                    var campo = myString.split(";");
                    var cedente = campo[0];
                    var numero = campo[1]; 
                    var operadora = campo[2];
                    var validacion = campo[3];
                    var tipoDocumento=campo[4];
                    var numeroDocumento=campo[5];
                }
              
                if(validacion!=""){
                alert(validacion);
                }
                else {
               document.getElementById('txtnumeroPortabilidad').value=numero;
               $('select[name="txtcedente"]')[0].value=cedente;
               document.getElementById('txtNumeroDocumento').value=numeroDocumento;
               $('select[name="txtTipoDocumento"]')[0].value=tipoDocumento;
              // document.getElementById('txtcedente').value=cedente; 
               //document.getElementById('txtoperadora').value=operadora; 
                $('select[name="txtoperadora"]')[0].value=operadora;
                 document.forms[0].btnSeleccionar.disabled=false;
               } 
        }
        
        function validarDocumentoDigitos() {
	with (document.forms[0]){
            var valDocIdent = checkDocIdentidad(txtTipoDocumento.options[txtTipoDocumento.selectedIndex].text , txtNumeroDocumento.value);          
              
            if  (valDocIdent != ""){    
                    alert(valDocIdent);  
                 // document.getElementById('valid').innerHTML = valDocIdent ;
                  txtNumeroDocumento.focus = true;
                 return false;
            }
         }
         return true;
}
            function jsValidarPortabilidad(){                
                   //LESCOBAR
                   var division=document.getElementsByName("cmbDivision")[0].value;
                   var longitud=9;
                   if(division==='8'){
                      longitud=8;
                   }
                   
                   // var cmbCedente = document.getElementById('txtcedente').value;
                    var cmbCedente = $('select[name="txtcedente"]')[0].value;
                    if(cmbCedente==0){
                    //alert("Seleccione un tipo de cedente");
                    document.getElementById('valid').innerHTML = "Seleccione un tipo de cedente"; 
                    return false ;
                    }   
                    var frm = document.forms[0];
                    var indice = frm.indice.value ;
                    var txtTelefonoAPortar = document.getElementById('txtnumeroPortabilidad').value;
                    var primerCaracter = txtTelefonoAPortar.charAt(0);
                    
                     if($.trim(txtTelefonoAPortar).length == 0 ){
                       // alert("El campo Teléfono a Portar es obligatorio.\nPor favor, ingresar el dato requerido.");
                        document.getElementById('valid').innerHTML = "No se ha agregado ning&uacuten n&uacutemero a portar."; 
                        document.getElementById('txtnumeroPortabilidad').focus();return false; 
                     }
                     // inicio validacion que el numero comienze con 9 si es movil
                     if(division !='8' && primerCaracter != '9' ){
                       document.getElementById('valid').innerHTML = "El campo Tel&eacutefono m&oacutevil a portar debe comenzar con 9.\n Ingrese el formato correcto.";
                       return false ;
                       }
                     if (division==='8' && primerCaracter == '0' || division==='8' && primerCaracter == '9'){
                       document.getElementById('valid').innerHTML = "El campo Tel&eacutefono fijo m&oacutevil a portar debe comenzar con n&uacutemero distinto de 0 &oacute 9.\n Ingrese el formato correcto.";
                      return false ;
                     }
                     //fin validacion que el numero comienze con 9 si es movil
                     
                    //Inicio Validacion Para el Prefijo del Numero a Portar (Codigo de Zona Habilitada o No)
                    if (division ==='8' && $.trim(txtTelefonoAPortar).length == longitud){
                        if(!PortaPhoneNumberValidatePrefijo(txtTelefonoAPortar)){ 
                            document.getElementById('valid').innerHTML = "El numero "+txtTelefonoAPortar+" a portar pertenece a una Region no habilitada para Telefonia Fija Movil.\n Ingrese el formato correcto.";	
                             return false;
                            }
                       }  /*   RRAMIREZ  */
                    //Fin Validacion Para el Prefijo del Numero a Portar (Codigo de Zona Habilitada o No)
                                       
                    if($.trim(txtTelefonoAPortar).length != longitud ){
                      // alert("El campo Teléfono a Portar no tiene el formato correcto.\nValide que el teléfono tenga 9 dígitos.");
                      document.getElementById('valid').innerHTML = "El campo Tel&eacutefono a Portar no tiene el formato correcto.\nValide que el tel&eacutefono tenga "+longitud+" d&iacutegitos.";
                       return false ;
                    }
                   // var cmbOrigen = document.getElementById('txtoperadora').value;  
                    var cmbOrigen = $('select[name="txtoperadora"]')[0].value;       
                    if(cmbOrigen==0){
                  //  alert("Seleccione un tipo de origen");
                    document.getElementById('valid').innerHTML = "Seleccione un tipo de origen";
                    return false ;
                    }
                 
                    //Inicio-RPASCACIO 27-08-2014
                    var txtNumeroDocumento = document.getElementById('txtNumeroDocumento').value;
                    var cmbTipoDocumento = document.getElementById('txtTipoDocumento').value;
                    if(cmbTipoDocumento==0){
                    //alert("Seleccione el Tipo de Documento");
                    document.getElementById('valid').innerHTML = "Seleccione el Tipo de Documento";
                    return false ;
                    }                    
                    //validarDocumentoDigitos();
                    //Fin-RPASCACIO 27-08-2014   
              
              var cmbTipoDocumentotext = txtTipoDocumento.options[txtTipoDocumento.selectedIndex].text;       
              var valDocIdent = checkDocIdentidad(cmbTipoDocumentotext,$.trim(txtNumeroDocumento));          
              if  (valDocIdent != ""){    
                  //  alert(valDocIdent);  
                    document.getElementById('valid').innerHTML = valDocIdent ;
                 // txtNumeroDocumento.focus = true;
                 return false;
              }
                    //Fbernales -- [PM0010913] -- se realiza la validacion s el numero que se ha ingresado se encuentra ya asignado a otro
                    // en la grilla
                    if(!PortaPhoneNumberValidate(txtTelefonoAPortar)){
                       document.getElementById('valid').innerHTML = "El numero ya se encuentra registrado en la grilla" ;
                       return false;
                    }
                    
                    document.forms[0].btnSeleccionar.disabled=true; 
                    document.getElementById('valid').innerHTML = "";
                    var imei = document.getElementsByName('txtIMEIArray[]')[indice].value
                    var req = newXMLHttpRequest();          
                     req.onreadystatechange = getReadyStateHandler(req,updatePorta);
                     req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=PortabilidadAnt&imei=" + $.trim(imei)+"&txtnumeroPortabilidad="+$.trim(txtTelefonoAPortar)+"&cmbCedente="+cmbCedente+"&cmbOrigen="+cmbOrigen+"&cmbTipoDocumento="+cmbTipoDocumento+"&txtNumeroDocumento="+$.trim(txtNumeroDocumento),true);
                     req.setRequestHeader("Content-Type","application/ISO-8859-1");
                     req.send(null); 
                     
                     $('#xCerrar').click();
                   
            }           
       
            //Portabilidad FIN
            
function PortaPhoneNumberValidatePrefijo(phonenumber) {
 var response=true;
 var status=false;
 var req = newXMLHttpRequest();   
 var strResponse = "<%=request.getContextPath()%>/OrderAction.do?metodo=PortaPhoneNumberValidatePrefijo&phonenumber="+$.trim(phonenumber); 

     $.ajax({  
           type: 'GET',
           contentType: "text/json,ISO-8859-1",
           async:false, 
           url: strResponse,               
           data:  null,
           success:function(data){  
               //alert("data: "+data);
               //alert("data.validate: "+data.validate);
             if(response==data.validate){
                 status=true;
               //alert("response==data.validate: ",status);
               }
                 },
           error: function(xhr, status, error) {
               alert(status);
               alert(xhr.responseText);
             }                           
        });  
    return status;
  }        
   
function PortaPhoneNumberValidate(phonenumber){

  var strUrlWithParams = "<%=request.getContextPath()%>/OrderAction.do?metodo=PortaPhoneNumberValidate&phonenumber="+phonenumber;
  var response=true;
  
  var flagPrimero = 1;
  var checks = document.getElementsByName('checkbox');
  var selectedImeis ="";
  
  for (var i=0;i<checks.length;i++){
    if (checks[i].checked){        
        var valor_chek = checks[i].value;
        var elementosTemp = document.getElementsByName('temp[]').length;                                                  
        for(var j=0;j<elementosTemp;j++){ 
            if(document.getElementsByName('temp[]')[j].value==valor_chek){            
                if (flagPrimero==1){
                    selectedImeis=document.getElementsByName('txtIMEIArray[]')[j].value; 
                    flagPrimero=0;
                }else{
                    selectedImeis=selectedImeis+';'+document.getElementsByName('txtIMEIArray[]')[j].value;                    
                }                
            }
        }                                                                                                                          
                                            
    }
  }
  
  strUrlWithParams=strUrlWithParams+"&selectedImeis="+selectedImeis;
  
  $.ajax({  
       type: 'GET',
       contentType: "text/json,ISO-8859-1",
       async:false, 
       url: strUrlWithParams,               
       data:  null,
       success:function(data){          
            if(data=="Error"){
                response=false;
            }else{
                response=true;
            }
       },
       error: function(xhr, status, error) {
           alert(status);
           alert(xhr.responseText);
           response=true;
       }                           
    });     
    return response;
}

function BuscarProducto()
{
      document.forms[0].btnBuscar.disabled=true;
    if(validar())
    {
        document.forms[0].metodo.value="orderProductSearch";
        flagActiveBtnOpenAddItem = 0;
        document.forms[0].submit();
    }
   else
   {
        document.forms[0].btnBuscar.disabled=false;
   }
   
}

function validar()
{
    if(document.forms[0].cmbProduct.value=="0")
    {
        alert("Debe de seleccionar un Modelo")
        document.forms[0].cmbProduct.focus();
        return false;
    }
    return true;
}
function cancelar()
{
    
        var entrar = confirm("Esta ud. seguro que desea Cancelar")
	if (entrar)
	{   
            window.opener.document.getElementById('btnOpenAddItem').disabled = false;
            window.close();		
        }
	return false;
        
}

function SeleccionarProducto()
{
    
    var contador = cantidadChekeados();
    var flagPrimero = 1;
    if (contador == 0)
    {
        alert('Seleccionar al menos uno Producto');
    }
    else{
       
       
       var checks = document.getElementsByName('checkbox');
            for (var i=0;i<checks.length;i++){
	  	if (checks[i].checked){
                    if (flagPrimero==1){
                        document.forms[0].idKit.value = checks[i].value;
	  		flagPrimero=0;
	  		}else{
                            document.forms[0].idKit.value = document.forms[0].idKit.value + '+' + checks[i].value;
	  		}
	  	    }
	  	}
      
      
       //  logica para revisar si todos los cheks estan con un imei
       var flag=true;       
       var checks = document.getElementsByName('checkbox');
       var flag2=true;
       var strImei="";
       var flag3=true;
       
       
       for(var i=0;i<checks.length;i++)
       {
            
            if (checks[i].checked)
            {
            var valor_chek = checks[i].value;
            var elementosTemp = document.getElementsByName('temp[]').length;
            
            for(var j=0;j<elementosTemp;j++)
            {
                
                if(document.getElementsByName('temp[]')[j].value==valor_chek)
                {

                    if(document.getElementsByName('txtIMEIArray[]')[j].value=="")
                    {
                            flag=false;
                    }
                    
                    if(document.forms[0].planvalor.value!=null && document.forms[0].planvalor.value=='1')
                    {
                        if(document.getElementsByName('indiceTemp[]')[j].value!="-1")
                        {
                            var indiceT = document.getElementsByName('indiceTemp[]')[j].value;
                            if(document.getElementsByName('cmbPlan[]')[indiceT].value=="0")
                            {
                                flag2=false;
                            }
                        }
                        
                    }
                    
                    
                                //////////////////////////// validamos que los imei no se encuentre repetidos  //////////////////////////////////
                                
                                var checksValida = document.getElementsByName('checkbox');
                                
                                for(var i=0;i<checksValida.length;i++)
                               {
                                    
                                    if (checksValida[i].checked)
                                    {
                                    var valor_chek = checks[i].value;
                                    var elementosTemp = document.getElementsByName('temp[]').length;
                                    
                                    for(var j=0;j<elementosTemp;j++)
                                    {
                                        
                                        if(document.getElementsByName('temp[]')[j].value==valor_chek)
                                        {
                        
                                            if(document.getElementsByName('txtIMEIArray[]')[j].value=="")
                                            {
                                                    flag=false;
                                            }
                                            
                                            if(document.forms[0].planvalor.value!=null && document.forms[0].planvalor.value=='1')
                                            {
                                                if(document.getElementsByName('indiceTemp[]')[j].value!="-1")
                                                {
                                                    var indiceT = document.getElementsByName('indiceTemp[]')[j].value;
                                                    if(document.getElementsByName('cmbPlan[]')[indiceT].value=="0")
                                                    {
                                                        flag2=false;
                                                    }
                                                }
                                            }
                                            
                                          
                                            // validamos que los imeis no esten repetidos //
                                            if(flag && flag2)
                                            {
                                                if(strImei.indexOf(document.getElementsByName('txtIMEIArray[]')[j].value)==-1 && flag3==true)
                                                {
                                                    strImei = strImei+","+document.getElementsByName('txtIMEIArray[]')[j].value;
                                                }
                                                else
                                                {
                                                   flag3=false;
                                                }
                                            }
                                            
                                        }
                                    }
                                  }
                               }
                                
                                
                }
            }
          }
       }
       
       
        if(flag && flag2 && flag3)
        {   
            document.forms[0].metodo.value = 'orderProductSelect'; 
            document.forms[0].submit();
        }
        else
        {  
           if(!flag)
           { alert("Debe de Ingresar el Nro de Producto para el Item Seleccionado");
             return false;
           }
           else
           {
                if(!flag2)
               { alert("Debe seleccionar un plan para el producto seleccionado");
                 return false;
               }
               else
               {
                 alert("No puede ingresar valores IMEI repetidos"); 
                 return false;
               }
           }
        }
    }
    
    flagActiveBtnOpenAddItem = 0;
}


function cantidadChekeados(){
    var checks = document.getElementsByName('checkbox');
    var contador = 0;
    for (var i=0;i<checks.length;i++){
        if (checks[i].checked){
  	contador++;
  	}
    }	
    return contador;
}
            
            
            function cantidadchekeadoPorta(valor)
            {
            var cantidad = cantidadChekeados() ;
            if (cantidad  > 1){
            valor.checked=false ;
            alert("solo es permitido 1 item por portabilidad");
            }
           
            }

			
function agregar_producto()
{         
            var totalElementos = document.getElementsByName('existe[]').length;            
            var vaciosRegion = 0;
            var vaciosProvincia = 0;
            var vaciosDistrito = 0
            var objRegion;
            var objProvincia;
            var objDistrito;
             if(totalElementos>0) {      
                $(".validateComboRegion" ).each(function(){                                                      
                    var idRegion = $(this).val();
                    if(idRegion == 0){                    
                        objRegion = $(this);
                        vaciosRegion++;                                                
                    }                    
                });
				
				$(".validateComboProvincia" ).each(function(){                                                      
                    var cantidadProvincias=$(this).find("option").length;
					if(cantidadProvincias>1){
						var idProvincia = $(this).val();
						if(idProvincia == 0){                    
							objProvincia = $(this);
							vaciosProvincia++;                                                
						}   						
					}
					                 
                });
				
				$(".validateComboDistrito" ).each(function(){                                                      
                    var cantidadDistritos=$(this).find("option").length;
					if(cantidadDistritos>1){
						var idDistrito = $(this).val();
						if(idDistrito == 0){                    
							objDistrito = $(this);
							vaciosDistrito++;                                                
						}   						
					}
					                 
                });
               
               
                //JMEDINA 23/02/17 --INI
                if(vaciosRegion == 0){
                  if (vaciosProvincia==0){
                    if (vaciosDistrito==0){
                    $(".comboRegion").each(function(){                                                      
                        var codigo = $(this).val();
                        var hiddenText = "";
                        var hidden = "<input type='hidden' name='"+ $(this).attr("name") + "'  value='"+$(this).val() +"'>";
                        if(codigo == 0){
                            hiddenText = "<input type='hidden' name='txtNombresRegionArrayFinal[]' value=''>";                                    
                        }else{
                            hiddenText = "<input type='hidden' name='txtNombresRegionArrayFinal[]' value='"+$(this).children("option").filter(":selected").text() +"'>";                                    
                        }                        
                        window.opener.$("form").eq('0').append(hidden);                
                        window.opener.$("form").eq('0').append(hiddenText);                                  
                    });
					
					$(".comboProvincia").each(function(){                                                      
                        var codigo = $(this).val();
                        var hiddenText = "";
                        var hidden = "<input type='hidden' name='"+ $(this).attr("name") + "'  value='"+$(this).val() +"'>";
                        if(codigo == 0){
                            hiddenText = "<input type='hidden' name='txtNombresProvinciaArrayFinal[]' value=''>";                                    
                        }else{
                            hiddenText = "<input type='hidden' name='txtNombresProvinciaArrayFinal[]' value='"+$(this).children("option").filter(":selected").text() +"'>";                                    
                        }                        
                        window.opener.$("form").eq('0').append(hidden);                
                        window.opener.$("form").eq('0').append(hiddenText);                                  
                    });
					
					$(".comboDistrito").each(function(){                                                      
                                            var codigo = $(this).val();
                                            var hiddenText = "";
                                            var hidden = "<input type='hidden' name='"+ $(this).attr("name") + "'  value='"+$(this).val() +"'>";
                                            if(codigo == 0){
                                                hiddenText = "<input type='hidden' name='txtNombresDistritoArrayFinal[]' value=''>";                                    
                                            }else{
                                                hiddenText = "<input type='hidden' name='txtNombresDistritoArrayFinal[]' value='"+$(this).children("option").filter(":selected").text() +"'>";                                    
                                            }                        
                                            window.opener.$("form").eq('0').append(hidden);                
                                            window.opener.$("form").eq('0').append(hiddenText);                                  
                                        });
                                //JMEDINA 23/02/17 -FIN                
                    window.opener.document.forms[0].metodo.value="orderAddProduct";
                    window.opener.document.forms[0].submit();
                    flagActiveBtnOpenAddItem = 0;
                    window.close();
                   }else{
                       alert("Debe Seleccionar una Distrito");
                       objDistrito.focus();
                   }    
				  }else{
                       alert("Debe Seleccionar una Provincia");
                       objProvincia.focus();
                     }    
                }else{
                    alert("Debe Seleccionar una región");
                    objRegion.focus();
                }                
            }else{
                alert("No hay Productos para agregar al detalle de la Orden");
                 }
            
}

function ObtenerProvincia(region){
   var idregion=$(region).find("option:selected").val();
   var checks = document.getElementsByName('checkbox');
   var idproducto=checks[0].value;
   var strUrlWithParams = "<%=request.getContextPath()%>/OrderAction.do?metodo=RetornoOrderProvinciaAjax&idregion="+idregion+"&idproducto="+idproducto;
    $.ajax({  
       type: 'GET',
       contentType: "text/json,ISO-8859-1",
       async:false, 
       url: strUrlWithParams,               
       data:  null,
       success:function(data){
       $("#Selectprovincia").empty();
       $("#SelectDistrito").empty();
       $("#Selectprovincia").append('<option value="0" >--Seleccionar--</option>');
       $("#SelectDistrito").append('<option value="0" >--Seleccionar--</option>');
       for(var i=0; i<data.length;i++){
       $("#Selectprovincia").append(' <option value="'+data[i].idProvincia+'" >'+data[i].nombreProvincia+'</option>');
       }
            if(data=="Error"){
                response=false;
            }else{
                response=true;
            }
       },
       error: function(xhr, status, error) {
           alert(status);
           alert(xhr.responseText);
           response=true;
       }                           
    });    
   
 }




function eliminarItem(valor)
{
    var entra = confirm("Esta Ud. seguro de Eliminar un item")
    if(entra)
    {
        document.forms[0].idItem.value = valor;
        document.forms[0].metodo.value="deleteItemDetail";
        document.forms[0].submit();
    }
}

function validarSim(valor)
{
        var len_min= document.getElementById('lnLenSearchImei').value;
        var imei =  document.getElementsByName('txtIMEI')[valor].value;
        if(imei.length == len_min){
        return false ;
        }
        var frm = document.forms[0];
        frm.indice.value =  valor;
       
         
                var req = newXMLHttpRequest();          
                req.onreadystatechange = getReadyStateHandler(req,updateSIM);
                req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=searchSim&indice=" + valor+"&splitImeis="+imei,true);
                req.setRequestHeader("Content-Type","application/ISO-8859-1");
                req.send(null);

}

/*function validarSim(valor)
{
        var len_min= '<%=request.getAttribute("lnLenSearchImei")%>';
        var imei =  document.getElementsByName('txtIMEI')[valor].value;
        if(imei.length == len_min){
        return false ;
        }
        var frm = document.forms[0];
        frm.indice.value =  valor;
        var flag=1;
       
        var imei = document.getElementsByName('txtIMEI');
        if(imei[0])
        {
            
            if(imei[valor].value!="")
            {
                
                var longitud = document.getElementsByName('txtIMEI').length;
                           
                for(var i=0;i<longitud;i++)
                {
                    if(flag==1)
                    {
                        document.forms[0].splitImeis.value = document.getElementsByName('txtIMEI')[i].value;
                        var tempImei = document.forms[0].splitImeis.value;
                        flag=0;
                        
                    }else
                    {
                        document.forms[0].splitImeis.value = document.forms[0].splitImeis.value + '|' + document.getElementsByName('txtIMEI')[i].value;
                        var tempImei = document.forms[0].splitImeis.value;
                    }                      
                        
                    
                }
                
                var req = newXMLHttpRequest();          
                req.onreadystatechange = getReadyStateHandler(req,updateSIM);
                req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=searchSim&indice=" + valor+"&splitImeis="+tempImei,true);
                req.setRequestHeader("Content-Type","application/ISO-8859-1");
                req.send(null);
            }
         
              //  document.forms[0].txtSIM[valor].value="";
         
       
        }
        else
        {
            
            if(document.forms[0].txtIMEI.value!="")
            {
                var longitud = document.getElementsByName('txtIMEI').length;
                for(var i=0;i<longitud;i++)
                {
                    if(flag==1)
                    {
                        document.forms[0].splitImeis.value = document.getElementsByName('txtIMEI')[i].value;
                        var tempImei = document.forms[0].splitImeis.value;
                        flag=0;
                       
                    }else
                    {
                        document.forms[0].splitImeis.value = document.forms[0].splitImeis.value + '|' + document.getElementsByName('txtIMEI')[i].value;
                        var tempImei = document.forms[0].splitImeis.value;
                    }
                }
               
                
                var req = newXMLHttpRequest();          
                req.onreadystatechange = getReadyStateHandler(req,updateSIM);
                req.open("GET","<%=request.getContextPath() %>/OrderAction.do?metodo=searchSim&indice=" + valor+"&splitImeis="+tempImei,true);
                req.setRequestHeader("Content-Type","application/ISO-8859-1");
                req.send(null);
            }
               
        }
            
}*/

function evaluarplan()
{
    document.forms[0].planvalor.value='1';
}

//LEL 01-02-10: Cambios en el procesamiento para mostrar los mensajes
function updateSIM(miXml){
                 
                var dpto = miXml.getElementsByTagName("dpto")[0];
                var provs = dpto.getElementsByTagName("prov");
		
		//prov tiene el Indice;cantidad;SIM;IMEI
		for (var i=0;i<provs.length;i++){
                        var item = provs[i];
                        var myString = item.firstChild.nodeValue;
                        var campo = myString.split(";");
                        var indice = campo[0];
                        var cantidad = campo[1]; //Si es mayor a "0" quiere decir que hay stock con el IMEI ingresado
                        var mensaje = campo[2];
                        if(cantidad<=0)
                        {
                            var imei = document.getElementsByName('txtIMEI')[indice].value;   
                            
                            //alert('El Nro. de Producto: '+imei+' ya se encuentra Reservado, o no corresponde al Producto Seleccionado');
                            document.getElementsByName('txtIMEI')[indice].value="";
                            document.getElementsByName('txtSIM')[indice].value="";
                            
                            if(cantidad==0) {
                                //BALFARO 6-12-2010 : notificar procedure que saca esta información
                                alert('No se puede encontrar el IMEI '+imei); // No se puede encontrar en el sistema o hay error en la configuracion
                            } else
                                if (cantidad==-1) {
                                    alert('El Nro. de Producto: '+imei+' no corresponde al Producto Seleccionado');
                                } else
                                    if (cantidad==-2) {
                                    alert('El Nro. de Producto: '+imei+' esta en el sub-almacen de devueltos');
                                    } else   
                                        if (cantidad==-3) {
                                            alert('El Nro. de Producto: '+imei+' esta bloqueado, se encuentra en una orden con los siguientes datos: ' +mensaje);
                                        } else
                                            if (cantidad==-4) { // Los mensajes obtiene de retail.nporder_pkg.fn_error_imei
                                                alert('El Nro. de Producto: '+imei+'\n -' +mensaje);
                                            }
                        }else
                        {
                            if(campo[2]!="")
                            {
                                document.getElementsByName('txtSIM')[indice].value = campo[2]; //valor de SIM
                                
                                if(document.getElementsByName('txtSIMArray[]')[indice]!=null)   // si existe el objeto le asigna el campo con el valor del SIM
                                {   document.getElementsByName('txtSIMArray[]')[indice].value=campo[2];
                                }
                                
                            }    
                            document.getElementsByName('txtIMEIArray[]')[indice].value=campo[3]; //Valor IMEI
                        }
                       
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

            function soloNumeros(e){   
                var key = window.Event ? e.which : e.keyCode;
                return ( (key >= 8 && key <= 13) || (key >= 48 && key <= 57)); //Numerico                      
            }              
            
        //JATORRESC INI
 function autocompleteImei(obj,valor){
     var frm = document.forms[0];
     frm.indice.value =  valor;
     var pages = "<%=request.getContextPath() %>/OrderAction.do?metodo=obtenerImei&indice="+valor;
    //KCARPIO  - Almacena Minimo de Longitud - 14/07/2014
    var len_min = document.getElementById('lnLenSearchImei').value;
    //KCARPIO  - 14/07/2014
    //$(".ui-autocomplete-loading").show();
    var arrItemsSIM;
    
    $(obj).autocomplete({
        width: 300,
        max: 10,
        //delay: 100,
        minLength: len_min,
        autoFocus: true,
        //cacheLength: 1,
        scroll: true,
        highlight: true,
        source: function(request, response) {
            $.ajax({
                url: pages,
                type: "POST",
                dataType: "json",                
                data: request,
                success: function( data, textStatus, jqXHR) {
                    //console.log( data);
                    //console.log( request.term);
                    //console.log( request);
                    var items = data;
                    if(items==""){
                       alert("No existe imei con ese criterio");
                    }
                    
                    var arrItemsIMEI = new Array(items.length);
                    arrItemsSIM = new Array(items.length);
                    var arrItemsTmp;
                    
                    for(var i = 0 ; i< items.length ; i++) {
                         arrItemsTmp = items[i].split("|");
                         arrItemsIMEI[i] = arrItemsTmp[0];
                         
                         arrItemsSIM[i] = new Array(2);
                         arrItemsSIM[i][0] = arrItemsTmp[0];
                         arrItemsSIM[i][1] = arrItemsTmp[1];
                    }
                    
                    //var  = items.split("|");
                    response(arrItemsIMEI);
                    
                   // var me = $(this);
                    //me.html( me.text().replace(acData.term, styledTerm) );
                   // $(".ui-autocomplete-loading").hide();
                },
                error: function(jqXHR, textStatus, errorThrown){
                   //  console.log( textStatus);
                    // $(".ui-autocomplete-loading").hide();
                }
                
       
                
            });
         },
            select: function(event, ui) {
               this.value = ui.item.value;
               
               var idModality= '<%=request.getSession().getAttribute("IdModality").toString()%>';
               if ('403' == idModality){ //Consignacion
               
                  for (var i=0, len=arrItemsSIM.length; i<len; i++) {
                    for (var j=0, len2=arrItemsSIM[i].length; j<len2; j++) {
                      if (arrItemsSIM[i][0] === this.value) {  
                        document.getElementsByName('txtSIM')[valor].value = arrItemsSIM[i][1];
                        
                        
                        
                        if(document.getElementsByName('txtSIMArray[]')[valor]!=null)   // si existe el objeto le asigna el campo con el valor del SIM
                                {   document.getElementsByName('txtSIMArray[]')[valor].value = arrItemsSIM[i][1];
                                }
                        document.getElementsByName('txtIMEIArray[]')[valor].value=arrItemsSIM[i][0];        
                         //console.log( 'consignacion encontro');
                      }
                    }
                  }
                  
                  
                  //console.log( 'consignacion');
               }else{
                    //console.log( 'venta');
                  validarSim(valor);
               }
               return false;
        }
  
    });
    }

    
</script>


<html:form action="/OrderAction.do" method="post">
<html:hidden property="metodo"/>
<html:hidden property="idKit"/>
<html:hidden property="idItem"/>
<html:hidden property="indice"/>
<html:hidden property="splitImeis"/>
<html:hidden property="cmbDivision"/>
<input type="hidden" name="planvalor" />
<html:hidden property="txtTipoDocumentoDetail"/>
<html:hidden property="txtNumeroDocumentoDetail"/>
<input type="hidden" id="total" value="0" />
<html:hidden property="lnLenSearchImei" styleId="lnLenSearchImei" />
<html:hidden property="lnFlagLiviano" styleId="lnFlagLiviano" />
<html:hidden property="lnValidarModelo" styleId="lnValidarModelo" />
<%  //LEL 11-11-09: Se deben usar las constantes (cambio solo en 3G):
       
    int productoSerie = Integer.parseInt(Constant.P_SPECIFICATIONID_PRODUCTO_SERIE);
    //LEL 30-11-09 Se filtrará los prepago y postpago por Specification 
    int idSpecification_product_prePago = Integer.parseInt(Constant.P_SPECIFICATIONID_PREPAGO);
    int idSpecification_product_postPago = Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO);
    
    
    int idSpecification_product_prePago_portability = Integer.parseInt(Constant.P_SPECIFICATIONID_PREPAGO_PORTABILITY);
    int idSpecification_product_postPago_portability = Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO_PORTABILITY); 
    int productLineId_bafi =Integer.parseInt((String)request.getSession().getAttribute("BafiProductLine"));
	
    
    String propertyKits = "listDetailKit";
    if((String)request.getSession().getAttribute("flagTypekit") == "1" ) {
        propertyKits="listDetailKits";
    }    
   %>
<table width="100%" border="1" class="RegionHeaderColor">

<tr>
<td>

  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="100%" height="22" colspan="4" class="PortletHeaderColor"><div class="PortletHeaderText">&nbsp;&nbsp;Agregar Producto</div></td>
    </tr>
  </table>
  
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td colspan="5" class="PortletText1">Criterios de Selecci&oacute;n</td>
    </tr>
    <tr class="ListRow1">
      <td width="15%" class="LeftSubTab"><strong>B&uacute;squeda por </strong></td>
      <td width="18%"><div align="left">
          <select name="select5" size="1" disabled="true">
            <option value="0">--Seleccionar--</option>
            <option value="1" selected>Modelo</option>
            <option value="2">Plan</option>
            <option value="3">Precio</option>
          </select>
      </div></td>
      
      <td width="10%" class="LeftSubTab"><strong>Modelo</strong></td>
      
      <td width="18%">
      <div align="left">
      <logic:notEqual value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
      <html:select property="cmbProduct">
      <option value="0" >--Seleccionar--</option>
      <html:options collection="listaModelo" property="npproductid" labelProperty="npproductname"/>
      </html:select>
      </logic:notEqual>
      <logic:equal value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
      <html:select property="cmbProduct">
      <option value="0" >--Seleccionar--</option>
      <html:options collection="listaProductos" property="idProduct" labelProperty="nameProduct"/>
      </html:select>
      </logic:equal>
      </div>
      </td>
     
      <td width="39%"><div align="left">
          <input type="button" name="btnBuscar" value="Buscar" onclick="javascript:BuscarProducto()">
      </div></td>
    </tr>
    <tr class="ListRow1">
      <td colspan="5">&nbsp;</td>
    </tr>
  </table>
 
  <table width="100%"  border="0">
    
    <tr class="ListRow1">
      <td width="100%" colspan="4"><span class="PortletText1">Productos Disponibles </span></td>
    </tr>
  </table>
  <logic:notEqual value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="3%" class="LeftSubTab"><div align="center"></div></td>
      <td width="23%" class="LeftSubTab"><div align="center"><strong>Promoci&oacute;n</strong></div></td>
      <td width="8%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>
      <td width="8%" class="LeftSubTab"><div align="center"><strong>Precio</strong></div></td>
      <td width="16%" class="LeftSubTab"><div align="center"><strong>Plan</strong></div></td>
      <td width="14%" class="LeftSubTab"><div align="center"><strong>Modelo</strong></div></td>
      <td width="11%" class="LeftSubTab"><div align="center"><strong>IMEI</strong></div></td>
      <td width="13%" class="LeftSubTab"><div align="center"><strong>SIM</strong></div></td>
      <%
    if(idSpecification_product_prePago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection") || 
        idSpecification_product_postPago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection"))                  
     { %>
      <td width="13%" class="LeftSubTab"><div align="center"><strong>PORTABILIDAD</strong></div></td>  
    <% } %>      
      </tr>
  </table>
   <!--Para PrePago Iden-->
   
  <logic:equal value="<%=idSpecification_product_prePago%>" name="OrderForm" property="idSpecification">  
  <logic:notEmpty  name="OrderForm" property="<%=propertyKits%>">
  <!--logic:notEmpty  name="listaDetailkit"-->
      <%
       java.lang.String productoAnterior = "ninguna";
       int j=0;
      %>
     <div id="capa" style="width:100%; height:150px; z-index:1 ;overflow:auto" class="ListRow1" >
     <logic:iterate id="detail" property="<%=propertyKits%>" name="OrderForm" indexId="indice">
     <!--logic:iterate id="detail" name="listaDetailkit" indexId="indice"--> 
     
     <bean:define id="codproducto" name="detail" property="idKitProducto"/>
              <!-- JATORRESC 30-06-2014 Popup Portabilidad INI -->
              <input id='hddPortability<bean:write name="detail" property="idKitProducto"/>' type='hidden' value="">
              <!-- JATORRESC 30-06-2014 Popup Portabilidad FIN -->
      
      <div id="div_producto_<%=indice%>">
      <table width="100%" align="center">
      <TR>
      <%
         if(!codproducto.toString().equals(productoAnterior))
                 
         {
         %>
                          <td width="3%" class="ListRow1">
                                <div align="center">
                                    <input name='temp[]'          type='hidden'   value="<bean:write name="detail" property="idKitProducto"/>">
                                    <input name='txtIdKitArray[]' type='hidden'   value="<bean:write name="detail" property="idKitProducto"/>">
                                    <input name="checkbox"        type="checkbox" value="<bean:write name="detail" property="idKitProducto"/>"/>
                                </div>
                          </td>                          
      <td width="28%" class="ListRow1"><div align="center"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detail" property="nombre"/>"><bean:write name="detail" property="nombre"/></div></td>
                          <td width="9%"  class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detail" property="sku"/>"><bean:write name="detail" property="sku"/></div></td>
                          <td width="7%"  class="ListRow1">
                            <div align="center">
                                <input name='txtCostKitArray[]'  type='hidden' value="<bean:write name="detail" property="precio"/>"><bean:write name="detail" property="precio"/>
                                <input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="idMoneda"/>">
                            </div>
                          </td>
                        <%} else {%>
                        <td width="2%" class="ListRow1">
                                <div align="center">
                                    <input name='temp[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>">
                                </div>
                        </td>
                        <td width="18%" class="ListRow1"><div align="center"></div></td>
                        <td width="7%" class="ListRow1"><div align="center"></div></td>       
                        <td width="7%" class="ListRow1"><div align="center"></div></td>
                     <%}
    productoAnterior = codproducto.toString();%>
          
      <td width="19%" class="ListRow1">
        <div align="center">
            <input name='txtPlanNameArray[]' type='hidden' value="<bean:write name="detail" property="nombrePlan"/>"><bean:write name="detail" property="nombrePlan"/>
            <input name='txtIdPlanArray[]' type='hidden' value="<bean:write name="detail" property="idPlan"/>">
        </div>
      </td>
      <td width="17%" class="ListRow1">
            <div align="center">
                <input name='txtModelNameArray[]' type='hidden' value="<bean:write name="detail" property="nombreModelo"/>"><bean:write name="detail" property="nombreModelo"/>
                <input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProducto"/>">        
            </div>
      </td>            
      <td width="8%" class="ListRow1">
            <div align="center">
                <input name='txtIMEIArray[]' type='hidden'>
                <input name='txtIMEI' type="text" maxlength="100" size="15"  onkeydown="autocompleteImei(this,'<%=j%>')" />
            </div>
        </td>
      <td width="8%" class="ListRow1"><div align="center"><input name='txtSIMArray[]' type='hidden'><input name='txtSIM' type="text" maxlength="100" size="20" readonly="true"/></div></td>          
      <td width="4%" class="ListRow1" align="center">
            <input type="hidden" name="cedentePortability[]" value="4"/>        
            <input type="hidden" name="" value="" />
      </td>
      <input name='txtCostPlan[]' type='hidden' value="<bean:write name="detail" property="costoPlan"/>">      
      
      </tr>
      <%j++;%>
      </table></div>
      </logic:iterate>
      </div>
      </logic:notEmpty>      
        <table width="100%"  border="0">    
        <tr class="ListRow1"><td><div align="center"><input name="button2" type="button" style="width:110px" value="Seleccionar" onclick="javascript:SeleccionarProducto(false);"></div></td></tr>
        <tr class="ListRow1"><td><span class="PortletText1">Lista de Productos</span></td></tr>
       </table>
      </logic:equal>      
      
      <!--Para PostPago -->
      <logic:equal value="<%=idSpecification_product_postPago%>" name="OrderForm" property="idSpecification">
            
      <logic:notEmpty name="OrderForm" property="listKitsAndModelPostPago">
      <%
       java.lang.String productoAnterior = "ninguna";
       int j=0;
       int contadorInput=0;
       int contadorCombo=0;
      %>
      <div id="capa" style="width:100%; height:150px; z-index:1 ;overflow:auto" class="ListRow1" >  
      <logic:iterate id="detail" property="listKitsAndModelPostPago" name="OrderForm" indexId="indice">
      <bean:define id="codproductoPost" name="detail" property="idKitProducto"/>
      <div id="div_producto_<%=indice%>">
      <table width="100%" align="center">
      <TR>
      <%
         if(!codproductoPost.toString().equals(productoAnterior)){%>
      <td width="2%" class="ListRow1"><div align="center"><input name='temp[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"><input name='txtIdKitArray[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"><input type="checkbox" name="checkbox" value="<bean:write name="detail" property="idKitProducto"/>"/></div></td>
      <td width="16%" class="ListRow1"><div align="center"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detail" property="nombre"/>"><bean:write name="detail" property="nombre"/></div></td>
      <td width="5%" class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detail" property="sku"/>"><bean:write name="detail" property="sku"/></div></td>      
      <td width="5%" class="ListRow1">
        <div align="right">
            <input name='txtCostKitArray[]' type='hidden' value="<bean:write name="detail" property="precio"/>"><bean:write name="detail" property="precio"/>
            <input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="idMoneda"/>">
        </div>
      </td> 
      <%}else{%>
       <td width="2%" class="ListRow1"><div align="center"><input name='temp[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"></div></td>
       <td width="16%" class="ListRow1"><div align="center"></div></td>
       <td width="5%" class="ListRow1"><div align="center"></div></td>       
       <td width="5%" class="ListRow1"><div align="center"></div></td>
       <%}productoAnterior = codproductoPost.toString();%>      
      <td width="12%" class="ListRow1">
            <div align="center">
                <input name='txtIdPlanArray[]' type='hidden' value="<bean:write name="detail" property="idPlan"/>">
                <input name='txtPlanNameArray[]' type='hidden' value="<bean:write name="detail" property="nombrePlan"/>">      
      <logic:notEqual value="" name="detail" property="idPlan">
      <bean:write name="detail" property="nombrePlan"/>
      <input type="hidden" value="-1" name="indiceTemp[]">
      </logic:notEqual>
      
      <logic:equal value="" name="detail" property="idPlan">
      <script language="JavaScript" >evaluarplan();</script>
      <select name="cmbPlan[]" style='width:150px'>
      <option value="0" >--Seleccionar--</option>
      <logic:iterate id="plan" property="lstPlan" name="OrderForm">      
      <option value="<bean:write name="plan" property="npplanid"/>|<bean:write name="plan" property="npplanname"/>|<bean:write name="plan" property="npcost"/>"><bean:write name="plan" property="npplanname" />
      </option>
      </logic:iterate>
      </select>
      <input type="hidden" value="<%=contadorCombo++%>" name="indiceTemp[]">
      </logic:equal> 
            
      </div></td>     
      <td width="12%" class="ListRow1">
            <div align="center">
                <input name='txtModelNameArray[]' type='hidden' value="<bean:write name="detail" property="nombreModelo"/>"><bean:write name="detail" property="nombreModelo"/>
                <input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProducto"/>">     
            </div>
      </td>
      <td width="8%" class="ListRow1">
            <div align="center">
                    <input name='txtIMEIArray[]' type='hidden'>
                    <input name='txtIMEI' type="text" maxlength="100" size="15" onkeydown="autocompleteImei(this,'<%=j%>')"/>
            </div>
       </td>
      <td width="8%" class="ListRow1"><div align="center"><input name='txtSIMArray[]'  type='hidden'><input name='txtSIM' type="text" maxlength="100" size="20" readonly="true"/></div></td>
      <td width="4%" class="ListRow1" align="center">        
      </td>      
      </tr>
      <%j++;%>
      </table></div>
      </logic:iterate>
      </div>
      </logic:notEmpty>
       <table width="100%"  border="0">    
        <tr class="ListRow1"><td><div align="center"><input name="button2" type="button" style="width:110px" value="Seleccionar" onclick="javascript:SeleccionarProducto(false);"></div></td></tr>
        <tr class="ListRow1"><td><span class="PortletText1">Lista de Productos</span></td></tr>
       </table>
      </logic:equal>
  </logic:notEqual>
  
                  <!--Portabilidad-->   
                <logic:equal value="<%=idSpecification_product_prePago_portability%>" name="OrderForm" property="idSpecification">  
                <logic:notEmpty  name="OrderForm" property="<%=propertyKits%>">
                <!--logic:notEmpty  name="listaDetailkit"-->
      
                  <%
                  java.lang.String productoAnterior = "ninguna";
                 int j=0;
                     %>
              <div id="capa" style="width:100%; height:150px; z-index:1 ;overflow:auto" class="ListRow1" >
              <logic:iterate id="detail" property="<%=propertyKits%>" name="OrderForm" indexId="indice">
                  
              <bean:define id="codproductoPorta" name="detail" property="idKitProducto"/>
              <!-- JATORRESC 30-06-2014 Popup Portabilidad INI -->
              <input id='hddPortability<bean:write name="detail" property="idKitProducto"/>' type='hidden' value="">
              <!-- JATORRESC 30-06-2014 Popup Portabilidad FIN -->
              <div id="div_producto_<%=indice%>">                    
                    <table width="100%" align="center">
                        <tr> <%
                            if(!codproductoPorta.toString().equals(productoAnterior))                 
                            { %>
                          <td width="2%" class="ListRow1">
                                <div align="center">
                                    <input name='temp[]'          type='hidden'   value="<bean:write name="detail" property="idKitProducto"/>">
                                    <input name='txtIdKitArray[]' type='hidden'   value="<bean:write name="detail" property="idKitProducto"/>">
                                    <input name="checkbox"    onclick="cantidadchekeadoPorta(this)"    type="checkbox"  value="<bean:write name="detail" property="idKitProducto"/>"/>
                                </div>
                          </td>                          
                          <td width="16%" class="ListRow1"><div align="center"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detail" property="nombre"/>"><bean:write name="detail" property="nombre"/></div></td>
                          <td width="5%"  class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detail" property="sku"/>"><bean:write name="detail" property="sku"/></div></td>
                          <td width="5%"  class="ListRow1">
                            <div align="center">
                                <input name='txtCostKitArray[]'  type='hidden' value="<bean:write name="detail" property="precio"/>"><bean:write name="detail" property="precio"/>
                                <input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="idMoneda"/>">
                            </div>
                          </td>
                        <%} else {%>
                        <td width="2%" class="ListRow1">
                                <div align="center">
                                    <input name='temp[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>">
                                </div>
                        </td>
                        <td width="18%" class="ListRow1"><div align="center"></div></td>
                        <td width="5%" class="ListRow1"><div align="center"></div></td>       
                        <td width="5%" class="ListRow1"><div align="center"></div></td>
                     <%}
    productoAnterior = codproductoPorta.toString();%>
          
      <td width="12%" class="ListRow1">
        <div align="center">
            <input name='txtPlanNameArray[]' type='hidden' value="<bean:write name="detail" property="nombrePlan"/>"><bean:write name="detail" property="nombrePlan"/>
            <input name='txtIdPlanArray[]' type='hidden' value="<bean:write name="detail" property="idPlan"/>">
        </div>
      </td>
      <td width="12%" class="ListRow1">
            <div align="center">
                <input name='txtModelNameArray[]' type='hidden' value="<bean:write name="detail" property="nombreModelo"/>"><bean:write name="detail" property="nombreModelo"/>
                <input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProducto"/>">        
            </div>
      </td>            
      <td width="8%" class="ListRow1">
            <div align="center">
                <input name='txtIMEIArray[]' type='hidden'>
                <input name='txtIMEI' type="text" maxlength="100" size="15" onkeydown="autocompleteImei(this,'<%=j%>')" />
            </div>
        </td>
      <td width="8%" class="ListRow1"><div align="center"><input name='txtSIMArray[]' type='hidden'><input name='txtSIM' type="text" maxlength="100" size="20" readonly="true"/></div></td>          
      <td width="4%" class="ListRow1" align="center">
            <input type="hidden" name="cedentePortability[]" value="4"/>
            <a id="idportabilidad" name="idportabilidad" data="<bean:write name="detail" property="idKitProducto"/>" class="login_link" value="<%=indice%>"  href="#">Portabilidad</a>         
            <input type="hidden" name="" value="" />
      </td>
      <input name='txtCostPlan[]' type='hidden' value="<bean:write name="detail" property="costoPlan"/>">      
      
      </tr>
      <%j++;%>
      </table></div>
      </logic:iterate>
      </div>
      </logic:notEmpty>    
        <table width="100%"  border="0">    
        <tr class="ListRow1"><td><div align="center"><input name="btnSeleccionar" type="button" style="width:110px" value="Seleccionar" disabled="disabled" onclick="javascript:SeleccionarProductoPorta(false);"></div></td></tr>
        <tr class="ListRow1"><td><span class="PortletText1">Lista de Productos</span></td></tr>
       </table>
      </logic:equal>      
      
      <!--Para PostPago -->
      <logic:equal value="<%=idSpecification_product_postPago_portability%>" name="OrderForm" property="idSpecification">            
      <logic:notEmpty name="OrderForm" property="listKitsAndModelPostPago">
      <%
       java.lang.String productoAnterior = "ninguna";
       int j=0;
       int contadorInput=0;
       int contadorCombo=0;
      %>
      <div id="capa" style="width:100%; height:150px; z-index:1 ;overflow:auto" class="ListRow1" >  
      <logic:iterate id="detail" property="listKitsAndModelPostPago" name="OrderForm" indexId="indice">
      <bean:define id="codproductoPostPorta" name="detail" property="idKitProducto"/>
      <div id="div_producto_<%=indice%>">
      <table width="100%" align="center">
      <TR>
      <%//FBERNALES 11-09-2014
         if(!codproductoPostPorta.toString().equals(productoAnterior)){%>
      <td width="2%" class="ListRow1"><div align="center"><input name='temp[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"><input name='txtIdKitArray[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"><input type="checkbox" onclick="cantidadchekeadoPorta(this)" name="checkbox" value="<bean:write name="detail" property="idKitProducto"/>"/></div></td>
      <td width="17%" class="ListRow1"><div align="left"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detail" property="nombre"/>"><bean:write name="detail" property="nombre"/></div></td>
      <td width="5%" class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detail" property="sku"/>"><bean:write name="detail" property="sku"/></div></td>      
      <td width="5%" class="ListRow1">
        <div align="center">
            <input name='txtCostKitArray[]' type='hidden' value="<bean:write name="detail" property="precio"/>"><bean:write name="detail" property="precio"/>
            <input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="idMoneda"/>">
        </div>
      </td>
      <%}else{%>
       <td width="2%" class="ListRow1"><div align="center"><input name='temp[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"></div></td>
       <td width="17%" class="ListRow1"><div align="center"></div></td>
       <td width="5%" class="ListRow1"><div align="center"></div></td>       
       <td width="5%" class="ListRow1"><div align="center"></div></td>
       <%}productoAnterior = codproductoPostPorta.toString();%>      
      <td width="12%" class="ListRow1">
            <div align="center">
                <input name='txtIdPlanArray[]' type='hidden' value="<bean:write name="detail" property="idPlan"/>">
                <input name='txtPlanNameArray[]' type='hidden' value="<bean:write name="detail" property="nombrePlan"/>">      
      <logic:notEqual value="" name="detail" property="idPlan">
      <bean:write name="detail" property="nombrePlan"/>
      <input type="hidden" value="-1" name="indiceTemp[]">
      </logic:notEqual>
      
      <logic:equal value="" name="detail" property="idPlan">
      <script language="JavaScript" >evaluarplan();</script>
      <select name="cmbPlan[]" style='width:150px'>
            <option value="0" >--Seleccionar--</option>
            <logic:iterate id="plan" property="lstPlan" name="OrderForm">      
                <option value="<bean:write name="plan" property="npplanid"/>|<bean:write name="plan" property="npplanname"/>|<bean:write name="plan" property="npcost"/>"><bean:write name="plan" property="npplanname" /></option>
            </logic:iterate>
      </select>
      <input type="hidden" value="<%=contadorCombo++%>" name="indiceTemp[]">
      </logic:equal> 
            
      </div></td>     
      <td width="10%" class="ListRow1">
            <div align="center">
                <input name='txtModelNameArray[]' type='hidden' value="<bean:write name="detail" property="nombreModelo"/>"><bean:write name="detail" property="nombreModelo"/>
                <input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProducto"/>">     
            </div>
      </td>
      <td width="8%" class="ListRow1">
            <div align="center">
                    <input name='txtIMEIArray[]' type='hidden'>
                    <input name='txtIMEI' type="text" maxlength="100" size="15" onkeydown="autocompleteImei(this,'<%=j%>')" />
            </div>
       </td>
      <td width="8%" class="ListRow1"><div align="center"><input name='txtSIMArray[]'  type='hidden'><input name='txtSIM' type="text" maxlength="100" size="20" readonly="true"/></div></td>
      <td width="4%" class="ListRow1" align="center">        
     <a class="login_link" href="#" >Portabilidad</a>
      </td>      
      </tr>
      <%j++;%>
      </table></div>
      </logic:iterate>
      </div>
      </logic:notEmpty>
        <table width="100%"  border="0">    
        <tr class="ListRow1"><td><div align="center"><input name="btnSeleccionar" type="button" style="width:110px" value="Seleccionar" disabled="disabled" onclick="javascript:SeleccionarProductoPorta(false);"></div></td></tr>
        <tr class="ListRow1"><td><span class="PortletText1">Lista de Productos</span></td></tr>
       </table>
      </logic:equal>

  
  
  <!-- "PRODUCTOS" que no se activan-->
  <logic:equal value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="8%" class="LeftSubTab"><div align="center"></div></td>
      <td width="35%" class="LeftSubTab"><div align="center"><strong>Nombre</strong></div></td>
      <td width="25%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>Precio</strong></div></td>
      <td width="25%" class="LeftSubTab"><div align="center"><strong>Nro Producto</strong></div></td>
    </tr>
  </table>
  <logic:equal value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
  <logic:notEmpty name="OrderForm" property="listDetailProduct">
      <%
       
       int j=0;
      %>
      
      <logic:iterate id="detail" property="listDetailProduct" name="OrderForm" indexId="indice">
      <div id="div_producto_<%=indice%>">
      <table width="100%" border="0" cellpadding="0">
      <tr>           
          <td width="8%" class="ListRow1"><div align="center"><input name='temp[]' type='hidden' value="<bean:write name="detail" property="idProduct"/>"><input name='txtIdKitArray[]' type='hidden' value="<bean:write name="detail" property="idProduct"/>"><input type="checkbox" name="checkbox" value="<bean:write name="detail" property="idProduct"/>"/></div></td>
          <td width="0%" class="ListRow1"><div align="center"><input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProduct"/>"></div></td>
          <td width="35%" class="ListRow1"><div align="center"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detail" property="nameProduct"/>"><bean:write name="detail" property="nameProduct"/></div></td>
          <td width="25%" class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detail" property="skuProduct"/>"><bean:write name="detail" property="skuProduct"/></div></td>
          <td width="0%" class="ListRow1"><div align="center"><input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="currencyProduct"/>"></div></td>
          <td width="7%" class="ListRow1"><div align="right"><input name='txtCostKitArray[]' type='hidden' value="<bean:write name="detail" property="costProduct"/>"><bean:write name="detail" property="costProduct"/></div></td>
          <td width="25%" class="ListRow1"><div align="center"><input name='txtIMEIArray[]' type='hidden'><input name='txtIMEI' type="text" maxlength="100" size="15" onkeydown="autocompleteImei(this,'<%=j%>')"/></div></td>
          <td width="0%" class="ListRow1"><div align="center"><input name='txtSIM' type="hidden" maxlength="100" size="20"/></div></td>          
      </tr>
      <%j++;%>
      </table></div>
      </logic:iterate>
      
      </logic:notEmpty>
        <table width="100%"  border="0">    
        <tr class="ListRow1"><td><div align="center"><input name="button2" type="button" style="width:110px" value="Seleccionar" onclick="javascript:SeleccionarProducto(false);"></div></td></tr>
        <tr class="ListRow1"><td><span class="PortletText1">Lista de Productos</span></td></tr>
       </table>
      </logic:equal>
      
  </logic:equal>
  

  <!-- EQUIPOS-->
  <logic:notEqual value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="4%" class="LeftSubTab"><div align="center"><strong>Eliminar</strong></div></td>
      <td width="13%" class="LeftSubTab"><div align="center"><strong>Promoci&oacute;n</strong></div></td>
      <td width="6%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>
      <td width="5%" class="LeftSubTab"><div align="center"><strong>Precio</strong></div></td>
      <td width="10%" class="LeftSubTab"><div align="center"><strong>Plan</strong></div></td>
      <td width="10%" class="LeftSubTab"><div align="center"><strong>Modelo</strong></div></td>
      <td width="11%" class="LeftSubTab"><div align="center"><strong>IMEI</strong></div></td>
      <td width="11%" class="LeftSubTab"><div align="center"><strong>SIM</strong></div></td>     
    <%
    if(idSpecification_product_prePago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection") || idSpecification_product_postPago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection"))                  
     { %>
      <td width="20%" class="LeftSubTab"><div align="center"><strong>PORTABILIDAD</strong></div></td>  
    <% } else{%>
      <td width="10%" class="LeftSubTab"><div align="center"><strong>Regi&oacute;n</strong></div></td>  
      <td width="10%" class="LeftSubTab" ><div align="center"><strong>Provincia</strong></div></td>   
      <td width="10%" class="LeftSubTab" ><div align="center"><strong>Distrito</strong></div></td> 
    <%}
    %>
    </tr>
  <logic:notEmpty name="OrderForm" property="tempListaOrdenes">
      <%java.lang.String productoAnterior = "ninguna";%>
      <div id="capa" style="width:100%; height:auto; z-index:1 ;overflow:auto" class="ListRow1" >    
      <logic:iterate id="detailFinal" property="tempListaOrdenes" name="OrderForm" indexId="indice2">
      <bean:define id="idItem" name="detailFinal" property="idItem"/>
      <div id="div_product_<%=idItem%>">
      <TR>
      <%
         if(!idItem.toString().equals(productoAnterior)){%>
      <td class="ListRow1"><div align="center"><input name='existe[]' type='hidden' ><input name='txtIdKitArray[]' type='hidden' value="<bean:write name="detail" property="idKitProducto"/>"><a href='javascript:eliminarItem(<%=idItem%>);'><img src='images/Eliminar.gif' width='16' height='15' title='Eliminar' border='0'></a></div></td>
      <td class="ListRow1"><div align="center"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detailFinal" property="nameKit"/>"><bean:write name="detailFinal" property="nameKit"/></div></td>
      <td class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detailFinal" property="skuKit"/>"><bean:write name="detailFinal" property="skuKit"/></div><input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="idMoneda"/>"></td>      
      <td class="ListRow1"><div align="right"><input name='txtCostKitArray[]' type='hidden' value="<bean:write name="detailFinal" property="cost"/>"><bean:write name="detailFinal" property="cost"/></div></td>
      <%}else{%>
       <td class="ListRow1"><div align="center"></div></td>
       <td class="ListRow1"><div align="center"></div></td>
       <td  class="ListRow1"><div align="center"></div></td>
       <td class="ListRow1"><div align="center"></div></td>
       <%}productoAnterior = idItem.toString();%>    
      <td  class="ListRow1">
        <input name='txtIdPlanArray[]' type='hidden' value="<bean:write name="detail" property="idPlan"/>">
        <div align="center"><input name='txtPlanNameArray[]' type='hidden' value="<bean:write name="detailFinal" property="namePlan"/>"><bean:write name="detailFinal" property="namePlan"/></div>
    </td>      
      <td class="ListRow1">
        <input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProducto"/>">
        <div align="center"><input name='txtModelNameArray[]' type='hidden' value="<bean:write name="detailFinal" property="nameModel"/>"><bean:write name="detailFinal" property="nameModel"/></div>
        </td>
      <td class="ListRow1"><div align="center"><input name='txtImeiArray2[]' type='hidden' value="<bean:write name="detailFinal" property="imei"/>"><bean:write name="detailFinal" property="imei"/></div></td>
      <td class="ListRow1"><div align="center"><bean:write name="detailFinal" property="sim"/></div></td>
    
        <%
             if(idSpecification_product_prePago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection") || idSpecification_product_postPago_portability == (Integer)request.getSession().getAttribute("idSpecificationSelection"))                  
             { %>
                <td class="ListRow1"> <a id="idportabilidad" name="idportabilidad" data="<bean:write name="detail" property="idKitProducto"/>" class="popup_view" value="aaaa"  href="#" title="Iniciar Sesi&oacute;n">Portabilidad</a></td>
           <% } else {%>
           <logic:notEmpty name="detailFinal" property="lstRegiones">
                <td class="ListRow1">              
                
                <select name="txtRegionArrayFinal[]"  class="comboRegion validateComboRegion">
                <option value="0" >--Seleccionar--</option>
                <logic:iterate id="regiones" property="lstRegiones" name="detailFinal" >
                    <option <c:if test="${detailFinal.codigoRegionSeleccion == regiones.idCobertura}" >selected</c:if>
                    value="<bean:write name="regiones" property="idCobertura"/>"><bean:write name="regiones" property="nombreZona"/></option>                    
                </logic:iterate>                
                </select>  
                </td>        
             
        
        <!--INI CESAR -->	
                     <logic:equal value="<%=productLineId_bafi%>" name="detailFinal" property="productLineId">        
            			
                <td class="ListRow1">            
                
                <select  name="txtProvinciaArrayFinal[]" class="comboProvincia validateComboProvincia" id="SelecProvincia">
                <option value="0" >--Seleccionar--</option>
				<logic:notEmpty name="detailFinal" property="lstProvincias">
					<logic:iterate id="provincias" property="lstProvincias" name="detailFinal" >
						<option <c:if test="${detailFinal.codigoProvinciaSeleccion == provincias.idProvincia}" >selected</c:if>
						value="<bean:write name="provincias" property="idProvincia"/>"><bean:write name="provincias" property="nombreProvincia"/></option>                    
					</logic:iterate>
				</logic:notEmpty>                  
                </select>  
                </td>        
        
                <td class="ListRow1">             
                
                <select name="txtDistritoArrayFinal[]" class="comboDistrito validateComboDistrito" id="SelecDistrito">
                <option value="0" >--Seleccionar--</option>
				<logic:notEmpty name="detailFinal" property="lstDistritos">
					<logic:iterate id="distritos" property="lstDistritos" name="detailFinal" >
						<option <c:if test="${detailFinal.codigoDistritoSeleccion == distritos.idDistrito}" >selected</c:if>
						value="<bean:write name="distritos" property="idDistrito"/>"><bean:write name="distritos" property="nombreDistrito"/></option>                    
					</logic:iterate>
				</logic:notEmpty> 					
                </select>  
                </td> 
		</logic:equal>				
                <logic:notEqual value="<%=productLineId_bafi%>" name="detailFinal" property="productLineId">        
				<td>
				<select name="txtProvinciaArrayFinal[]" class="comboProvincia" style="display:none">
					<option value="0" >--Seleccionar--</option>
				</select>
				</td>
				<td>
				<select name="txtDistritoArrayFinal[]" class="comboDistrito" style="display:none">
					<option value="0" >--Seleccionar--</option>
				</select>
				</td>
			</logic:notEqual>
        <!-- FIN CESAR-->  
        </logic:notEmpty>   
        
        
        <logic:empty name="detailFinal" property="lstRegiones">
            <td>
            <select name="txtRegionArrayFinal[]" class="comboRegion" style="display:none">
                <option value="0" >--Seleccionar--</option>
            </select>
            </td>
            <td>
            <select name="txtProvinciaArrayFinal[]" class="comboProvincia" style="display:none">
                <option value="0" >--Seleccionar--</option>
            </select>
            </td>
            <td>
            <select name="txtDistritoArrayFinal[]" class="comboDistrito" style="display:none">
                <option value="0" >--Seleccionar--</option>
            </select>
            </td>
        </logic:empty> 
           <%            
           }
           %>
      </tr></div>
      </logic:iterate>
      </table>
      </div>
      </logic:notEmpty>
      </logic:notEqual>
  <!--PRODUCTOS -->
   <logic:equal value="<%=productoSerie%>" name="OrderForm" property="idSpecification">
   <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="8%" class="LeftSubTab"><div align="center"><strong>Eliminar</strong></div></td>
      <td width="35%" class="LeftSubTab"><div align="center"><strong>Nombre</strong></div></td>
      <td width="25%" class="LeftSubTab"><div align="center"><strong>SKU</strong></div></td>
      <td width="7%" class="LeftSubTab"><div align="center"><strong>Precio</strong></div></td>
      <td width="25%" class="LeftSubTab"><div align="center"><strong>Nro Producto</strong></div></td>
    </tr>
  </table>
  <logic:notEmpty name="OrderForm" property="tempListaOrdenes">
  <div id="capa" style="width:100%; height:150px; z-index:1 ;overflow:auto" class="ListRow1" >  
  <logic:iterate id="detailFinalProduct" property="tempListaOrdenes" name="OrderForm" indexId="indice2">
  <bean:define id="idItem2" name="detailFinalProduct" property="idItem"/>
  <div id="div_product_<%=idItem2%>">
  <table width="100%" border="0" cellpadding="0">
  <TR>
  <td width="8%" class="ListRow1"><div align="center"><input name='existe[]' type='hidden'><input name='txtIdKitArray[]' type='hidden' value="<bean:write name="detail" property="idProduct"/>"><a href='javascript:eliminarItem(<%=idItem2%>);'><img src='images/Eliminar.gif' width='16' height='15' title='Eliminar' border='0'></a></div></td>
  <td width="0%" class="ListRow1"><div align="center"><input name='txtIdProductArray[]' type='hidden' value="<bean:write name="detail" property="idProduct"/>"></div></td>
  <td width="20%" class="ListRow1"><div align="center"><input name='txtNameKitArray[]' type='hidden' value="<bean:write name="detail" property="nameProduct"/>"><bean:write name="detailFinalProduct" property="nameModel"/></div></td>
  <td width="10%" class="ListRow1"><div align="center"><input name='txtSkuKitArray[]' type='hidden' value="<bean:write name="detail" property="skuProduct"/>"><bean:write name="detailFinalProduct" property="skuKit"/></div></td>
  <td width="0%" class="ListRow1"><div align="center"><input name='txtCurrencyArray[]' type='hidden' value="<bean:write name="detail" property="currencyProduct"/>"></div></td>
  <td width="10%" class="ListRow1"><div align="right"><input name='txtCostKitArray[]' type='hidden' value="<bean:write name="detail" property="costProduct"/>"><bean:write name="detailFinalProduct" property="cost"/></div></td>
  <td width="10%" class="ListRow1"><div align="center"><input name='txtIMEIArray[]' type='hidden' value="<bean:write name="detail" property="numberProduct"/>"><bean:write name="detailFinalProduct" property="imei"/></div></td>
  </tr>
  </table>
  </div>
  </logic:iterate>
  </div>
  </logic:notEmpty>
   </logic:equal>
  <table width="100%"  border="0">
    <tr class="ListRow1">
      <td width="50%" >
        <div align="right">
          <input name="button" type="button" style="width:110px" onClick="javascript:agregar_producto();" value="Agregar">        
          </div></td>
      <td width="50%" ><input name="button3" type="button" style="width:110px" onClick="javascript:cancelar();" value="Cancelar"></td>
    </tr>
  </table>
</td>
    </tr>
    </table>
 
  <logic:notEmpty scope="request" name="AlertImeiRepetido">
  <script type="text/javascript">
  var imei='<%=request.getAttribute("IMEI")%>';
  alert('El Nro. de Producto: '+imei+' ya se encuentra Reservado, o no corresponde al Producto Seleccionado');
  </script>
  </logic:notEmpty>
 
   <logic:notEmpty scope="request" name="AlertExistDeudaCliente">
  <script type="text/javascript">
      var msgExistDeudaCliente='<%=request.getAttribute("MsgExistDeudaCliente")%>';
      alert(msgExistDeudaCliente);
  </script>
  </logic:notEmpty>
  
  <logic:notEmpty scope="request" name="AlertPhoneRepetido">
  <script type="text/javascript">
  var phone='<%=request.getAttribute("PHONEREPETIDO")%>';
  alert('El Nro. : '+phone+' ya se encuentra Registrado,en otro Producto Seleccionado');
  </script>
  </logic:notEmpty>
    <!-- JATORRESC 30-06-2014 Popup Portabilidad INI -->
       <div id="login_form" style="display:none; opacity: 0.8;" class="popup_portablity_view-overlay" align="center" tabindex='-1'> 
              <div id="box1" class="box1">
                <a id="xCerrar" href="#" title="Cerrar" class="modalCloseImg simplemodal-close alignLeftCerrar"><img src="images/boton_cerrar.gif" border="0" /> </a>
              <input id='hddIndicePortability' type='hidden'>
              
             <h1 align="center" class="PortletHeaderText PortletHeaderColor" >Portabilidad </h1>                      
                 <table align="center">  
               <tr class="ListRow1">
                   <td class="LeftSubTab"><strong>Cedente</strong></td>
                   <td><bean:define id="idcedente" name="OrderForm" property="lstCedentes"/>
                      <html:select property="txtcedente" styleId="txtcedente" >
                         <option value="0" >--Seleccionar--</option>
                         <html:optionsCollection name="idcedente" value="npparameterid" label="npparametername" />
                      </html:select>
                   </td>
               </tr>                                  
                     
               <tr class="ListRow1">
                   <td class="LeftSubTab"><strong>Teléfono a portar</strong></td>
                   <td>
                        <input name=" " id="txtnumeroPortabilidad" onkeypress="return soloNumeros(event);" type="text" size="11"
                        maxLength="9"/>
                   </td>
               </tr>        
              
              
               <tr class="ListRow1">
                   <td class="LeftSubTab" ><strong>Origen</strong></td>
                   <td><bean:define id="idOrigen" name="OrderForm" property="lstOrigenes"/>
                     <html:select property="txtoperadora" styleId="txtoperadora">
                        <option value="0" >--Seleccionar--</option>
                        <html:optionsCollection name="idOrigen" value="npparameterid" label="npparametername" />
                     </html:select></td>
              </tr>
              
               <tr class="ListRow1">
                  <td class="LeftSubTab"><strong>Tipo de Documento</strong></td>
                  <td><bean:define id="idTipoDocumento" name="OrderForm" property="lstTipoDocumento"/>
                      <html:select property="txtTipoDocumento" styleId="txtTipoDocumento">
                         <option value="0" >--Seleccionar--</option>
                         <html:optionsCollection name="idTipoDocumento" value="npparameterid" label="npparametername" />
                      </html:select>
                   </td>
               </tr>
               
                <tr class="ListRow1">
                  <td class="LeftSubTab"><strong>N&uacute;mero de Documento</strong></td>
                  <td>
                        <input name="txtNumeroDocumento" id="txtNumeroDocumento" 
                        onkeypress="return soloNumeros(event);" type="text" size="11"/>
                  </td>
               </tr>              
              
              <tr class="ListRow1">
                    <td colspan="2" align="center">
                       <input value="Aceptar"  type="button" name="btnAceptar" id="btnAceptar" onclick="return jsValidarPortabilidad();"/>
                       <input value="Cancelar" class="simplemodal-close" type="button"/>
                    </td>  
              </tr>   
                  <tr class="ListRow1">
                    <td colspan="2" align="center">
                     <font color='red'> <label id="valid"/> </font>
                    </td>  
                 </tr> 
                </table>                   
               </div>             
          </div>
      
             <div id="popup_view_form" style="display:none; opacity: 0.8;" class="popup_portablity_view-overlay" align="center" tabindex='-1'> 
              <div id="box1" class="box1">                
                    <h1 align="center" class="PortletHeaderText PortletHeaderColor" >Portabilidad
                        <a href="#" title="Cerrar" class="modalCloseImg simplemodal-close alignLeftCerrar">
                       
                        </a>        
                    </h1>
                 <table align="center">  
                      <tr class="ListRow1">
                            <td class="LeftSubTab" ><strong>Cedente</strong></td>
                            <td><bean:define id="idcedenteview" name="OrderForm" property="lstCedentes"/>
                                <html:select property="txtCedenteview" disabled="true">
                                    <option value="0" >--Seleccionar--</option>
                                    <html:optionsCollection name="idcedenteview" value="npparameterid" label="npparametername" />
                                </html:select>
                            </td>
                     </tr>                             
                    
                     <tr class="ListRow1">
                            <td class="LeftSubTab" ><strong>Teléfono a portar</strong></td>
                            <td><label class="txtFormLogin" id="lblTelefonoview"></label></td>
                            <td></td>
                     </tr>
                     <tr class="ListRow1">
                            <td class="LeftSubTab" ><strong>Origen</strong></td>
                            <td><bean:define id="idorigenview" name="OrderForm" property="lstOrigenes"/>
                                <html:select property="txtOperadoraView" disabled="true">
                                    <option value="0" >--Seleccionar--</option>
                                    <html:optionsCollection name="idorigenview" value="npparameterid" label="npparametername" />
                                </html:select>
                            </td>
                     </tr>
                     
                     <tr class="ListRow1">
                  <td class="LeftSubTab"><strong>Tipo de Documento</strong></td>
                  <td><bean:define id="idTipoDocumentoView" name="OrderForm" property="lstTipoDocumento"/>
                      <html:select property="txtTipoDocumentoView" disabled="true">
                         <option value="0" >--Seleccionar--</option>
                         <html:optionsCollection name="idTipoDocumentoView" value="npparameterid" label="npparametername" />
                      </html:select>
                   </td>
               </tr>
               
                <tr class="ListRow1"> 
                  <td class="LeftSubTab"> <strong>N&uacute;mero de Documento</strong></td>
                  <td>
                      <label class="txtFormLogin" id="txtNumeroDocumentoView">xxx</label>
                  </td>
               </tr>
                <!--Inicio RPASCACIO 11-09-2014 Agregar Boton Cerrar y darle funcionalidad-->
               <tr><td>&nbsp;</td></tr>
               
                <tr>                    
                    <td colspan="2" align="center">
                       <input value="Cerrar"  type="button" name="btnCerrar" id="btnCerrar" class="simplemodal-close" style="width: 100px;"/>                       
                    </td>  
              </tr>   
                <!--Inicio RPASCACIO 11-09-2014 Agregar Boton Cerrar y darle funcionalidad-->
                </table>           
               </div>             
          </div>
</html:form>

</body>
</html>