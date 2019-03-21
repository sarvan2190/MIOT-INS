CREATE VIEW vAirDrugmastergeneric        
As        
SELECT        
(        
SELECT        
DGC.guid as  '_id.$oid',        
LTRIM(RTRIM(DGC.CODE)) code,        
REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(DGC.NAME )),'(',''),')',''),'\',''),'*','')name ,        
REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(DGC.DESCRIPTION )),'(',''),')',''),'\',''),'*','')description,        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DGC.CWhen ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DGC.ACTIVETO ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',          
convert(bit,'true') isgenericdrug,--- inside the drugmaster        
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=DGC.CUSER) AS 'createdby.$oid',                                 
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DGC.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                                     
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=DGC.MUSER) AS 'modifiedby.$oid',                            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DGC.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                                   
dgc.STATUSFLAG statusflag,                
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',        
(select top 1 uid from healthorganisation where uid=2) as orgcode,        
'druggeneric' externaltablename,        
dgc.uid externaluid         
FROM        
DRUGGENERICMASTER(NOLOCK)  DGC        
FOR JSON PATH) AS X        
    
    
      