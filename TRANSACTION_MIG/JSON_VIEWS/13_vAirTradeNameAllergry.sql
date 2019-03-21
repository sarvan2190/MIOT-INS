CREATE VIEW vAirTradeNameAllergry  
AS  
Select  
(  
SELECT   
DBO.FGETPASID(PATIENTUID) patientmrn,  
(select top 1 p.guid from patient p where p.uid=pa.PATIENTUID)'patientuid.$oid',  
isnull((select top 1 dbo.fgetvisitid(pv.uid) from patientvisit pv where pv.patientuid=pa.patientuid),  
dbo.fgetvisitid(pa.patientvisituid))patientvisitnumber,  
(select top 1 pv.guid from patientvisit pv where pv.patientuid=pa.patientuid)'patientvisituid.$oid',  
ISNULL((SELECT TOP 1 dbo.fMSTCareProviderLocationbyguid(PV.CAREPROVIDERuid) from patientvisit pv WHERE PV.UID=PA.PATIENTVISITUID),  
(SELECT TOP 1 L.GUID FROM LOCATION L,PATIENTVISIT PV WHERE PV.LOCATIONUID=L.UID  
AND L.STATUSFLAG='A' AND LOTYPUID=10039))'departmentuid.$oid',  
(Select  
'575a5f47c7fe0e1a7a321001' 'typeuid.$oid',--Tradename  
(SELECT TOP 1 DC.guid FROM DRUGCATALOGITEM DC WHERE DC.UID=PAD.DRUGCATALOGITEMUID AND DC.STATUSFLAG='A') 'tradenameuid.$oid',  
(SELECT TOP 1 DC.code FROM DRUGCATALOGITEM DC WHERE DC.UID=PAD.DRUGCATALOGITEMUID AND DC.STATUSFLAG='A') 'tradename',  
 (select top 1 guid from referencevalue rf where rf.uid=pa.SEVTYUID) 'severityuid.$oid',  
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,isnull(PA.ONSETDTTM,pa.cwhen))) as bigint) * 1000  AS NVARCHAR(50))  'onsetdate.$date.$numberLong',        
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,isnull(PA.ONSETDTTM,pa.cwhen))) as bigint) * 1000  AS NVARCHAR(50))  'closuredate.$date.$numberLong',        
CASE WHEN DBO.fGetReferenceValCode(PA.ALGSTUID)='ACTIV' THEN convert(bit,'true') ELSE convert(bit,'false') END isactive,   
null comments,  
(select top 1 guid from referencevalue rf where rf.uid=pa.ADRSTATUID)'confirmationuid.$oid'  
from PatientAllergicDrug PADD  
WHERE PAD.PATIENTALLERGYUID=PA.UID  
AND PADD.UID=PAD.UID  
AND PADD.STATUSFLAG='A'  
AND PADD.identifyingtype='TRADE'  
FOR JSON PATH ) AS drugallergies,  
isnull((select top 1 guid from careprovider c where c.uid=PA.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',                 
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,PA.CWhen )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                        
isnull((select top 1 guid from careprovider c where c.uid=PA.cuser),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                  
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,PA.MWhen)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                        
PA.statusflag,      
(SELECT TOP 1 GUID FROM HealthOrganisation WHERE uid=pa.OwnerOrganisationUID) AS 'orguid.$oid',  
(SELECT TOP 1 UID FROM HealthOrganisation WHERE uid=pa.OwnerOrganisationUID) AS 'orgcode',  
pa.uid externaluid,  
'patientallergy' externaltablename,  
pad.uid patientallergicdrugexternaluid,  
'patientallergicdrug' patientallergicdrugtable  
FROM PatientAllergy PA,  
PatientAllergicDrug PAD  
WHERE PA.UID=PAD.PATIENTALLERGYUID  
AND PAD.DRUGCATALOGITEMUID IN(SELECT  DRUGCATALOGITEMuid from drugtradename)  
AND PA.STATUSFLAG='A'  
AND PAD.STATUSFLAG='A'  
AND PAD.identifyingtype='TRADE'  
AND PA.PATIENTUID IN(SELECT PATIENTUID FROM PATIENTVISIT)  
and pa.patientuid in(select p.uid from patient p)  
for json path) as x  
  
  
  