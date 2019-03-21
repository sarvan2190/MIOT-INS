CREATE VIEW  vAirpatientCCHPI      
AS              
SELECT             
(            
select            
PV.guid as 'patientvisituid.$oid',            
(select top 1 guid from patient p where p.uid=pv.patientuid ) as 'patientuid.$oid',            
PV.Statusflag as 'statusflag',            
isnull((SELECT top 1 dbo.fGetlocationguid(PVC.locationuid) from Patientvisitcareprovider PVC WHERE PVC.Patientvisituid =PV.UID AND PVC.statusflag='A'      
and PVC.RandomNumber='Y'),(SELECT top 1 dbo.fGetlocationguid(PVC.locationuid) from Patientvisitcareprovider PVC WHERE PVC.Patientvisituid =PV.UID AND PVC.statusflag='A'      
and PVC.RandomNumber is null)) as 'departmentuid.$oid',             
isnull((select top 1 guid from careprovider c where c.uid=PV.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',                                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,pv.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                
isnull((select top 1 guid from careprovider c where c.uid=pv.muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid',                                                  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,pv.MWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',         
(SELECT TOP 1 GUID FROM HEALTHORGANISATION WHERE uid=pv.OwnerOrganisationUID) 'orguid.$oid',       
(select top 1 uid from healthorganisation where uid=pv.OwnerOrganisationUID) AS 'orgcode',      
           
(SELECT         
guid as '_id.$oid',      
 ISNULL(complient ,'')+'        
  Remarks :' + isnull(Remarks,'')  As chiefcomplaint,        
  UID as externalcchpiuid         
 FROM CCHPI WHERE visitUID =PV.UID  FOR JSON PATH)        
  cchpis    ,        
  PV.patientuid externalpatientuid,        
  PV.UID externalpatientvisituid        
FROM             
Patientvisit PV  (nolock)            
WHERE             
PV.StatusFlag='A'            
AND EXISTS ( SELECT 1 FROM CCHPI PP WHERE PV.UID =PP.VisitUID AND PP.StatusFlag='A')          
FOR JSON PATH) AS Y         
      
  