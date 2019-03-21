CREATE VIEW vairbillpackage      
As      
Select      
(      
Select       
os.guid as '_id.$oid',      
OS.CODE  code ,      
LTRIM(RTRIM(OS.packagename))name,      
LTRIM(RTRIM(OS.packagename))description,      
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(OSA.PackageName,'"','\"') + '"'         
FROM Billpackagealias OSA  WHERE OSA.Billpackageuid = OS.UID AND OSA.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OS.ACTIVEFROM )) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,OS.ActiveTo)) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',      
null locallangdesc ,      
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=OS.OrderCategoryUID) 'ordercatuid.$oid',      
(SELECT TOP 1 GUID FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = OS.ORDERSUBCATEGORYUID)'ordersubcatuid.$oid',      
CASE WHEN DBO.fGetReferenceValCode(OS.BDCATUID) IS NOT NULL THEN '571dedc5ff50bbb2b2686916'else null end 'restrictencounter.$oid',      
CONVERT(bit,'false')isticksheet ,      
CONVERT(bit,'false')allowduplicateitem ,      
 CASE WHEN DBO.fGetReferenceValCode(OS.BDCATUID) IS NOT NULL THEN CONVERT(bit,'false')       
 WHEN   OS.ordercategoryuid in (DBO.FGETREFERENCEVALUEUID('21','ORDCT')) THEN CONVERT(bit,'false')  else CONVERT(bit,'true') END packagebilling ,      
CONVERT(bit,'false')isacrossvisits ,      
CONVERT(bit,'false')maxvvisitperiod ,      
    
null linkedagreement ,      
 CASE WHEN DBO.fGetReferenceValCode(OS.BDCATUID) IS NOT NULL THEN CONVERT(bit,'true')      
 when OS.ordercategoryuid in (DBO.FGETREFERENCEVALUEUID('21','ORDCT')) then CONVERT(bit,'true')   else CONVERT(bit,'false') end isroomrent,      
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=OS.BDCATUID)'bedcategoryuid.$oid',      
CONVERT(bit,'false')numberofdays,       
(SELECT      
OSBI.Guid as '_id.$oid',      
OS.CODE  ordersetcode,      
BI.GUID As 'orderitemuid.$oid',      
'5c763c315d836f29be35553b' 'priorityuid.$oid',--priority as routine      
null duration,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OSBI.activefrom) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OSBI.activeto) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',          
OSBI.Quantity quantity,      
null dosage,      
null routeuid,      
null sortorder,      
null comments,      
null overrideprice,      
--CASE WHEN (OSBI.amount is null or osbi.amount<0) THEN ISNULL((select top 1 bp.amount from BDMSBillPackagePrice bp where bp.billpackageitemuid=OSBI.uid and (bp.activeto is null or bp.activeto>getdate())      
--and bp.statusflag='A' and pblctuid=1118 order by bp.uid desc),(select top 1 bp.amount from BDMSBillPackagePrice bp where bp.billpackageitemuid=OSBI.uid and (bp.activeto is null or bp.activeto>getdate())      
--and bp.statusflag='A' and pblctuid=dbo.fgetreferencevalueuid('I','PBLCT') order by bp.uid desc)) ELSE OSBI.amount END packageitemprice,      
OSBI.Amount packageitemprice,      
null doctoritemshare,      
'Billpackageitem' externaltablename,      
OSBI.UID externaluid  
  
  
 FROM Billpackageitem(NOLOCK) OSBI      
,BILLABLEITEM(NOLOCK) BI       
--WHERE ISNULL(OS.ISTICKSHEET,'N') = 'N'      
where OS.STATUSFLAG = 'A'      
AND OS.UID = OSBI.billpackageuid      
AND BI.UID = OSBI.BillableItemUID      
AND OSBI.STATUSFLAG = 'A'      
AND BI.STATUSFLAG = 'A'      
AND BI.STATUSFLAG = 'A'      
FOR JSON PATH)AS orderitems,      
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=OS.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                               
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OS.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',            
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=OS.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OS.mWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                 
os.statusflag statusflag,              
(select top 1 guid from healthorganisation where UID=OS.HealthOrganisationUID) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where UID=OS.HealthOrganisationUID) as orgcode,      
'Billpackage' externaltablename,      
case when IsFlexi ='Y' then CONVERT(bit,'true') else convert(bit,'false') end as isflexipackage,  
cast(OS.UID as nvarchar) externaluid      
 FROM Billpackage(NOLOCK) OS      
FOR JSON PATH)AS X      
      