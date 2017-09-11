package com.nextel.service;

import com.nextel.action.OrderAction;
import com.nextel.aditional.OrderDetailForList;
import com.nextel.aditional.PreviousOrder;
import com.nextel.bean.Distrito;
import com.nextel.bean.NpCategory;
import com.nextel.bean.NpCustomerPreEvaluation;
import com.nextel.bean.NpDivision;
import com.nextel.bean.NpLiquidation;
import com.nextel.bean.NpOrder;
import com.nextel.bean.NpProductLinea;
import com.nextel.bean.NpSolution;
import com.nextel.bean.NpSubCategory;
import com.nextel.bean.NpTypeLine;
 /*Apolarc Proyecto Telefonia Fija */
import com.nextel.bean.NpCentroDeCosto;
/* fin Apolarc */
import com.nextel.bean.NpCpuf;
import com.nextel.bean.NpDocument;
import com.nextel.bean.NpParameter;
import com.nextel.bean.Provincia;
import com.nextel.bean.ZonaCobertura;
import com.nextel.core.ApplicationContext;
import com.nextel.dao.NpOrderDAO;
import com.nextel.dao.type.GeneralType;
import com.nextel.exception.ServiceException;
import com.nextel.idao.INpOrderDAO;
import com.nextel.iservice.INpOrderService;

import com.nextel.iservice.INpParameterService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import com.nextel.utilities.Constant;
import org.apache.log4j.Logger;

import org.springframework.ws.client.core.WebServiceTemplate;

import pe.com.entel.esb.srv_customer.srv_adjustment.v1.CalcularProrratedAmountRequest;
import pe.com.entel.esb.srv_customer.srv_adjustment.v1.CalcularProrratedAmountResponse;
import pe.com.entel.esb.srv_customer.srv_adjustment.v1.Item;


/**
 * Data access object (DAO) for domain model class NpOrder.
 * @see com.nextel.service.NpOrder
 * @author Sonda del Perú
 */
public class NpOrderService extends BaseService implements INpOrderService {

    private INpOrderDAO objNpOrderDao;
    private com.nextel.idao.ibatis.INpOrderDAO objIbatisNpOrderDao;
    private static Logger logger = Logger.getLogger(NpOrderService.class);
    private static pe.com.entel.esb.srv_customer.srv_adjustment.v1.ObjectFactory   ofcalcularProrrateo= new pe.com.entel.esb.srv_customer.srv_adjustment.v1.ObjectFactory();
                        

    public void insertEntity(NpOrder bean)   {
        
            this.objNpOrderDao.insertEntity(bean);
         
    }

    public void updateEntity(NpOrder bean)     {
     
            this.objNpOrderDao.updateEntity(bean);
        
    }

    //CRM****
     public List<NpTypeLine> findTypeLinexIdSolution(Long idSolution)  {
     
             return this.objNpOrderDao.findTypeLinexIdSolution(idSolution);
         
     }
    
    public List getSolution(NpSolution beanParam)     {
     
            return this.objNpOrderDao.getSolution(beanParam);
       
    }
    //*
    
    //CRM - 22-07-09 PARA OBTENER LA LISTA DE DIVISION
     public List getDivision(NpDivision beanParam)   {
        
             return this.objNpOrderDao.getDivision(beanParam);
         
     }
    
    //***
    //CRM - 22-07-09 PARA OBTENER LAS CATEGORIAS POR ID DE DIVISION
    public List<NpCategory> findCategoryxIdDivision(Long idDivision)   {
         
             return this.objNpOrderDao.findCategoryxIdDivision(idDivision);
       
     }
    //********
     //CRM - 22-07-09 PARA OBTENER LA SUB_CATEGORIA POR ID DE CATEGORIA
     public List<NpSubCategory> findSubCategoryxIdCategoria(Long idCategoria)   {
        
              return this.objNpOrderDao.findSubCategoryxIdCategoria(idCategoria);
          
      }
     //********
     //CRM - 23-07-09 PARA OBTENER LAS SOLUCIONES X ID DE SUB_CATEGORIA
     public List<NpSolution> findSolutionxIdSubCategoria(Long idSubCategoria)     {
           
               return this.objNpOrderDao.findSolutionxIdSubCategoria(idSubCategoria);
          
       }
      //********
    
       //CRM - 09-08-09 PARA OBTENER LAS LAS LINEAS DE PRODUCTO POR ID DE SOLUCION INTERNO
       public List<NpProductLinea> findProductLineaXIdSolution(Long idSolutionInternal)   {
              
                 return this.objNpOrderDao.findProductLineaXIdSolution(idSolutionInternal);
          
         }
        //********
    
    public void deleteEntity(NpOrder bean)   {
       
            this.objNpOrderDao.deleteEntity(bean);
         
    }

