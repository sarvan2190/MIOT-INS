CREATE VIEW vAirRadiologyReport        
AS        
SELECT(        
      
SELECT         
RT.guid  '_id.$oid',      
(SELECT TOP 1 pv.guid from patientvisit pv where pv.uid=po.patientvisituid) as 'patientvisituid.$oid',        
(SELECT TOP 1 p.guid from patient p where p.uid=po.patientuid) as 'patientuid.$oid',        
--(select top 1 _id from patientorderguids pd where pd.externaluid=po.uid)       
po.guid as 'patientorderuid.$oid',        
--(select top 1 _id from patientorderdetail pd where pd.externaluid=pod.uid)      
pod.guid as 'patientorderitemuid.$oid',        
bi.guid as 'orderitemuid.$oid',        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,res.RESULTENTEREDDTTM)) as bigint) * 1000  AS NVARCHAR(50))   'resultdate.$date.$numberLong' ,        
null impressiontext,        
(select top 1 r.guid from referencevalue r where r.uid=res.RABSTSUID) as 'radstsuid.$oid',        
(Select top 1 dbo.fGetlocationguid(pvc.LocationUID) from Patientvisitcareprovider PVC WHERE PVC.Patientvisituid =PO.PATIENTVISITUID AND PVC.statusflag='A' )  as 'userdepartmentuid.$oid',          
(select top 1 c.guid from careprovider c where c.uid=po.orderraisedby) 'careprovideruid.$oid',        
(select top 1 guid from careprovider c where c.uid=res.acknowledgeduseruid) as 'acknowledgedby.$oid',        
(select top 1 guid from careprovider c where c.uid= rd.radiologistuid) 'radiologistuid.$oid',        
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,Res.acknowledgeddttm)) as bigint) * 1000  AS NVARCHAR(50))  'acknowledgeddate.$date.$numberLong',              
(select top 1 c.guid from careprovider C where uid=res.cuser) 'resultuseruid.$oid',        
'579b0d24f3fd3fa90b83e33f' as 'statusuid.$oid',        
null approvaldate,        
null approvaluseruid,        
bi.itemname itemname,        
rt.htmlresult resulttext,        
(select top 1 forename from careprovider c where c.uid=po.orderraisedby) careprovidername,        
isnull((select top 1 guid from careprovider where uid=res.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',         
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,Res.CWhen)) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',              
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,Res.MWhen)) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',          
isnull((select top 1 guid from careprovider where uid=res.cuser),'5c7659e45d836f29be36758c') as'modifiedby.$oid',             
res.Statusflag statusflag,        
(select top 1 guid from healthorganisation where uid=po.OwnerOrganisationUID ) as 'orguid.$oid',        
(select top 1 uid from healthorganisation where uid=po.OwnerOrganisationUID) as 'orgcode',        
cast(res.uid as nvarchar) externaluid,      
'Result'externaltablename              
FROM        
PATIENTORDER PO(NOLOCK),        
PATIENTORDERDETAIL POD(NOLOCK),         
BILLABLEITEM BI(NOLOCK),        
RESULT RES(NOLOCK),        
REQUESTDETAIL RD(NOLOCK),        
RESULTCOMPONENT RC(NOLOCK),        
REQUESTITEM RI(NOLOCK),        
RESULTTEXTUAL RT(NOLOCK)        
        
WHERE        
PO.UID=POD.PatientOrderUID        
AND POD.IdentifyingType='REQUESTDETAIL'        
AND POD.IdentifyingUID=RD.UID        
AND RES.REQUESTDETAILUID=RD.UID        
and RD.REQUESTITEMUID=RI.UID        
AND RES.REQUESTDETAILUID=RD.UID        
AND RC.RESULTUID=RES.UID        
AND BI.ITEMUID=RI.UID        
AND BI.BSMDDUID=45980        
and bi.statusflag='A'        
AND RI.RICATUID=5170        
AND RT.RESULTCOMPONENTUID=RC.UID        
AND RI.STATUSFLAG='A'        
AND RC.STATUSFLAG='A'        
AND RES.STATUSFLAG='A'        
AND RT.htmlresult IS NOT NULL      
for json path) as x        
    
    
    
    
    
    
    