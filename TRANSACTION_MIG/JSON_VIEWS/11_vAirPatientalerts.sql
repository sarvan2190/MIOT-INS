CREATE VIEW vAirPatientalerts              
AS               
SELECT               
(select              
pat.guid as '_id.$oid',    
(select top 1 guid from PatientVisit p where p.PatientUID=PAT.UID ) as 'patientvisituid.$oid',                      
PAT.Guid  As 'patientuid.$oid',              
(SELECT TOP 1 GUID FROM HealthOrganisation WHERE UID=pat.OwnerOrganisationUID) AS 'orguid.$oid' ,            
(SELECT TOP 1 UID FROM HealthOrganisation WHERE UID=pat.OwnerOrganisationUID) AS 'orgcode' ,            
  isnull((select top 1 DBO.FGETLOCATIONGUID(pvc.locationUID) from patientvisit pv,patientvisitcareprovider pvc where pvc.patientvisituid=pv.uid            
 and pv.patientuid=pat.uid  and pvc.statusflag='A' AND PV.STATUSFLAG='A'AND PVC.statusflag='A'            
and PVC.RandomNumber='Y'),(select top 1 DBO.FGETLOCATIONGUID(pvc.locationUID) from patientvisit pv,patientvisitcareprovider pvc where pvc.patientvisituid=pv.uid            
 and pv.patientuid=pat.uid  and pvc.statusflag='A' AND PV.STATUSFLAG='A'AND PVC.statusflag='A'            
and PVC.RandomNumber is null)) 'departmentuid.$oid',            
( SELECT   paa.GUid as '_id.$oid',            
paa.UID externaluid  ,   
--dbo.fgetreferencevalueguid(ALRPRTUID) 'alerttypeuid.$oid',  
ISNULL(dbo.fgetreferencevalueguid(ALRPRTUID) ,'5c763c315d836f29be355500') 'alerttypeuid.$oid',             
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,ISNULL(OnsetDttm,CWhen))) as bigint) * 1000  AS NVARCHAR(50)) 'startdate.$date.$numberLong',              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,ClosureDttm )) as bigint) * 1000  AS NVARCHAR(50)) 'enddate.$date.$numberLong',                
case when (ClosureDttm >GETDATE()  OR ClosureDttm IS NULL ) THEN  convert(bit,'true') else convert(bit,'false') end 'isactive',              
dbo.fgetreferenceguid(sevtyuid)'severityuid.$oid',            
AlertDescription as alertmessage,              
convert(bit,'true') alldepartments,              
(select top 1 guid from healthorganisation where UID=paa.OwnerOrganisationUID) AS 'orguid.$oid',            
(select top 1 uid from healthorganisation where UID=paa.OwnerOrganisationUID) AS 'orgcode',            
PAT.uid externaluidpatient,            
'patientalert' externaltablename   
FROM               
PatientAlert PAA              
WHERE        
paa.StatusFlag='A' AND         
PAA.PatientUID =PAT.UID FOR JSON PATH)  alerts   ,            
isnull((select top 1 guid from careprovider c where c.uid=PAT.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',                                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,PAT.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                      
isnull((select top 1 guid from careprovider c where c.uid=PAT.muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid',                                                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,PAT.MWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                      
PAT.StatusFlag statusflag                    
            
from               
Patient  PAT  (nolock)           
where pat.uid in(select patientuid from patientalert where statusflag='A')              
 fOR JSON PATH ) AS Y       
    
    
    
    