    public NpOrder findById(java.lang.Long id)     {
       
            return this.objNpOrderDao.findById(id);
      
    }

    public List getEntities(NpOrder beanParam)    {
     
            return this.objNpOrderDao.getEntities(beanParam);
        
    }

    public List getEntityByProperty(String propertyName, 
                                    Object value)   {
        
            return this.objNpOrderDao.getEntityByProperty(propertyName, value);
        
    }

    public INpOrderDAO getObjNpOrderDao() {
        return objNpOrderDao;
    }

    public void setObjNpOrderDao(INpOrderDAO objNpOrderDao) {
        this.objNpOrderDao = objNpOrderDao;
    }
    
    public int getExistOrder(String numberorden,Long flagVenta)   {
       
            return this.objNpOrderDao.getExistOrder(numberorden,flagVenta);
         
    }
    

    public String updateOrderById(Integer nporderid,Integer npsourceregister)   {
       
            return this.objNpOrderDao.updateOrderById(nporderid,npsourceregister);
         
    }

//DEANAYAC - RENIEC
    public String updateOrderVerify(Integer orderID, String npConex, 
                                    String verifica,String sMotivoRechazo)   {
         
            return this.objNpOrderDao.updateOrderVerify(orderID,npConex,verifica,sMotivoRechazo);
       
    }
    /* INICIO
     * CREATED BY : FBERNALES   -- PROYECTO: PORTABILIDAD  
     *                          -- REQUERIMIENTO : OBTENER INFORMACION DE RENIEC - EQUIFAX
    */
    public Hashtable getListCountItemsByInventoryCode(Integer orderID)   {
         
            return this.objNpOrderDao.getListCountItemsByInventoryCode(orderID);
        
    }
    public Integer getSpecificationIdByOrderID(Integer orderID)  {
        
            return this.objNpOrderDao.getSpecificationIdByOrderID(orderID);
         
    }
    /* FIN */ 
    
     //***
     //Paul Rivera 13-08-2014
     //Inicia método para actualizar Depósito en Garantía y RA
     public String getUpdateWarranty(String nporderid, String warrantyPay, String voucher, String tipoDeposito, String dateGuarantee, String place)  {
       
             return this.objNpOrderDao.getUpdateWarranty(nporderid, warrantyPay, voucher, tipoDeposito, dateGuarantee, place);
          
     }
     //Fin método
     
      //***
      //Paul Rivera 13-08-2014
      //Inicia método para actualizar Depósito en Garantía y RA
      public String getTodayRent()  {
       
              NpOrderDAO o=new NpOrderDAO();
              return o.getTodayRent();
          
      }
      //Fin método

    public Double getBetweenDate(String fecha)  {
       
        return  this.objNpOrderDao.getBetweenDate(fecha);
          
    }

    public NpLiquidation getTemporalEquifax(Long externalDataid) {
       
          return  this.objNpOrderDao.getTemporalEquifax(externalDataid);
        
    }


    //MSOTO OFERTAPLUS
    public NpLiquidation getTemporalEquifaxCust(Long idNextelCustomer)   {
       
          return  this.objNpOrderDao.getTemporalEquifaxCust(idNextelCustomer);
         
    }  
    
    
    public Long ObtenerIdLiquidation(Integer idOrden)  {
     
          return  this.objNpOrderDao.ObtenerIdLiquidation(idOrden);
       
    }

    public void updLiquidationHistory(Long idliquidation, Long npcustomer, 
                                      Long npBussines)  {
        
          this.objNpOrderDao.updLiquidationHistory(idliquidation,npcustomer,npBussines);
        
    }
    
    //FBERNALES - REGULARIZACION DEL NUMERO DE SIM EN BASE A EL IMEI.
    //          av_nporderid           IN NUMBER,
    //          av_npposid             IN NUMBER,
    //          av_imeinumber          IN VARCHAR2 ,
    //          av_simnumberfromorder  IN VARCHAR2,
    //          av_message            OUT VARCHAR2
    public Boolean updSimByEmei_Regularization(Integer iNPOrderId, 
                                               Integer iNpPosId
                                               )  {
        
          return this.objNpOrderDao.updSimByEmei_Regularization(iNPOrderId, iNpPosId);
       
    }

    public Long getExternalDataID(Integer OrdenId)  {
      
          return this.objNpOrderDao.ObtenerExternalDataId(OrdenId);
         
    }

    //FBERNALES RUC20 - ACTUALIZAMOS EL ID DEL CONTACTO PARA LA ORDEN QUE SE HA GENERADO
    public String updateNpContactByOrderId(Integer nporderid,Integer npcontactcustomerid)  {
       
            return this.objNpOrderDao.updateNpContactByOrderId(nporderid,npcontactcustomerid);
      
    }

