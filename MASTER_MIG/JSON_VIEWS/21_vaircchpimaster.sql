CREATE VIEW vaircchpimaster  
As  
Select  
(  
Select   
CM.guid as '_id.$oid',  
CM.code  code ,  
LTRIM(RTRIM(CM.complaint)) name ,  
LTRIM(RTRIM(CM.complaint)) description ,  
LTRIM(RTRIM(CM.LocalLang))locallangdesc,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', Dateadd(HH,-5.30,CWhen) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',      
null activeto,  
'5c7659e45d836f29be36758c' 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', Dateadd(HH,-5.30,CWhen)  ) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                            
'5b862a913238d86bf03aa787'  'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', Dateadd(HH,-5.30,MWhen)  ) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',   
CM.statusflag statusflag,          
'569794170946a3d0d588efe6' AS 'orguid.$oid',-- Parentorganisationuid  
'cchpimaster' externaltablename,  
CM.uid externaluid  
FROM  
cchpimaster(NOLOCK) CM  
for json path) AS X  
  
  
  
  
  