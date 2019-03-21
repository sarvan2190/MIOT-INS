CREATE VIEW vAirproblems  
As  
select   
(  
 SELECT   
 P.GUID AS '_id.$oid',  
P.CODE  code ,  
LTRIM(RTRIM(P.NAME))name ,  
LTRIM(RTRIM(P.DESCRIPTION))description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', GETDATE() ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',     
null  activeto,    
dbo.fgetreferenceguid(cdtypuid)'codingschemeuid.$oid',  
CASE WHEN P.IsNotifiable ='Y' THEN convert(bit,'true') ELSE convert(bit,'false') END isnotifiable ,  
(SELECT S1.GUID FROM PROBLEM(NOLOCK) S1 WHERE S1.STATUSFLAG = 'A' AND S1.UID = P.PARENTUID)  'parentproblemuid.$oid' ,  
'5c7659e45d836f29be36758c' 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,P.CWHEN )) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                            
'5c7659e45d836f29be36758c'  'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,P.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',   
p.statusflag statusflag,          
'569794170946a3d0d588efe6' AS 'orguid.$oid',-- Parentorganisationuid  
'problems' externaltablename,  
cast(p.uid as nvarchar) externaluid   
FROM  
PROBLEM(NOLOCK) P  
for json path) as x  
  
  