    public Integer Obtenersite(Integer OrdenId)   {
    
            return this.objNpOrderDao.Obtenersite(OrdenId);
      
    }
    
      
    public Integer validateSynchroOrder(Integer OrdenId)  {
    
          return this.objNpOrderDao.validateSynchroOrder(OrdenId);
         
    }
    
    public String synchronizeCreditOrder (Integer idOrden, Integer posId, String userName) {
      
          return this.objNpOrderDao.synchronizeCreditOrder(idOrden,posId,userName);
 
    }
    public Boolean getTypeOperFromPreEvaluation (NpCustomerPreEvaluation beanCustomerPreEval) {
      
          return this.objNpOrderDao.getTypeOperFromPreEvaluation(beanCustomerPreEval);
       
    }
    
     public Boolean updTypeOperationOrder (Integer idOrden, String sTypeOper)   {
       
           return this.objNpOrderDao.updTypeOperationOrder(idOrden,sTypeOper);
          
     }
     
    //MSOTO 09022015 
    public Boolean updPreevaluationOrder (Integer idOrden, Long idCustomerPreeval)   {
     
          return this.objNpOrderDao.updPreevaluationOrder(idOrden,idCustomerPreeval);
        
    }
    
    //FBERNALES - 09/04/2015 - Se genera la orden en CRM - tipo de ordenes producstos con Serie     
    public Boolean insCRMorderProductoSerie (Integer idOrden)  {
     
          return this.objNpOrderDao.insCRMorderProductoSerie(idOrden);
         
    }

   public String updateVoucherByImei(Integer idOrden, List<GeneralType> listImeis)     {
      return this.objNpOrderDao.updateVoucherByImei(idOrden, listImeis);
}
   
       /*Apolarc Proyecto Telefonia Fija */
    public List<NpCentroDeCosto> findCentroCostoXidCustomer(Long idCustomer)   {
   
             return this.objNpOrderDao.findCentroCostoIdCustomer(idCustomer);
      
     }
     
    /* fin Apolarc */

  public String getDivisionByOrderId(Float orderId){

        return this.objNpOrderDao.getDivisionByOrderId(orderId);

  }

  public String getOrderTypeByOrderId(Integer orderId){
    return this.objIbatisNpOrderDao.getOrderTypeByOrderId(orderId);
}


  public void setObjIbatisNpOrderDao(com.nextel.idao.ibatis.INpOrderDAO objIbatisNpOrderDao){
    this.objIbatisNpOrderDao = objIbatisNpOrderDao;
  }

  public com.nextel.idao.ibatis.INpOrderDAO getObjIbatisNpOrderDao(){
    return objIbatisNpOrderDao;
  }
  
  public List<String> obtenerComentarioPreevaluacion(Long orderid) {
       return objNpOrderDao.obtenerComentarioPreevaluacion(orderid) ;
  }
  
  /* AMATEO REQ-0007 */
  public List<PreviousOrder> listarOrdenesPrevias(Long customerretailid, Long divisionid, Long categoriaid, Long subcategoriaid) {
    return objNpOrderDao.listarOrdenesPrevias(customerretailid,divisionid,categoriaid,subcategoriaid);
}

  public String obtenerEstadoVisualizacion(Long divisionid, Long categoriaid, Long subcategoriaid) {
    return objNpOrderDao.obtenerEstadoVisualizacion(divisionid,categoriaid,subcategoriaid);
  }
    
   /* FIN AMATEO REQ-0007 */
	  
   //Ricardo Quispe 
   public HashMap getDetailOrder(Integer qGenerar){
      return objIbatisNpOrderDao.getDetailOrder(qGenerar);
    }
    
    public HashMap  getRegisterLog( HashMap regulation ){
      return  objIbatisNpOrderDao.getRegisterLog(regulation);
    }
    
    public String  getUpdLogRegulation(Long order,Long idlog, Integer sesion,String status){
       return  objIbatisNpOrderDao.getUpdLogRegulation(order,idlog,sesion,status);
    }
  
    //AGN

    /**
     * @param listaCpuf
     * @return
     */
    public String insCpuf (List<NpCpuf> listaCpuf)  {      
           return this.objIbatisNpOrderDao.insCpufByOrderId(listaCpuf);          
     }
     
    public void delCpuf (int orderId)  {      
           this.objIbatisNpOrderDao.delCpuf(orderId);          
     }
     
    public String getNumSolPrePos(String documentType, String modality)  {      
           return this.objIbatisNpOrderDao.getNumSolPrePos(documentType, modality);          
     }
     
    public List<NpDocument> getDocuments (int specification, String segment){
        return this.objIbatisNpOrderDao.getDocuments(specification, segment);          
    }
    
