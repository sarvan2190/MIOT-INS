CREATE VIEW [dbo].[vAirOrderitemCatalog]        
As        
SELECT        
(        
select bi.GUID AS '_id.$oid',        
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(BID.itemname,'"','\"') + '"'   FROM BILLABLEITEMALIAS BID  WHERE BID.BillableItemUID = BI.UID AND BID.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,      
(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICEUID) 'billingserviceuid.$oid',       
--(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICESAPUID)'billingservicesapuid.$oid',       
null orderiteminstructions,        
bi.code as code,        
bi.itemname as name,        
bi.description as description,        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,bi.activefrom )) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,bi.ACTIVETO )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',           
dbo.fGetReferenceValCode(BI.ORDCTUID) ordercategorycode ,        
(SELECT o.code FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = BI.ORDERSUBCATEGORYUID) Ordersubcategorycode,        
(select top 1 guid from referencevalue rf where rf.uid=bi.ORDCTUID)as 'ordercatuid.$oid',        
(select top 1 guid from ordercategory rf  where rf.uid=bi.ORDERSUBCATEGORYUID)as 'ordersubcatuid.$oid',        
CASE WHEN oc.Isexecutable='Y' THEN convert(bit,'true') else convert(bit,'false') end istaskgenerationreqd,        
CASE WHEN IsConfidential = 'Y' THEN convert(bit,'true') else convert(bit,'false') end ispermissionreqforresult,        
convert(bit,'false') isapprovalrequired,        
convert(bit,'false') iscosignrequired,        
CASE WHEN Isconssharerequired='Y' THEN convert(bit,'true') else convert(bit,'false') end isdoctorshareitem,        
(select top 1 guid from referencevalue rf where rf.uid=oc.prityuid) as 'defaultpriorityuid.$oid',        
CASE WHEN oc.ISHOURLYCHARGE='Y' THEN convert(bit,'true') else convert(bit,'false') end ishourlycharge ,        
CASE WHEN oc.ISschedulable='Y' then convert(bit,'true') else convert(bit,'false') end  isschedulable ,        
CASE WHEN iseditable='Y' then convert(bit,'true') else convert(bit,'false') end allowpriceoverride,        
CASE WHEN ispackageitem='Y' then convert(bit,'true') else convert(bit,'false') end ispackageitem,        
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                               
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                              
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.MUSER) ,'5c7659e45d836f29be36758c')AS 'modifiedby.$oid',                          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                                 
bi.statusflag statusflag,                
(select top 1 guid from healthorganisation where UID=BI.OwnerOrganisationUID) AS 'orguid.$oid',        
(select top 1 uid from healthorganisation where UID=BI.OwnerOrganisationUID) as orgcode,        
'billableitem' externalidentifier,        
--(select top 1 bd.guid from bdmsincomesource bd where bd.uid=bi.bdmsincomesourceuid)'incomesourceuid.$oid',      
(select top 1 r.guid from referencevalue r where r.UID=BI.BSMDDUID)'servicecattypeuid.$oid',      
bi.bsmdduid bsmdduid,      
'ordercatalogitem' type,        
oc.uid externaluidordercatalogitem,        
bi.uid externaluid,    
bi.HSNCode  hsncode      
FROM         
ORDERCATALOGITEM(NOLOCK) OC,        
BILLABLEITEM(NOLOCK) BI        
WHERE        
BI.BSMDDUID IN (DBO.FGETREFERENCEVALUEUID('ORDITEM','BSMDD'))        
AND  BI.ITEMUID = OC.UID        
--and bi.uid=40385      
AND NOT EXISTS(SELECT 1 FROM ORDERCATALOGITEM OC1 WHERE OC1.ORDTYPUID=23651 AND OC.UID=OC1.UID)        
for json path) as X      
      
      