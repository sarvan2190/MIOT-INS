CREATE VIEW vairobservations         
AS            
SELECT           
(          
select          
pr.guid as '_id.$oid',  
(select top 1 pv.guid from patientvisit pv where pv.uid=pr.patientvisituid) as 'patientvisituid.$oid',          
(select top 1 guid from patient p where p.uid=pr.patientuid) as 'patientuid.$oid',          
PR.Statusflag as 'statusflag',    
(    
select     
(select top 1 ore.guid from orderresultitem ore where ore.code=por.Comments    
and ore.statusflag='a')'orderresultitemuid.$oid',    
por.resultitemname as 'name',    
(select top 1 rf.alternatename  from referencevalue rf where rf.uid=por.itmtpuid and rf.statusflag='A') resulttype,    
por.resultvalue resultvalue,    
isabnormal HLN,    
CASE WHEN por.isabnormal='N' then por.referencerange else '' end normalrange,    
(select top 1 rf.guid from referencevalue rf where rf.uid=por.uomuid)'uomuid.$oid',    
por.displayorder displayorder,    
'patientorderresultitem'externalporitablename,    
por.uid externaluid    
from patientorderresultitem por    
where por.OrderResultItemUID=PR.uid    
and por.statusflag='A'    
FOR JSON PATH)AS  observationvalues,    
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,PR.ResultEnteredDttm )) as bigint) * 1000  AS NVARCHAR(50))   'observationdate.$date.$numberLong',    
(SELECT TOP 1 L.GUID FROM location l,careproviderlocation cl where cl.locationuid=l.uid and cl.careprovideruid=pr.cuser    
and cl.statusflag='A' AND L.STATUSFLAG='A')'userdepartmentuid.$oid',    
null observinguseruid,    
 null careprovideruid,    
 (select top 1 guid from ordercatalogitem oc where oc.uid=pr.ordercatalogitemuid)'orderitem.$oid',    
(select top 1 oc.guid from ordercatalogitem oc where oc.statusflag='A' AND OC.UID=PR.ordercatalogitemuid)'orderitemuid.$oid',    
convert(bit,'false')isreusedfromothermodules,    
null notrecordingreasonuid,    
(SELECT TOP 1 GUID FROM HEALTHORGANISATION WHERE uid=pr.ownerorganisationuid) 'orguid.$oid',    
isnull((select top 1 guid from careprovider c where c.uid=PR.CUser),'5c7659e45d836f29be36758c') as 'createdby.$oid',            
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PR.CWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',          
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PR.MWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',       
isnull((select top 1 guid from careprovider c where c.uid=PR.Muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid',    
'patientorderresult'externaltablename,    
pr.uid externaluid          
FROM       
PatientOrderResult PR    
FOR JSON PATH) AS X    
  
  