    public String getSegment (Long idClient){
        return this.objIbatisNpOrderDao.getSegment(idClient);          

    }
    public String getSubcategory(int specificationId){
        return this.objIbatisNpOrderDao.getSubcategory(specificationId);          
    }
    
    public List<NpCpuf> getCpufs(int orderId){
        return this.objIbatisNpOrderDao.getCpufs(orderId);          
    }
    
    public List<NpDocument> getDocumentsGenerated (int orderId){
        return this.objIbatisNpOrderDao.getDocumentsGenerated(orderId);          
    }
    
    public HashMap<String, String> getCorreoEmpresa(int orderId){
        return this.objIbatisNpOrderDao.getCorreoEmpresa(orderId);          
    }
    
    public HashMap<String, Object> getCorreoPersona(int orderId){
        return this.objIbatisNpOrderDao.getCorreoPersona(orderId);          
    }
    
    public String getMailFields(String tipo){
        return this.objIbatisNpOrderDao.getMailFields(tipo);         

    }
    
    public void actualizarOrdenNoBiometrico(Long orderId, String reason){
        this.objIbatisNpOrderDao.actualizarOrdenNoBiometrico(orderId, reason);         
    }
    
    public void actualizarOrdenNumber(Long orderId, String orderNumber ){
        this.objIbatisNpOrderDao.actualizarOrdenNumber(orderId, orderNumber);         
    }
    
    public void actualizarOrdenStatus(Long orderId){
        this.objIbatisNpOrderDao.actualizarOrdenStatus(orderId);         
    }
    
    public Long getMultipleOrderId(){
        return this.objIbatisNpOrderDao.getMultipleOrderId();         
    }

    public void actualizarOrdenDocumentosGenerados(Long orderId,  String docsGenerados){
        this.objIbatisNpOrderDao.actualizarOrdenDocumentosGenerados(orderId, docsGenerados);         
    }

    public List<NpOrder> getListsOrders(Long multipleOrderId){
        return this.objIbatisNpOrderDao.getListsOrders(multipleOrderId);         
    }
    
    public List<NpOrder> getOrderStatus(Long orderId){
        return this.objIbatisNpOrderDao.getOrderStatus(orderId);         
    }
    
    public void actualizarOrdenTipoManual(Long orderId, String reason){
        this.objIbatisNpOrderDao.actualizarOrdenTipoManual(orderId, reason);         
    }
    
    public String getFlag(String parametername){
        return this.objIbatisNpOrderDao.getFlag(parametername);         
    }
     //
  
    //LROQUE
    public int getValidateIdentidadOk(Object orderid){
        int result = 0;
        if(orderid != null){
            if(orderid instanceof String){
                String cOrder = (String)orderid;
                cOrder = cOrder.trim();
                if(!cOrder.isEmpty()){
                    result = this.objNpOrderDao.getValidateIdentidadOk(new Long(cOrder));
                }
            }else if(orderid instanceof Long){
                Long lOrder = (Long)orderid;
                result = this.objNpOrderDao.getValidateIdentidadOk(lOrder);
            }
        }
        
        return result;
    }

    //JMEDINA 15/02/17
    public List<ZonaCobertura> getListaRegiones(int codigoProducto) {
        return this.objNpOrderDao.getListaRegiones(codigoProducto);        
    }

//CVALDIVIEZO 15/02/17
    public List<Provincia> getListaProvincia(int codigoProducto,int codigoRegion) {
        return this.objNpOrderDao.getListaProvincia(codigoProducto,codigoRegion);        
    }
    
    public List<Distrito> getListaDistrito(int codigoProducto,int codigoProvincia) {
        return this.objNpOrderDao.getListaDistrito(codigoProducto,codigoProvincia);        
    }

    public String getPortaPhoneNumberValidatePrefijo(String phonenumber) {
        return this.objNpOrderDao.getPortaPhoneNumberValidatePrefijo(phonenumber);
      }
      
    public Long getSimFlag(Long orderId)  {
            return this.objIbatisNpOrderDao.getSimFlag(orderId);      
    }  
    
    public String insReprocessLog(Long orderId, String status, String flag)  {     
            return this.objIbatisNpOrderDao.insReprocessLog(orderId, status, flag);        
    }

