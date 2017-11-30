package org.tempuri;

import java.rmi.RemoteException;

public class WmgwSoapProxy implements org.tempuri.WmgwSoap {
  private String _endpoint = null;
  private org.tempuri.WmgwSoap wmgwSoap = null;
  
  public WmgwSoapProxy() {
    _initWmgwSoapProxy();
  }
  
  public WmgwSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initWmgwSoapProxy();
  }
  
  private void _initWmgwSoapProxy() {
    try {
      wmgwSoap = (new org.tempuri.WmgwLocator()).getwmgwSoap();
      if (wmgwSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)wmgwSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)wmgwSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (wmgwSoap != null)
      ((javax.xml.rpc.Stub)wmgwSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public org.tempuri.WmgwSoap getWmgwSoap() {
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap;
  }
  
  public java.lang.String mongateCsSpSendSmsNew(java.lang.String userId, java.lang.String password, java.lang.String pszMobis, java.lang.String pszMsg, int iMobiCount, java.lang.String pszSubPort) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateCsSpSendSmsNew(userId, password, pszMobis, pszMsg, iMobiCount, pszSubPort);
  }
  
  public java.lang.String mongateSendSubmit(java.lang.String userId, java.lang.String password, java.lang.String pszMobis, java.lang.String pszMsg, int iMobiCount, java.lang.String pszSubPort, java.lang.String msgId) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateSendSubmit(userId, password, pszMobis, pszMsg, iMobiCount, pszSubPort, msgId);
  }
  
  public java.lang.String mongateMULTIXSend(java.lang.String userId, java.lang.String password, java.lang.String multixmt) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateMULTIXSend(userId, password, multixmt);
  }
  
  public java.lang.String[] mongateCsGetSmsExEx(java.lang.String userId, java.lang.String password) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateCsGetSmsExEx(userId, password);
  }
  
  public java.lang.String[] mongateCsGetStatusReportExEx(java.lang.String userId, java.lang.String password) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateCsGetStatusReportExEx(userId, password);
  }
  
  public int mongateQueryBalance(java.lang.String userId, java.lang.String password) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateQueryBalance(userId, password);
  }
  
  public java.lang.String[] mongateGetDeliver(java.lang.String userId, java.lang.String password, int iReqType) throws java.rmi.RemoteException{
    if (wmgwSoap == null)
      _initWmgwSoapProxy();
    return wmgwSoap.mongateGetDeliver(userId, password, iReqType);
  }
  
  public static void main(String[] args) {
	  WmgwSoapProxy wmgwSoapProxy = new WmgwSoapProxy();
	  try {
		wmgwSoapProxy.mongateCsSpSendSmsNew("J22807", "546412", "13632332694", "【会掌柜】您的验证码为685221；十分钟内有效!", 1, "");
	} catch (RemoteException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  }
}