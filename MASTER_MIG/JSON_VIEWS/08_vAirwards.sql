CREATE VIEW vAirwards      
As      
SELECT       
(      
SELECT     
  
L.GUID AS '_id.$oid',      
L.code code,      
LTRIM(RTRIM(L.NAME )) name,      
LTRIM(RTRIM(L.DESCRIPTION )) description,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,L.MWhen)) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',         
--CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,null)) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',         
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,(select top 1 s.mwhen from Service s where s.code=l.code and s.setypuid=235 ))) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',         
(select top 1 guid from ReferenceValue where lotypuid=uid)loctypuid,      
L.DISPLAYORDER  displayorder,      
null directions,      
convert(bit,'false') isdaycareward,      
(SELECT TOP 1 LP.PHONENUMBER FROM LocationProfile LP WHERE LP.LocationUID = L.UID ORDER BY LP.UID DESC)phone,      
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=L.CUSER) AS 'createdby.$oid',                               
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,L.CWHEN)) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=L.MUSER) AS 'modifiedby.$oid',                          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,L.MWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                
L.STATUSFLAG statusflag,              
(select top 1 guid from healthorganisation where uid=L.HealthOrganisationUID) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=L.HealthOrganisationUID) as orgcode,      
 (SELECT TOP 1 S.GUID FROM service s,servicelocation sl where sl.locationuid=l.uid and s.uid=sl.serviceuid      
 and s.statusflag='a' and sl.statusflag='a')  'nursingstnuid.$oid',      
'location' externaltablename,      
cast(l.uid as nvarchar) externaluid      
from       
LOCATION L        
WHERE L.LOTYPUID IN (DBO.FGETREFERENCEVALUEUID('WARRD','LOTYP'),(DBO.FGETREFERENCEVALUEUID('EMWARRD','LOTYP')))    
FOR JSON PATH) AS X  
  