    //Rquispe
    public List<OrderDetailForList> getListMontoAnticipado(List<OrderDetailForList> listOrderDetail,long idCadena,String documento,String idTransaction) {

            //String status=get               
             float  montoAnticipado=0.0f;
             String skuThinkis="";
             String messageErrorThinkis="";
             long   tmcode=0L;
             boolean  estadoPostpago=false;              
             String messageProrrateo ="";
            HashMap<String, Object> hash= new HashMap<String, Object>();
             try{      
                
               WebServiceTemplate getAjusmentService = (WebServiceTemplate)ApplicationContext.getBean("getAdjusmentService");
               
               CalcularProrratedAmountRequest  calcularProrrateRequest = ofcalcularProrrateo.createCalcularProrratedAmountRequest();
               
               calcularProrrateRequest.setNumeroDocumento(documento);
               calcularProrrateRequest.setExternalId(idTransaction);
               int listOrderDetail_size = listOrderDetail.size();
               for(int i=0;i<listOrderDetail_size;i++) {                  
                  tmcode = this.GetTmcode(listOrderDetail.get(i).getIdPlan());  
                  listOrderDetail.get(i).setTmcode(tmcode);
               }
               
               listOrderDetail_size = listOrderDetail.size();
               for(int i=0;i<listOrderDetail_size;i++) {
                   int contador=0;
				   int calcularProrrateRequest_size=calcularProrrateRequest.getItems().size();
                   for(int x=0;x<calcularProrrateRequest_size;x++){                       
                      if(listOrderDetail.get(i).getTmcode()==calcularProrrateRequest.getItems().get(x).getTemplateCoId())
                      {  contador++; }
                   }
                   
                   if(contador==0){
                       Item   item=  ofcalcularProrrateo.createItem();
                       item.setTemplateCoId(listOrderDetail.get(i).getTmcode());          
                       calcularProrrateRequest.getItems().add(item);
                   }
               }                 
                 CalcularProrratedAmountResponse calcularProrrateResponse = (CalcularProrratedAmountResponse)getAjusmentService.marshalSendAndReceive(calcularProrrateRequest);
                 estadoPostpago=calcularProrrateResponse.isHasPostpaid();
                 
				 listOrderDetail_size = listOrderDetail.size();
                 for(int i=0;i<listOrderDetail_size;i++) {
					 int calcularProrrateResponse_size= calcularProrrateResponse.getItems().size();
                     for(int x=0;x<calcularProrrateResponse_size;x++){                       
                         if(listOrderDetail.get(i).getTmcode()==calcularProrrateResponse.getItems().get(x).getTemplateCoId())
                         {  
                             if(estadoPostpago==false &&  calcularProrrateResponse.getStatus()==0){
                                 hash=this.getObtenerMontoAnticipado(idCadena,calcularProrrateResponse.getItems().get(x).getAmount()); 
                                 montoAnticipado=(Float) hash.get("montoAnticipado"); 
                                 skuThinkis=(String) hash.get("skuAnticipado");   
                                 messageProrrateo =(String) hash.get("av_message");                             
                                 listOrderDetail.get(i).setMessageErrorThinkis(messageProrrateo);
                                 listOrderDetail.get(i).setSkuAnticipado(skuThinkis);
                                 listOrderDetail.get(i).setCicloOrigen(calcularProrrateResponse.getOldBillCycle());
                                 listOrderDetail.get(i).setCicloDestino(calcularProrrateResponse.getNewBillCycle());  
                                 listOrderDetail.get(i).setIdCustomer(calcularProrrateResponse.getCustomerId()== null?0:calcularProrrateResponse.getCustomerId());
                                 listOrderDetail.get(i).setMontoAnticipadoThinkis(calcularProrrateResponse.getItems().get(x).getAmount());
                                 listOrderDetail.get(i).setEstadoAnticipado(String.valueOf(calcularProrrateResponse.getStatus())); 
                                 listOrderDetail.get(i).setMontoAnticipado(montoAnticipado);
                             }else{
                                 if( calcularProrrateResponse.getStatus()!=0){
                                    listOrderDetail.get(i).setMessageErrorThinkis(calcularProrrateResponse.getMessage());
                                 }
                                 listOrderDetail.get(i).setMontoAnticipado( montoAnticipado);
                                 listOrderDetail.get(i).setEstadoAnticipado(String.valueOf(calcularProrrateResponse.getStatus())); 
                                 listOrderDetail.get(i).setIdCustomer(0);
                                 listOrderDetail.get(i).setSkuAnticipado("");
                                 listOrderDetail.get(i).setIdCustomer(calcularProrrateResponse.getCustomerId()== null?0:calcularProrrateResponse.getCustomerId());
                                 listOrderDetail.get(i).setCicloOrigen(calcularProrrateResponse.getOldBillCycle());
                                 listOrderDetail.get(i).setCicloDestino(calcularProrrateResponse.getNewBillCycle());
                             }      
                        }    
                       }
                }                
             }catch(Exception e){
                 messageErrorThinkis=e.getMessage()+((e.getCause() != null)?e.getCause().getMessage():"");
                 logger.error("Idcadena: "+idCadena+" Documento: "+documento+" IdTransaction: "+idTransaction +"Message:"+ e.getMessage()+ ((e.getCause() != null)?e.getCause().getMessage():""));
                 int listOrderDetail_size = listOrderDetail.size();
                 for(int i=0;i<listOrderDetail_size;i++) {
                     listOrderDetail.get(i).setMontoAnticipado(0.0f);
                     listOrderDetail.get(i).setEstadoAnticipado("-3");
                     listOrderDetail.get(i).setSkuAnticipado("");
                     listOrderDetail.get(i).setMessageErrorThinkis(messageErrorThinkis);
                     listOrderDetail.get(i).setIdCustomer(0);
                     listOrderDetail.get(i).setCicloOrigen("");
                     listOrderDetail.get(i).setCicloDestino("");                              
                 }
             }            
              return listOrderDetail;
        }

