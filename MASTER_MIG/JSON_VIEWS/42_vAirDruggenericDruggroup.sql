CREATE VIEW vAirDruggenericDruggroup    
As    
SELECT     
(    
SELECT  --- inside the druggroup    
DGC.GUID AS '_id.$oid',    
DGC.DESCRIPTION code,    
LTRIM(RTRIM(DGC.NAME )) name,    
LTRIM(RTRIM(DGC.DESCRIPTION ))description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEaDD(HH,-5.30,DGC.CWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DGC.ACTIVETO) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',      
null 'druggrouptypeuid',    
null [Druggrouptype],    
null 'parentgroupuid.$oid',    
null [parentgroupcode] ,    
convert(bit,'true') isallergen,    
null locallangdesc,                           
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=DGC.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DGC.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                            
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=DGC.MUSER) ,'5c7659e45d836f29be36758c')AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DGC.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                              
dgc.STATUSFLAG statusflag,            
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=2) as orgcode,    
'druggeneric' externaltablename,    
cast(dgc.uid as nvarchar) externaluid    
    
FROM    
DRUGGENERICMASTER(NOLOCK)  DGC    
FOR JSON PATH) AS X    