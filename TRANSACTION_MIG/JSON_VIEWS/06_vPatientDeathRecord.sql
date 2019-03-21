CREATE VIEW vPatientDeathRecord      
AS      
Select(      
select     
pdd.guid '_id.$oid',   
(select top 1 guid from patient p where p.uid=pdd.patientuid)'patientuid.$oid',      
(select top 1 guid from patientvisit pv where pv.uid=pdd.patientvisituid)'patientvisituid.$oid',      
(select top 1 l.guid from Location l,careproviderlocation cl where cl.careprovideruid=pdd.cuser and cl.locationuid=l.uid  ) 'departmentuid.$oid',      
case when (select top 1 isdead from patientaeadmission pae where pae.patientvisituid=pdd.patientvisituid)='Y' then 'true' else 'false' end isdiedoutsidehospital,      
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', Dateadd(hh,-5.30,isnull(pdd.Deathtime,pdd.deathdttm))) as bigint) * 1000  AS NVARCHAR(50))  'deathdatetime.$date.$numberLong' ,            
(SELECT TOP 1 GUID FROM ReferenceValue WHERE UID=dcsrnuid)'deathreasonuid.$oid',      
(SELECT TOP 1 GUID FROM Careprovider C WHERE C.UID=CONFIRMEDBY)'confcareprovideruid.$oid',      
case when (select top 1 isdead from patientaeadmission pae where pae.patientvisituid=pdd.patientvisituid)='Y' then 'true' else 'false' end isbroughdead,      
PDD.Comments comments,      
null sendtouid,      
 CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,pdd.CWHEN)) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong' ,                 
isnull((select top 1 guid from Careprovider c where c.uid=pdd.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',         
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,pdd.mwhen)) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong' ,                   
isnull((select top 1 guid from Careprovider c where c.uid=pdd.muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid',          
pdd.statusflag statusflag,      
(select top 1 guid from healthorganisation where uid=pdd.OwnerOrganisationUID) 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=pdd.OwnerOrganisationUID) orgcode,      
pdd.uid externaluid      
from patientdeceaseddetail pdd      
for json path) as x    