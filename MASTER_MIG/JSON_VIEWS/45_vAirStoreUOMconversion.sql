CREATE view vAirStoreUOMconversion  
As  
Select(  
select  
distinct  
(  
  
select  
 sc.guid as '_id.$oid',  
(select top 1 guid from referencevalue rf where uid=sc.converstionuomuid)'touom.$oid',  
conversionvalue convfactor  
 from storeuomconversion sc  
where   
--sc.converstionuomuid=m.converstionuomuid  
  sc.BaseUOMUID=m.BaseUOMUID  
for json path ) as conversionratio,  
(select top 1 guid from referencevalue rf where rf.uid=baseuomuid)'fromuom.$oid',  
'5c7659e45d836f29be36758c' AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,'2014-07-29 15:49:16.860' )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                                  
'5c7659e45d836f29be36758c'AS 'modifiedby.$oid',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,'2014-07-29 15:49:16.860' )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',                                                   
m.statusflag statusflag,          
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=2) as orgcode,  
'storeuomconversion' externaltablename  
from   
 storeuomconversion m  
 --where m.BaseUOMUID=125485  
   
 for json path) as x