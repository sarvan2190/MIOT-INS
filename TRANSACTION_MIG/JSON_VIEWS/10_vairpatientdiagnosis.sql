CREATE VIEW  vairpatientdiagnosis            
AS              
SELECT             
(            
select        
PV.GUID AS '_id.$oid',         
PV.guid as 'patientvisituid.$oid',            
(select top 1 guid from patient p where p.uid=pv.patientuid )  as 'patientuid.$oid',            
PV.Statusflag as 'statusflag',            
isnull((SELECT top 1 dbo.fGetlocationguid(PVC.locationuid) from Patientvisitcareprovider PVC WHERE PVC.Patientvisituid =PV.UID AND PVC.statusflag='A'      
and PVC.RandomNumber='Y'),(SELECT top 1 dbo.fGetlocationguid(PVC.locationuid) from Patientvisitcareprovider PVC WHERE PVC.Patientvisituid =PV.UID AND PVC.statusflag='A'      
and PVC.RandomNumber is null)) as 'departmentuid.$oid',                
(SELECT TOP 1 GUID   FROM HEALTHORGANISATION WHERE UID=pv.OwnerOrganisationUID) 'orguid.$oid',            
(SELECT  PB.GUID as '_id.$oid',    
P.GUID As 'problemuid.$oid',            
isnull((SELECT top 1 dbo.fGetCareproviderguid(PVC.careprovideruid) from Patientvisitcareprovider PVC WHERE PVC.Patientvisituid =PV.UID      
 AND PVC.statusflag='A'),dbo.fGetCareproviderguid(PV.careprovideruid)) 'careprovideruid.$oid',      
--dbo.fGetCareproviderguid(PB.RecordedBy) 'careprovideruid.$oid',            
dbo.fGetReferenceValueguid(PB.SEVTYUID) 'severityuid.$oid' ,            
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PB.RecordedDttm )) as bigint) * 1000  AS NVARCHAR(50))   'onsetdate.$date.$numberLong' ,                
case WHEN PB.HistoryFlag ='A' then 'true' else 'false' end  isactive,            
case WHEN PB.DIAGTYPUID =55629 then 'true' else 'false' end externalcause,            
case WHEN PB.DIAGTYPUID =55625 then 'true' else 'false' end isprimary,            
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,ClosureDttm )) as bigint) * 1000  AS NVARCHAR(50)) 'closuredate.$date.$numberLong',      
pb.uid externaluid,      
'patientproblem' externaltablename            
FROM PatientProblem PB,            
Problem P            
WHERE PB.PatientVisitUID =PV.UID             
AND PB.ProblemUID =P.UID             
AND PB.StatusFlag='A'            
FOR JSON PATH) diagnosis,      
'patientproblem'externaltablename,      
isnull((select top 1 guid from careprovider c where c.uid=PV.CUser),'5c7659e45d836f29be36758c') as 'createdby.$oid',              
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PV.CWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',            
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PV.MWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',         
isnull((select top 1 guid from careprovider c where c.uid=PV.Muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid'            
FROM             
Patientvisit PV     (nolock)         
WHERE             
PV.StatusFlag='A'            
AND EXISTS ( SELECT 1 FROM PatientProblem PP WHERE PV.UID =PP.PatientVisitUID AND PP.StatusFlag='A')            
FOR JSON PATH) AS Y     
    