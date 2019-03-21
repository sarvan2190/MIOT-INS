CREATE VIEW  vRole    
AS     
SELECT     
(    
  select guid as '_id.$oid', code ,name ,statusflag ,description ,    
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,Cwhen)) as bigint) * 1000  AS NVARCHAR(50))   'activefrom.$date.$numberLong',  
NULL activeto ,    
'5c7659e45d836f29be36758c' AS  'createdby.$oid',         
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,Cwhen)) as bigint) * 1000  AS NVARCHAR(50))    'createdat.$date.$numberLong',    
'5c7659e45d836f29be36758c' AS  'modifiedby.$oid',    
CAST(cast(DATEDIFF(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,MWHEN )) as bigint) * 1000  AS NVARCHAR(50))   'modifiedat.$date.$numberLong',       
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',  
CAST(uid as nvarchar) as 'externaluid'    
 FROM     
ROLE       
  
FOR JSON PATH     
) AS Y     
  