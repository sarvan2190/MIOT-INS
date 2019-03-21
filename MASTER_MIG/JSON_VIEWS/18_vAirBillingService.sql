CREATE VIEW vAirBillingService  
As  
Select  
(  
select  
bi.guid as '_id.$oid',  
servicecode code,  
Description name,  
Description description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', bi.activefrom ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',bi.ACTIVETO ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',     
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',                              
bi.statusflag statusflag,      
bi.uid externaluid,      
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=2) as orgcode  
  
 FROM BILLINGSERVICE BI  
 FOR JSON PATH) AS X