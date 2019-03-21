CREATE VIEW vAirDepartment  
As  
SELECT   
(  
select L.guid as '_id.$oid',  
LTRIM(RTRIM(L.CODE)) code,  
CASE WHEN LOTYPUID=238 THEN L.NAME +' (DEPARTMENT)' ELSE LTRIM(RTRIM(L.NAME )) end name,  
LTRIM(RTRIM(L.DESCRIPTION )) description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',  DATEADD(hour,-5.30,L.CWhen )) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',  DATEADD(hour,-5.30,null )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',     
CASE WHEN L.ISREGISTRATIONALLOWED ='Y' THEN convert(bit,'true') else convert(bit,'false') end isregistrationallowed,  
CASE WHEN L.ISREGISTRATIONALLOWED ='Y' THEN convert(bit,'true') else convert(bit,'false') end isadmissionallowed,  
CASE WHEN L.IsMRDRequired  = 'Y' THEN convert(bit,'true') else convert(bit,'false') end isexcludemrdrequest,  
null arealldoctorscheduled,  
null showapptstogether,  
CASE WHEN L.IsEmergency = 'Y' THEN convert(bit,'true') else convert(bit,'false') end isEmergencyDept,  
null displayorder,  
null directions,  
null parentdeptuid,  
null genderuid,  
null agemasteruid,  
null encountertypeuid,  
null visittypeuid,  
null waitingtimegreen,  
null waitingtimeamber,  
null waitingtimered,  
(SELECT TOP 1 CAST(C.CODE AS NVARCHAR) FROM COSTCODE C WHERE C.UID=L.COSTCODEUID AND L.STATUSFLAG='A')departmentcode,  
null phone,  
null overrideorderfromdept,  
null mrdautoprintreg,  
null istriagemandatory,  
null isdaycaredepartment,  
null isvitalmandatory,  
null defaultvitalsignuid,  
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=l.CUSER) AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(hour,-5.30,L.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=L.MUSER) AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(hour,-5.30,L.MWhen )) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                            
(select top 1 guid from healthorganisation where uid=l.OwnerOrganisationUID) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=l.OwnerOrganisationUID) as orgcode,  
L.statusflag statusflag,  
'location' externaltablename,  
CAST(L.UID as nvarchar) externaluid  
FROM  
LOCATION L  
WHERE  
L.LOTYPUID IN (DBO.FGETREFERENCEVALUEUID('LTDPT','LOTYP'),DBO.FGETREFERENCEVALUEUID('MRD','LOTYP') ,DBO.FGETREFERENCEVALUEUID('WARRD','LOTYP')  
,(DBO.FGETREFERENCEVALUEUID('EMWARRD','LOTYP')))  
FOR JSON PATH) AS X  
  
  