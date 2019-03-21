CREATE VIEW vAirFrequencyDefinition    
AS          
SELECT          
(          
SELECT  FD.guid as '_id.$oid',        
null daysofweek,          
null allowedordercategories,          
(          
SELECT           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,ft.timeofday)) as bigint) * 1000  AS NVARCHAR(50)) '$date.$numberLong'          
from           
FrequencyTiming ft          
where ft.frequencyuid=fd.uid           
AND ft.statusflag='A'    
FOR JSON PATH) timings,          
UPPER(FD.CODE) code,          
FD.NAME name,           
FD.NAME description,          
FD.Comments locallangdesc,          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,ISNULL(FD.ACTIVEFROM,FD.CWHEN))) as bigint) * 1000  AS NVARCHAR(50)) as 'activefrom.$date.$numberLong',              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,FD.ACTIVETO)) as bigint) * 1000  AS NVARCHAR(50)) as 'activeto.$date.$numberLong',            
FD.NOOFTIMES quantityperday,          
FD.Type type,          
'1'repeatsday,          
null hoursinterval,          
convert(bit,'true')allordercategories,          
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=FD.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                   
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,FD.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                                    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=FD.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,FD.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                                    
fd.statusflag statusflag,                  
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',          
(select top 1 uid from healthorganisation where uid=2) as orgcode,          
'frequencydefintion' externaltablename,          
cast(FD.UID as nvarchar) externaluid          
FROM FREQUENCYDEFINITION FD          
for json path) as x     
  
  
    
    
    