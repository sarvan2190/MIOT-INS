CREATE VIEW vAirMedicalItems        
As        
select        
(       
select   
       
m.medicalitemname +' '+'Duration:'+' '+ ISNULL(CAST(m.duration AS NVARCHAR),'') +' '+ ISNULL(m.aguomuid,'') pasthistorytext,        
(select top 1 p.guid from patient p where p.uid=pm.patientuid)'patientuid.$oid',        
(select top 1 p.guid from patientvisit p where p.uid=pm.patientvisituid)'patientvisituid.$oid',       
ISNULL((select top 1 L.guid from location L,patientvisit pv,PatientVisitCareProvider pvc where l.uid=pv.locationuid      
and pv.uid=pm.PatientVisitUID and pvc.PatientVisitUID=pv.uid      
and pvc.StatusFlag='A'      
and l.StatusFlag='A'      
AND PV.StatusFlag='A'),(select top 1 L.guid from location L,patientvisit pv where      
 l.uid=pv.locationuid      
and pv.uid=pm.PatientVisitUID      
and l.StatusFlag='A'      
AND PV.StatusFlag='A')) 'departmentuid.$oid',        
'5c7659e45d836f29be36758c' AS 'createdby.$oid',                                 
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,m.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                                  
'5c7659e45d836f29be36758c' AS 'modifiedby.$oid',                            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,m.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                                  
m.statusflag statusflag,                
(select top 1 guid from healthorganisation where UID=pm.OwnerOrganisationUID) AS 'orguid.$oid',        
(select top 1 uid from healthorganisation where UID=pm.OwnerOrganisationUID) as orgcode,        
'MEDICALITEM' externaltablename,        
M.UID externaluid        
FROM MEDICALITEM M  (nolock),      
PATIENTMEDICALHISTORY pm (nolock)       
WHERE pm.uid=m.patientmedicalhistoryUID        
AND M.hasmedicalhistoy='Y'        
FOR JSON PATH) AS X  