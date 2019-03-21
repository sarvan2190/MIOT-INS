CREATE VIEW vAirResultitem            
As            
SELECT            
(            
SELECT            
RSI.guid as '_id.$oid',            
RSI.CODE code,            
LTRIM(RTRIM(RSI.DISPLYNAME))name,            
LTRIM(RTRIM(RSI.DESCRIPTION))description,            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', ISNULL(DATEADD(HH,-5.30,RSI.EFFECTIVEFROM),GETDATE()-10) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',               
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RSI.EFFECTIVETO )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',               
null locallangdesc,            
rsi.ShortCode shorttext ,            
CASE WHEN             
DBO.fGetReferenceValCode(RSI.RVTYPUID)='FTF' THEN 'FREETEXT'            
WHEN DBO.fGetReferenceValCode(RSI.RVTYPUID)='REFVL' THEN 'REFERENCEVALUE'            
WHEN DBO.fGetReferenceValCode(RSI.RVTYPUID)='IMGRS' THEN 'ATTACHMENT'            
ELSE UPPER(DBO.fGetRfValAlternateName(RSI.RVTYPUID)) END resulttype,            
(SELECT TOP 1 RF.GUID FROM REFERENCEVALUE RF WHERE RF.UID=RSI.UnitofMeasure)'uomuid.$oid',            
            
(              
SELECT               
a.guid as 'agemasteruid.$oid',              
dbo.fgetreferenceguid(ORI.SEXXXUID) 'genderuid.$oid',              
LOW normalrangestart,              
HIGH normalrangeend,  
DisplayValue displaytext           
FROM ResultItemRange ORI,              
agemaster a              
WHERE RSI.UID=ORI.ResultItemuid              
AND ORI.STATUSFLAG='A'              
AND RSI.STATUSFLAG='A'              
and a.uid=ori.agemasteruid            
for json path )as valueranges,            
rsi.Precision precision ,            
rsi.Expression formula ,            
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=RSI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RSI.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                                    
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=RSI.MUSER) ,'5c7659e45d836f29be36758c')AS 'modifiedby.$oid',                                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RSI.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                                     
null resultgroupuid,            
rsi.statusflag statusflag,                    
(select top 1 guid from healthorganisation where uid=rsi.OwnerOrganisationUID) AS 'orguid.$oid',            
(select top 1 uid from healthorganisation where uid=rsi.OwnerOrganisationUID) as orgcode,            
'resultitem' externaltablename,            
RSI.printorder displayorder,          
(SELECT TOP 1 RF.GUID FROM ReferenceDomain rf WHERE RF.DomainCode=RSI.HelpText)'refdomainuid.$oid',     
rsi.Expression valueexpression   ,    
cast(RSI.UID as nvarchar) externaluid            
             
FROM            
RESULTITEM RSI          
        
FOR JSON PATH            
) AS X     
    
  
  