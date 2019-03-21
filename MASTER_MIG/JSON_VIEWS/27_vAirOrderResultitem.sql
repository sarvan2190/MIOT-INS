CREATE VIEW vAirOrderResultitem    
As      
SELECT      
(      
SELECT      
RSI.guid as '_id.$oid',      
RSI.CODE code,      
LTRIM(RTRIM(RSI.Name))name,      
LTRIM(RTRIM(RSI.Name)) description,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RSI.CWHEN)) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',         
null activeto,      
null locallangdesc,      
rsi.ShortCode shorttext ,      
CASE WHEN       
DBO.fGetReferenceValCode(RSI.RVTYPUID)='NUMRC' THEN 'NUMERIC'      
WHEN DBO.fGetReferenceValCode(RSI.RVTYPUID)='FTF' THEN 'FREETEXT'      
WHEN DBO.fGetReferenceValCode(RSI.RVTYPUID)='REFVL' THEN 'REFERENCEVALUE'      
ELSE UPPER(DBO.fGetRFVALDESCRIPTION(RSI.RVTYPUID)) END resulttype,      
(SELECT TOP 1 RF.GUID FROM REFERENCEVALUE RF WHERE RF.UID=RSI.RSUOMUID)'uomuid.$oid',      
rsi.PrecisionValue precision ,      
null formula,      
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=RSI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RSI.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                            
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=RSI.MUSER) ,'5c7659e45d836f29be36758c')AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RSI.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                              
null resultgroupuid,      
rsi.statusflag statusflag,              
(      
SELECT       
a.guid as 'agemasteruid.$oid',      
dbo.fgetreferenceguid(ORI.SEXXXUID) 'genderuid.$oid',      
LOW normalrangestart,      
HIGH normalrangeend      
FROM ORDERResultItemRange ORI,      
agemaster a      
WHERE RSI.UID=ORI.OrderResultItemuid      
AND ORI.STATUSFLAG='A'      
AND RSI.STATUSFLAG='A'      
and a.uid=ori.agemasteruid    
for json path )as valueranges,      
(select top 1 ori.expression from OrderItemExpression ori where ori.orderresultitemuid=rsi.UID)valueexpression,      
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=2) as orgcode,      
'orderresultitem' externaltablename,      
RSI.printorder displayorder,      
cast(RSI.UID as nvarchar) externaluid      
       
FROM      
OrderResultItem RSI      
FOR JSON PATH      
) AS X      
    
    
    
    