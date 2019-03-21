CREATE VIEW vAirusers    
As    
SELECT     
(    
SELECT     
c.guid as '_id.$oid',    
isnull((SELECT TOP 1 L.LOGINNAME FROM LOGIN L WHERE L.CAREPROVIDERUID = C.UID AND L.STATUSFLAG = 'A' ORDER BY L.UID DESC),c.code) as code,    
isnull((select top 1 guid from referencevalue r where uid=sexxxuid),'569ce2b8aff90071f0952af8') as 'genderuid.$oid',    
(select top 1 guid from referencevalue r where uid=titleuid) as 'titleuid.$oid',    
isnull(LTRIM(RTRIM(C.ForeName)),'')+ ISNULL(' '+(LTRIM(RTRIM(C.SurName))),'') as name,    
--C.SurName as lastname,    
isnull(LTRIM(RTRIM(C.ForeName)),'') + ISNULL(' '+(LTRIM(RTRIM(C.SurName))),'')description,    
CASE WHEN C.IsCareprovider = 'Y' THEN convert(bit,'true') ELSE convert(bit,'false') END iscareprovider ,    
 CASE WHEN C.ISOPCONSULTANT = 'Y' THEN convert(bit,'true') ELSE convert(bit,'false') END isopconsultant ,    
 CASE WHEN C.ISADMITCONSULTANT = 'Y' THEN convert(bit,'true') ELSE convert(bit,'false') END isadmitconsultant ,    
 CASE WHEN C.IsSuregon = 'Y' THEN convert(bit,'true') ELSE convert(bit,'false') END  issurgeon ,    
 CASE WHEN C.ISANAESTHETIST = 'Y' THEN convert(bit,'true') ELSE convert(bit,'false') END isanaesthetist ,    
 CASE WHEN C.ISRADIOLOGIST = 'Y' THEN convert(bit,'true') ELSE convert(bit,'false') END isradiologist,    
 QUALIFICATION as qualification,    
 (select top 1 guid from referencevalue r where uid=CPTYPUID)as 'providertypeuid.$oid',    
 C.LicenseNo AS licensenumber,    
 (select     
 l.guid as 'uid.$oid',    
 L.NAME as 'name',    
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,l.CWhen) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',        
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,null) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',    
 'careproviderlocation' externaltablename,    
    cl.uid externaluid    
 FROM CAREPROVIDERLOCATION CL(NOLOCK),location l(NOLOCK) WHERE CL.CAREPROVIDERUID=C.UID    
 AND CL.STATUSFLAG='A' AND CL.LOCATIONUID=L.UID     
 AND L.STATUSFLAG='A'    
 FOR JSON PATH) AS userdepartments,    
 (SELECT TOP 1 L.GUID  FROM LOCATION L,CAREPROVIDERLOCATION CL WHERE CL.LOCATIONUID=L.UID AND CL.CAREPROVIDERUID=C.UID    
 AND L.STATUSFLAG='A'    
 AND CL.STATUSFLAG='A'    
 ORDER BY CL.UID ASC) as 'defaultdepartment.uid.$oid',    
 (SELECT TOP 1 L.NAME  FROM LOCATION L,CAREPROVIDERLOCATION CL WHERE CL.LOCATIONUID=L.UID AND CL.CAREPROVIDERUID=C.UID    
 AND L.STATUSFLAG='A'    
 AND CL.STATUSFLAG='A'    
 ORDER BY CL.UID ASC) as 'defaultdepartment.name',    
 null allwards,    
 (select     
 l.guid as  'uid.$oid',    
 L.NAME as 'name',    
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', l.CWhen ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',        
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', null ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',    
 'careproviderlocation' externaltablename,    
    cl.uid externaluid    
 FROM CAREPROVIDERLOCATION CL(NOLOCK),location l(NOLOCK) WHERE CL.CAREPROVIDERUID=C.UID    
 AND CL.STATUSFLAG='A' AND CL.LOCATIONUID=L.UID     
 AND L.STATUSFLAG='A' and l.lotypuid=238    
 FOR JSON PATH) AS userwards,    
 (SELECT TOP 1 L.GUID  FROM LOCATION L,CAREPROVIDERLOCATION CL WHERE CL.LOCATIONUID=L.UID AND CL.CAREPROVIDERUID=C.UID AND L.LOTYPUID=238    
 AND CL.STATUSFLAG='A'     
 AND L.STATUSFLAG='A'    
 ORDER BY CL.UID ASC) 'defaultwarduid.$oid',    
 (select     
 r.guid as  'uid.$oid',    
 r.NAME as 'name',    
 'role' externaltablename,    
    r.uid externaluid    
 FROM Role R,Roleprofile RP,Login L     
 where rp.roleuid=r.uid and  RP.LOGINUID=l.uid    
 and l.careprovideruid=c.uid    
 and r.statusflag='A'    
 AND RP.STATUSFLAG='A'    
 AND L.STATUSFLAG='A'    
 FOR JSON PATH) AS roles,    
 (select top 1     
 r.guid      
 FROM Role R,Roleprofile RP,Login L     
 where rp.roleuid=r.uid and  RP.LOGINUID=l.uid    
 and l.careprovideruid=c.uid    
 and r.statusflag='A'    
 AND RP.STATUSFLAG='A'    
 AND L.STATUSFLAG='A') as 'defaultrole.uid.$oid',    
 (select  top 1     
 r.NAME     
 FROM Role R,Roleprofile RP,Login L     
 where rp.roleuid=r.uid and  RP.LOGINUID=l.uid    
 and l.careprovideruid=c.uid    
 and r.statusflag='A'    
 AND RP.STATUSFLAG='A'    
 AND L.STATUSFLAG='A') as 'defaultrole.name',    
 CASE WHEN  EXISTS(SELECT TOP 1 L.LOGINNAME FROM LOGIN L WHERE L.CAREPROVIDERUID = C.UID AND L.STATUSFLAG = 'A' ORDER BY L.UID DESC) THEN convert(bit,'true')    
 ELSE convert(bit,'true') ENd haslogin,    
 (SELECT TOP 1 L.LOGINNAME FROM LOGIN L WHERE L.CAREPROVIDERUID = C.UID AND L.STATUSFLAG = 'A' ORDER BY L.UID DESC) as loginid,    
 (    
 SELECT    
 cg.guid as '_id.$oid',     
 groupcode as groupcode,    
 groupname as groupname,    
 comments as description,    
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', CG.ACTIVEFROM ) as bigint) * 1000  AS NVARCHAR(50)) as 'activefrom.$date.$numberLong',        
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', CG.ACTIVETO ) as bigint) * 1000  AS NVARCHAR(50)) as 'activeto.$date.$numberLong',    
 'careprovidergroup' externaltablename,    
    cg.uid externaluid    
 FROM CAREPROVIDERGROUP CG    
 WHERE CG.CAREPROVIDERUID=C.UID    
 AND CG.STATUSFLAG='A'    
 FOR JSON PATH) AS usergroupcodes,    
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', C.ACTIVEFROM ) as bigint) * 1000  AS NVARCHAR(50)) as 'activefrom.$date.$numberLong',        
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', C.ACTIVETO ) as bigint) * 1000  AS NVARCHAR(50)) as 'activeto.$date.$numberLong',        
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', C.BirthDttm ) as bigint) * 1000  AS NVARCHAR(50)) as 'dateofbirth.$date.$numberLong',                              
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', C.LicenseIssueDttm ) as bigint) * 1000  AS NVARCHAR(50)) as 'licenseissuedate.$date.$numberLong',                              
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', C.LicenseExpiryDttm ) as bigint) * 1000  AS NVARCHAR(50)) as 'licenseexpirtydate.$date.$numberLong',      
(SELECT TOP 1 E.LINE1 FROM ENTERPRISECONTACTDETAIL E WHERE E.IDENTIFYINGTYPE = 'CAREPROVIDER' AND E.STATUSFLAG = 'A' AND E.CNTYPUID=1 AND E.IdentifyingUID=C.UID)[contact.workphone],    
(SELECT TOP 1 E.LINE1 FROM ENTERPRISECONTACTDETAIL E WHERE E.IDENTIFYINGTYPE = 'CAREPROVIDER' AND E.STATUSFLAG = 'A' AND E.CNTYPUID=2 AND E.IdentifyingUID=C.UID)[contact.mobilephone],    
(SELECT TOP 1 E.LINE1 FROM ENTERPRISECONTACTDETAIL E WHERE E.IDENTIFYINGTYPE = 'CAREPROVIDER' AND E.STATUSFLAG = 'A' AND E.CNTYPUID=3 AND E.IdentifyingUID=C.UID)[contact.emailid],    
'5b862a593238d86bf03a39a9' AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,C.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                              
'5b862a593238d86bf03a39a9' AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,C.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                              
C.statusflag statusflag,            
C.englishname printname,    
'$2b$10$H9oXVmgU.N4HaAcsXuB0B.pwdKLrTF1LgwH/8.IpVo2Ip1gIVAlvK' as password,    
(select top 1 s.guid from careproviderspecialty cs,Speciality s where cs.careprovideruid=c.uid    
and cs.SpecialtyUID=s.uid)'specialtyuid.$oid',    
 (SELECT TOP 1 L.PASSWORD FROM LOGIN L WHERE L.CAREPROVIDERUID = C.UID AND L.STATUSFLAG = 'A' ORDER BY L.UID DESC)externalpassword,    
(select top 1 guid from healthorganisation where uid=c.OwnerOrganisationUID) AS 'orguid.$oid',    
(select top 1 guid from healthorganisation where uid=c.OwnerOrganisationUID) as 'defaultorguid.$oid',    
(select top 1 uid from healthorganisation where uid=c.OwnerOrganisationUID) as orgcode,    
'careprovider' externaltablename,    
cast(C.UID as nvarchar) externaluid,    
(    
select name,    
guid as 'uid.$oid'    
from healthorganisation where uid=c.OwnerOrganisationUID    
 for json path)visitingorgs    
FROM CAREPROVIDER C    
FOR JSON PATH) AS X    
    
    
    