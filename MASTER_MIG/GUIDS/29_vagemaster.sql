CREATE view vagemaster          
as          
select          
(          
select          
am.guid as  '_id.$oid',        
uid as code,          
name as name,          
Description as description,          
am.FromDay 'from',          
dbo.fGetReferenceguid(fromperoduid)'fromunit.$oid',          
am.ToDay 'to',          
dbo.fGetReferenceguid(ToPERODUID)'tounit.$oid',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,am.cwhen )) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',             
null 'activeto.$date.$numberLong',              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=am.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                   
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,am.cwhen )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=am.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,am.MWhen )) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                    
(select top 1 guid from healthorganisation where  uid=2) AS 'orguid.$oid',          
(select top 1 uid from healthorganisation where uid=2) as orgcode,          
          
am.STATUSFLAG statusflag,          
am.UID externaluid          
 from agemaster          
am          
where statusflag='A'          
FOR JSON PATH) AS X   
  
  