    public String getFlagActivacionAnticipado(long subCategoria,String tipoDocumento) {
            return this.objIbatisNpOrderDao.getFlagActivacionAnticipado(subCategoria,tipoDocumento);      
        }

    public HashMap<String, Object> getObtenerMontoAnticipado(long cadena, double monto) {
            return this.objIbatisNpOrderDao.getObtenerMontoAnticipado(cadena,monto);
        }

    public HashMap<String, Object> getDatoTransacctionPorrateo(long idCustomerRetail) {
             return this.objIbatisNpOrderDao.getDatoTransacctionPorrateo(idCustomerRetail);      
        }

    //JESPINOZA PRY 0890 - VALIDAR ORDEN POSTPAGO
    public boolean ValidarOrderPostpago(long idOrder){
        return this.objIbatisNpOrderDao.ValidarOrderPostpago(idOrder);
    }

    public HashMap<String, Object> getMontoAnticipado(List<OrderDetailForList> listOrderDetail, 
                                                      List<OrderDetailForList> listForm, 
                                                      long idCadena,long idCustomer) {
      
        HashMap<String, Object> hash= new HashMap<String, Object>();
        
        INpParameterService parameterService = (INpParameterService)getInstance("NpParameterService");
        
        String messageError= "";
        String documentoNumber="";
        String   idTransaction=""; 
        
        try {
        
             hash=this.getDatoTransacctionPorrateo(idCustomer);   
             documentoNumber=(String) hash.get("docNumber");
             idTransaction = (String) hash.get("SeqTransaction");
             
             listOrderDetail= this.getListMontoAnticipado(listOrderDetail,idCadena,documentoNumber,idTransaction);
             hash.put("listOrderDetail",listOrderDetail);
             hash.put("SeqTransaction",Long.parseLong(idTransaction));
             
               if(!listOrderDetail.get(0).getEstadoAnticipado().equals(Constant.VENTA_STATUS_CALCULAR) ){
                 messageError=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_ERROR_THINKIS).getNpparametervalue1();    
               }else if(listOrderDetail.get(0).getEstadoAnticipado().equals(Constant.VENTA_STATUS_CALCULAR) && listOrderDetail.get(0).getMessageErrorThinkis() != null){
                    if(listOrderDetail.get(0).getMessageErrorThinkis().toLowerCase().contains(Constant.ERROR_SKU)){
                     messageError=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_MS_NOT_SKU).getNpparametervalue1();  
                    }
               }else if(listOrderDetail.get(0).getEstadoAnticipado().equals(Constant.VENTA_STATUS_CALCULAR) && listOrderDetail.get(0).getSkuAnticipado().isEmpty()){ 
                 messageError=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_MS_POSTPAGO_THINKIS).getNpparametervalue1();  
               }
                              
               hash.put("messageError",messageError);
        
         }catch (ServiceException e) {
            logger.error(e.getMessage());
            
        }
      
        return hash;
    }



    public HashMap<String, Object> getMontoAnticipadoMultiple(List<OrderDetailForList> listOrderDetail, 
                                                      List<OrderDetailForList> listForm, 
                                                      long idCadena,long idCustomer) {
      
        HashMap<String, Object> hash= new HashMap<String, Object>();
        INpParameterService parameterService = (INpParameterService)getInstance("NpParameterService");
        int specificationIdPostPago             =  Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO);
        int specificationIdPostPagoPortability  =  Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO_PORTABILITY);
        String messageProrrateo ="";
        String  messageError= "";
        String  documentoNumber="";
        String  idTransaction=""; 
        int     posicion=-1;      
        try {
        
             hash=this.getDatoTransacctionPorrateo(idCustomer);   
             documentoNumber=(String) hash.get("docNumber");
             idTransaction = (String) hash.get("SeqTransaction");
             
             listOrderDetail= this.getListMontoAnticipadoMultiple(listOrderDetail,idCadena,documentoNumber,idTransaction);
             hash.put("listOrderDetail",listOrderDetail);
             hash.put("SeqTransaction",Long.parseLong(idTransaction));
             
             int listOrderDetail_size = listOrderDetail.size();
             for(int i=0;i<listOrderDetail_size;i++) {                       
                if(listOrderDetail.get(i).getIdSpecification()==specificationIdPostPago || listOrderDetail.get(i).getIdSpecification()==specificationIdPostPagoPortability )
                  {  posicion=i; }
             }             
             
             if(posicion >= 0){ 
                logger.info("Size: "+listOrderDetail.size()+"  posicion: "+posicion+ "  estado:"+listOrderDetail.get(posicion).getEstadoAnticipado());
                if(!listOrderDetail.get(posicion).getEstadoAnticipado().equals(Constant.VENTA_STATUS_CALCULAR) ){
                   messageError=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_ERROR_THINKIS).getNpparametervalue1();             
                }else if(listOrderDetail.get(posicion).getEstadoAnticipado().equals(Constant.VENTA_STATUS_CALCULAR) && listOrderDetail.get(posicion).getMessageErrorThinkis() != null){
                     if(listOrderDetail.get(posicion).getMessageErrorThinkis().toLowerCase().contains(Constant.ERROR_SKU)){
                           messageError=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_MS_NOT_SKU).getNpparametervalue1();  
                     }
                 }else if(listOrderDetail.get(posicion).getEstadoAnticipado().equals(Constant.VENTA_STATUS_CALCULAR) && listOrderDetail.get(posicion).getSkuAnticipado().isEmpty()){ 
                   messageError=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_MS_POSTPAGO_THINKIS).getNpparametervalue1();             
                 } 
               }
             
          hash.put("messageError",messageError);
        
         }catch (ServiceException e) {
            logger.error(e.getMessage());
        }
        
        return hash;
    }
    
    protected Object getInstance(String strInstance) {
         return ApplicationContext.getBean(strInstance);
    }

    public String GetValidOrderPago(long order) {
        return this.objIbatisNpOrderDao.GetValidOrderPago(order);  
    }

    public long GetTmcode(long idplan) {    
        return this.objIbatisNpOrderDao.GetTmcode(idplan);  
    }

    public List<OrderDetailForList> getListMontoAnticipadoMultiple(List<OrderDetailForList> listOrderDetail, 
                                                                   long idcadena, 
                                                                   String documento, 
                                                                   String idTransaction) {
        int specificationIdPostPago             =  Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO);
        int specificationIdPostPagoPortability  =  Integer.parseInt(Constant.P_SPECIFICATIONID_POSTPAGO_PORTABILITY);
        INpParameterService parameterService = (INpParameterService)getInstance("NpParameterService");
        //String status=get               
         float  montoAnticipado=0.0f;
         String skuThinkis="";
         String messageErrorThinkis="";
         String messageProrrateo="";
         long   tmcode=0L;
         boolean  estadoPostpago=false;              
         String flagActivacion="";
         
         HashMap<String, Object> hash= new HashMap<String, Object>();
         
         try{
             
             //validar el estado del flag y tipo de categoria
         //    flagActivacion=parameterService.getEntityByxNameDomainXValue(Constant.DOMAIN_RETAIL_PAGO_ANTICIPADO,Constant.PARAMETER_ERROR_THINKIS).getNpparametervalue1();
                  
         //    if(!flagActivacion.equals(Constant.P_ACTIVE)){return listOrderDetail;}
                 
             WebServiceTemplate getAjusmentService = (WebServiceTemplate)ApplicationContext.getBean("getAdjusmentService");
              
             CalcularProrratedAmountRequest  calcularProrrateRequest  = ofcalcularProrrateo.createCalcularProrratedAmountRequest();
             calcularProrrateRequest.setNumeroDocumento(documento);
             calcularProrrateRequest.setExternalId(idTransaction);
             int listOrderDetail_size= listOrderDetail.size();
             for(int i=0;i<listOrderDetail_size;i++) {                  
                tmcode = this.GetTmcode(listOrderDetail.get(i).getIdPlan());  
                listOrderDetail.get(i).setTmcode(tmcode);
             }
             
             listOrderDetail_size= listOrderDetail.size(); 
             for(int i=0;i<listOrderDetail_size;i++) {
                 int contador=0;
				 int calcularProrrate_size=calcularProrrateRequest.getItems().size();
                 for(int x=0;x<calcularProrrate_size;x++){                       
                    if(listOrderDetail.get(i).getTmcode()==calcularProrrateRequest.getItems().get(x).getTemplateCoId()
                       && (listOrderDetail.get(i).getIdSpecification()==specificationIdPostPago || listOrderDetail.get(i).getIdSpecification()==specificationIdPostPagoPortability ))
                    {  contador++; }
                 }
                 
                 if(contador==0 &&  (listOrderDetail.get(i).getIdSpecification()==specificationIdPostPago || listOrderDetail.get(i).getIdSpecification()==specificationIdPostPagoPortability )){
                     Item   item=  ofcalcularProrrateo.createItem();
                     item.setTemplateCoId(listOrderDetail.get(i).getTmcode());          
                     calcularProrrateRequest.getItems().add(item);
                 }
             }
                          
             CalcularProrratedAmountResponse calcularProrrateResponse = (CalcularProrratedAmountResponse)getAjusmentService.marshalSendAndReceive(calcularProrrateRequest);
             estadoPostpago=calcularProrrateResponse.isHasPostpaid();
             logger.info("Estatus:"+calcularProrrateResponse.getStatus());
             
             listOrderDetail_size= listOrderDetail.size(); 
             for(int i=0;i<listOrderDetail_size;i++) {
		 int calcularProrrateResponse_size=calcularProrrateResponse.getItems().size();
                 for(int x=0;x<calcularProrrateResponse_size;x++){                       
                     if(listOrderDetail.get(i).getTmcode()==calcularProrrateResponse.getItems().get(x).getTemplateCoId() &&  (listOrderDetail.get(i).getIdSpecification()==specificationIdPostPago || listOrderDetail.get(i).getIdSpecification()==specificationIdPostPagoPortability ))
                     {  
                         if(estadoPostpago==false &&  calcularProrrateResponse.getStatus()==0 ){
                             hash=this.getObtenerMontoAnticipado(idcadena,calcularProrrateResponse.getItems().get(x).getAmount()); 
                             montoAnticipado=(Float) hash.get("montoAnticipado"); 
                             skuThinkis=(String) hash.get("skuAnticipado");
                             messageProrrateo =(String) hash.get("av_message");                             
                             listOrderDetail.get(i).setMessageErrorThinkis(messageProrrateo);
                             
                             listOrderDetail.get(i).setSkuAnticipado(skuThinkis);
                             listOrderDetail.get(i).setCicloOrigen(calcularProrrateResponse.getOldBillCycle());
                             listOrderDetail.get(i).setCicloDestino(calcularProrrateResponse.getNewBillCycle());  
                             listOrderDetail.get(i).setIdCustomer(calcularProrrateResponse.getCustomerId()== null?0:calcularProrrateResponse.getCustomerId());
                             listOrderDetail.get(i).setMontoAnticipadoThinkis(calcularProrrateResponse.getItems().get(x).getAmount());
                             listOrderDetail.get(i).setEstadoAnticipado(String.valueOf(calcularProrrateResponse.getStatus()));
                             listOrderDetail.get(i).setMontoAnticipado(montoAnticipado);
                         }else{
                                 if( calcularProrrateResponse.getStatus()!=0){
                                 listOrderDetail.get(i).setMessageErrorThinkis(calcularProrrateResponse.getMessage());
                                 }
                                 listOrderDetail.get(i).setMontoAnticipado( montoAnticipado);
                                 listOrderDetail.get(i).setEstadoAnticipado(String.valueOf(calcularProrrateResponse.getStatus())); 
                                 listOrderDetail.get(i).setIdCustomer(0);
                                 listOrderDetail.get(i).setSkuAnticipado("");
                                 listOrderDetail.get(i).setIdCustomer(calcularProrrateResponse.getCustomerId()== null?0:calcularProrrateResponse.getCustomerId());
                                 listOrderDetail.get(i).setCicloOrigen(calcularProrrateResponse.getOldBillCycle());
                                 listOrderDetail.get(i).setCicloDestino(calcularProrrateResponse.getNewBillCycle());

                         }      
                    }    
                   }
             }              
         }catch(Exception e){         
             messageErrorThinkis= e.getMessage()+ ((e.getCause() != null)?e.getCause().getMessage():" ");
             logger.error("Idcadena: "+idcadena+" Documento: "+documento+" IdTransaction: "+idTransaction+"Message:"+  e.getMessage()+ ((e.getCause() != null)?e.getCause().getMessage():" "));
             int listOrderDetail_size = listOrderDetail.size();
             for(int i=0;i<listOrderDetail_size;i++) {
                listOrderDetail.get(i).setMontoAnticipado(0.0f);
                listOrderDetail.get(i).setEstadoAnticipado("-3");
                listOrderDetail.get(i).setSkuAnticipado("");
                listOrderDetail.get(i).setMessageErrorThinkis(messageErrorThinkis);
                listOrderDetail.get(i).setIdCustomer(0);
                listOrderDetail.get(i).setCicloOrigen("");
                listOrderDetail.get(i).setCicloDestino("");
            }             
         }            
        return listOrderDetail;      
    }
}
