CREATE VIEW vAirStoreMaster    
As    
select     
(    
select S.GUID AS '_id.$oid',    
(    
SELECT     
dbo.fGetCareproviderguid(c.uid)  '$oid'    
FROM      
StorePermission SP      
,CAREPROVIDER C      
WHERE      
SP.STOREUID = S.UID      
AND C.UID = SP.CareproviderUID      
AND SP.CAREPROVIDERUID IS NOT NULL    
AND S.STATUSFLAG = 'A'      
AND SP.STATUSFLAG = 'A'      
AND C.STATUSFLAG = 'A'        
AND c.CODE IS NOT NULL      
for json path) restrictusers,    
LTRIM(RTRIM(S.Code))code,    
LTRIM(RTRIM(S.Description)) as 'name',    
S.DESCRIPTION description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,s.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',dateadd(HH,-5.30,s.ACTIVETO )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
(SELECT LTRIM(RTRIM(L.CODE)) FROM LOCATION L WHERE  L.UID = S.LOCATIONUID AND LOTYPUID=10039) departmentcode,    
(SELECT l.guid FROM LOCATION L WHERE  L.UID = S.LOCATIONUID AND LOTYPUID=10039) 'departmentuid.$oid' ,    
(SELECT LTRIM(RTRIM(L.CODE)) FROM STORE L WHERE L.STATUSFLAG = 'A' AND L.UID = S.ParentStoreUID) parentstorecode,    
(SELECT l.guid FROM STORE L WHERE L.STATUSFLAG = 'A' AND L.UID = S.ParentStoreUID) 'parentstoreuid.$oid',    
'INVENTORIES.FIFOALLOCATEPOLICY'allocatepolicy,    
null druglicensenumber,    
null preventsameitemstockrequest,    
null isgstregistered,    
null gstregno,    
null companyname,    
null companyaddress,    
convert(bit,'true') supportallfunctions,    
(    
SELECT  +     
REPLACE(     
REPLACE(     
(SELECT '[INVENTORIES.PURCHASEORDER,INVENTORIES.STOCKREQ]' AS C FROM STORE SI WHERE SI.UID=S.UID    
AND SI.STATUSFLAG='A' ),'{"C":','' ),    
'"}','"' ))AS restrictfunctions,    
CASE WHEN S.ISGRNAPPROVESTATUSREQRD='Y' THEN convert(bit,'true') else convert(bit,'false') End approvalreqdforgrn,    
(CASE WHEN EXISTS (SELECT 1 FROM STORETRANSACTION ST, TRANSACTIONTYPE TT     
     WHERE ST.STOREUID = S.UID AND ST.TransactionTypeUID = TT.UID     
     AND ST.StatusFlag ='A' AND TT.StatusFlag = 'A' AND (TT.Code='TFR')) THEN convert(bit,'true') ELSE convert(bit,'false') END)approvalreqdfortransferin,     
(CASE WHEN EXISTS (SELECT 1 FROM STORETRANSACTION ST, TRANSACTIONTYPE TT     
     WHERE ST.STOREUID = S.UID AND ST.TransactionTypeUID = TT.UID     
     AND ST.StatusFlag ='A' AND TT.StatusFlag = 'A' AND (TT.Code='ITR')) THEN convert(bit,'true') ELSE convert(bit,'false') END)approvalreqdforstockrequest,    
(select     
sb.guid '_id.$oid',    
sb.description ,    
sb.binlocation name,     
sb.uid externalstorebinuid,    
'storebin' as externaltablebinname     
from storebin sb    
WHERE sb.storeuid=s.uid     
and sb.statusflag='A'    
for json path) as storebins,    
null reorderlevelformula,    
null reorderquantityformula,    
null receiveitemfromanyvendor,    
null displayitemavgcost,    
null autodispensestore,    
null expirywarningdays,    
isnull((select top 1 guid from careprovider c where c.uid=s.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', S.CWHEN ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=S.MUSER) AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', S.MWHEN ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',     
(SELECT TOP 1 GUID FROM HEALTHORGANISATION where uid =2)'orguid.$oid',    
(SELECT TOP 1 UID FROM HEALTHORGANISATION where uid= 2)orgcode,    
s.STATUSFLAG statusflag,    
s.uid  externaluid    
FROM    
STORE S    
    
for json path) as x    