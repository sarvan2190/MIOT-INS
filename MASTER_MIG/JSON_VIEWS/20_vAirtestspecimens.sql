CREATE VIEW vAirtestspecimens      
As      
SELECT      
(      
select BI.GUID AS '_id.$oid',      
--(      
--SELECT ITEMNAME FROM BILLABLEITEMALIAS BA      
--WHERE BA.BILLABLEITEMUID=BI.UID      
--AND BA.STATUSFLAG='A'      
--FOR JSON PATH) AS aliasnames,      
(      
SELECT       
RI.ItemCode requestitemcode,      
sp.name specimenname,      
SP.guid 'specimenuid.$oid',      
CASE WHEN RIS.ISDEFAULT='Y' THEN convert(bit,'true') else convert(bit,'false') end isdefault,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', getdate()-10 ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',        
null activeto,      
'requestItemSpecimen'  externaltablename,      
RIS.UID externaluid      
FROM SPECIMEN SP,      
REQUESTITEMSPECIMEN RIS      
WHERE SP.STATUSFLAG='A'      
 AND SP.STATUSFLAG='A'      
  AND RIS.STATUSFLAG='A'      
 AND RI.UID=RIS.REQUESTITEMUID      
 AND SP.UID=RIS.SPECIMENUID      
for json path) as specimeninstructions,      
BI.CODE  code ,      
RI.Method method ,      
RI.footer footermsg,      
RI.PrintOrder printorder,      
(SELECT CAST(O.UID AS NVARCHAR) FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = BI.ORDERSUBCATEGORYUID)[PRINT GROUP],      
(SELECT top 1 O.GUID FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = BI.ORDERSUBCATEGORYUID)'printgroupuid.$oid',      
CASE WHEN ri.IsPrintTogether = 'Y' THEN convert(bit,'false') else convert(bit,'true') END  printseparate ,      
null processduration,      
null labtestuid,      
bi.guid as 'orderitemuid.$oid',      
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                               
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', BI.CWHEN ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', BI.MWHEN ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                
BI.STATUSFLAG statusflag,              
(select top 1 guid from healthorganisation where uid=bi.OwnerOrganisationUID) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=bi.OwnerOrganisationUID) as orgcode,      
'billableitem' externaltablename,      
bi.BSMDDUID bsmdduid,      
RI.uid externaluidordercat,      
cast(bi.uid as nvarchar) externaluid      
      
FROM      
REQUESTITEM(NOLOCK)RI,      
BILLABLEITEM(NOLOCK) BI      
--left outer join REQUESTITEM(NOLOCK)RI      
WHERE      
BI.BSMDDUID IN (DBO.FGETREFERENCEVALUEUID('LABBB','BSMDD'))     
AND BI.ITEMUID = RI.UID      
AND BI.STATUSFLAG='A'      
AND RI.STATUSFLAG='A'      
for json path) as X      
      