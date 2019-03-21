  
  
CREATE VIEW vairorderset      
as      
select      
(      
select       
os.guid as '_id.$oid',      
OS.CODE  code ,      
LTRIM(RTRIM(OS.NAME))name,      
LTRIM(RTRIM(OS.DESCRIPTION))description,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OS.ACTIVEFROM )) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,OS.ActiveTo)) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',      
null locallangdesc ,      
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=OS.OrderCategoryUID) 'ordercatuid.$oid',      
(SELECT TOP 1 GUID FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = OS.ORDERSUBCATEGORYUID)'ordersubcatuid.$oid',      
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(OSA.AliasName,'"','\"') + '"'         
FROM ordersetalias OSA  WHERE OSA.ordersetuid = OS.UID AND OSA.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,        
null restrictencounter,      
CONVERT(bit,'false')isticksheet,      
CONVERT(bit,'false')allowduplicateitem,      
'false' nodiscount,      
 convert(bit,'false')  packagebilling,--fixpricebybconnect and package category      
null isacrossvisits ,      
null maxvvisitperiod,      
'false' isflexipackage,      
null numberofdays,      
null linkedagreement,      
 convert(bit,'false')  isroomrent,      
'false' deletepartialorderset,      
--(select top 1 guid from policymaster pm where os.policymasteruid=pm.uid)'policymasteruid.$oid',      
'false'  notallowdiscount,      
(SELECT      
OSBI.Guid as '_id.$oid',      
OS.CODE  ordersetcode,      
BI.GUID As 'orderitemuid.$oid',      
(SELECT TOP 1 GUID FROM REFERENCEVALUE  WHERE UID=PRITYUID) 'priorityuid.$oid',      
(SELECT TOP 1 FD.GUID FROM FrequencyDefinition(NOLOCK) FD WHERE FD.UID = OSBI.FRQNCUID AND FD.STATUSFLAG = 'A')  'frequencyuid.$oid',      
null duration,      
OSBI.Quantity quantity,      
OSBI.DoseQty dosage,      
null routeuid,      
null sortorder,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,osbi.StartDttm) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,osbi.EndDttm) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',          
'migrated' comments,      
--isnull((select top 1 bp.amount from BDMSOrderSetItemPrice bp where bp.ordersetbillableitemuid=OSBI.uid and (bp.activeto is null or bp.activeto>getdate())      
--and bp.statusflag='A' and pblctuid=1118 order by bp.uid desc),(select top 1 bp.amount from BDMSOrderSetItemPrice bp where bp.ordersetbillableitemuid=OSBI.uid and (bp.activeto is null or bp.activeto>getdate())      
--and bp.statusflag='A' and pblctuid=dbo.fgetreferencevalueuid('I','PBLCT')  order by bp.uid desc)) overrideprice,      
amount packageitemprice,      
Amount  overrideprice,      
null doctoritemshare,      
'ordersetbillabelitem' externaltablename,      
OSBI.UID externaluid      
FROM ORDERSETBILLABLEITEM(NOLOCK) OSBI      
,BILLABLEITEM(NOLOCK) BI       
WHERE ISNULL(OS.ISTICKSHEET,'N') = 'N'      
AND OS.STATUSFLAG = 'A'      
AND OS.UID = OSBI.ORDERSETUID      
AND BI.UID = OSBI.BillableItemUID      
AND OSBI.STATUSFLAG = 'A'      
AND BI.STATUSFLAG = 'A'      
AND BI.STATUSFLAG = 'A'      
FOR JSON PATH)AS orderitems,                               
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=OS.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                               
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OS.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=OS.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OS.mWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                               
os.statusflag statusflag,              
(select top 1 guid from healthorganisation where uid=1) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=1) as orgcode,      
'orderset' externaltablename,      
OS.UID externaluid      
 FROM ORDERSET(NOLOCK) OS      
WHERE ISNULL(OS.ISTICKSHEET,'N') = 'N'      
--AND OS.STATUSFLAG = 'A'      
--order by 2      
FOR JSON PATH)AS X      
      
    
      
      
--policymasteruid