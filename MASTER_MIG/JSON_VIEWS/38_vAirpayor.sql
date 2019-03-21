CREATE VIEW vAirpayor    
AS    
SELECT    
(    
SELECT    
IC.GUID AS '_id.$oid',    
(select     
DISTINCT    
ip.guid as '_id.$oid',     
LTRIM(RTRIM(PD.CODE)) tpa,    
PA.GUID AS 'payoragreementuid.$oid',    
PD.GUID AS 'tpauid.$oid',    
PA.CODE+'_'+CAST(PA.UID AS NVARCHAR) pacode,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,IP.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,IP.activeto )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
pa.uid pauid,    
IP.STATUSFLAG statusflag,    
IP.uid externaluid     
    
FROM    
INSURANCEPLAN IP,    
PAYORDETAIL PD,    
PAYORAGREEMENT PA    
WHERE    
IC.UID = IP.IDENTIFYINGUID    
AND IP.PAYORDETAILUID = PD.UID    
AND PA.UID = IP.PAYORAGREEMENTUID    
AND IP.STATUSFLAG = 'A'    
AND PD.STATUSFLAG = 'A'    
AND IC.STATUSFLAG = 'A'    
AND PA.STATUSFLAG='A'    
FOR JSON PATH) AS associatedpayoragreementsandtpa,    
(select null as alertmessage    
from  insurancecompany c    
where c.uid=ic.uid    
for json path)payoralerts,    
LTRIM(LTRIM(ic.Code)) code,     
LTRIM(RTRIM(IC.COMPANYNAME )) name,    
LTRIM(LTRIM(ic.description)) description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', ic.activefrom ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', ic.activeto ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
null contactperson,    
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=CMPTPUID)'payortypeuid.$oid',    
null address,    
null[AREA CODE],    
null[CITY CODE],    
null[STATE CODE],    
null[COUNTRY CODE],    
null[ZIPCODE CODE],    
null [contact.workphone],    
null [contact.mobilephone],    
null [contact.alternatephone],    
null [contact.emailid],    
null [contact.weburl],    
(SELECT TOP 1    
PA.GUID     
FROM    
INSURANCEPLAN IP,    
PAYORDETAIL PD,    
PAYORAGREEMENT PA    
WHERE    
IC.UID = IP.IDENTIFYINGUID    
AND IP.PAYORDETAILUID = PD.UID    
AND PA.UID = IP.PAYORAGREEMENTUID    
AND IP.STATUSFLAG = 'A'    
AND PD.STATUSFLAG = 'A'    
AND IC.STATUSFLAG = 'A'    
AND PA.STATUSFLAG='A'    
and pa.name like '%opd%'    
and pa.activeto is null or pa.activeto>getdate()) 'defaultagreementforopd.$oid',    
(SELECT TOP 1    
PA.GUID    
FROM    
INSURANCEPLAN IP,    
PAYORDETAIL PD,    
PAYORAGREEMENT PA    
WHERE    
IC.UID = IP.IDENTIFYINGUID    
AND IP.PAYORDETAILUID = PD.UID    
AND PA.UID = IP.PAYORAGREEMENTUID    
AND IP.STATUSFLAG = 'A'    
AND PD.STATUSFLAG = 'A'    
AND IC.STATUSFLAG = 'A'    
AND PA.STATUSFLAG='A'    
and pa.name like '%ipd%'    
and pa.activeto is null or pa.activeto>getdate()) 'defaultagreementforipd.$oid',    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=IC.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', IC.CWHEN ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=IC.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', IC.MWHEN ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                              
IC.statusflag statusflag,            
(select top 1 guid from healthorganisation where uid=ic.OwnerOrganisationUID) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=ic.OwnerOrganisationUID) as orgcode,    
'insurancecompany' externaltablename,    
IC.uid externaluid    
FROM    
InsuranceCompany IC    
    
FOR JSON PATH) AS X    
    
    