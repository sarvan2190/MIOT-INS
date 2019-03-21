CREATE VIEW vAirbeds  
As  
SELECT   
(  
SELECT    
L.GUID AS '_id.$oid',  
L.code code,  
LTRIM(RTRIM(L.NAME)) name,  
LTRIM(RTRIM(L.DESCRIPTION )) description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,L.CWhen)) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,null)) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',     
(SELECT top 1 RF.guid FROM LocationProfile LP,REFERENCEVALUE RF WHERE LP.LocationUID = L.UID  
AND LP.BDCATUID=RF.UID )'bedcategoryuid.$oid',  
CASE WHEN L.IsTemporaryBed='Y' THEN convert(bit,'false') else convert(bit,'true') END iscensusbed,  
(SELECT LTRIM(RTRIM(L1.GUID)) FROM LOCATION L1 WHERE L1.UID = L.ParentLocationUID AND L1.StatusFlag = 'A') 'warduid.$oid',  
L.DISPLAYORDER  displayorder,  
null directions,  
convert(bit,'false') isdaycareward,  
(SELECT TOP 1 LP.PHONENUMBER FROM LocationProfile LP WHERE LP.LocationUID = L.UID ORDER BY LP.UID DESC)phone,  
CASE WHEN IsTemporaryBed = 'Y' THEN convert(bit,'true') else convert(bit,'false') END istemporarybed,  
null isbedundercleaning,  
null isbedundermaintenance,  
null roomuid,  
isnull((select top 1 guid from careprovider c where c.uid=l.cuser),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-7,L.CWHEN)) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
isnull((select top 1 guid from careprovider c where c.uid=l.cuser),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-7,L.MWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                            
L.STATUSFLAG statusflag,          
(select top 1 guid from healthorganisation where uid=l.OwnerOrganisationUID) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=l.OwnerOrganisationUID) as orgcode,  
'location' externaltablename,  
cast(l.uid as nvarchar) externaluid  
from   
LOCATION L    
WHERE L.LOTYPUID IN (DBO.FGETREFERENCEVALUEUID('BEEDD','LOTYP'))  
FOR JSON PATH) AS X  
  