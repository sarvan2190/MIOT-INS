CREATE VIEW vAirOrderitemvital          
As          
SELECT          
(          
select oc.GUID AS '_id.$oid',          
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(BID.aliasname,'"','') + '"'             
FROM orderitemalias BID  WHERE BID.ordercatalogitemuid = oc.UID AND BID.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,           
(          
SELECT          
rsi.guid as  'resultitemuid.$oid',          
case when RRL.DISPLAYORDER=0 then '' else RRL.DISPLAYORDER end  displayorder,          
RSI.CODE RESULTITEM ,          
convert(bit,'false')  excludefromprint,          
rsi.uid externaluid,          
'orderresultitem' externaltablename          
FROM          
OrderCatalogResultItem RRL(NOLOCK),          
OrderResultItem RSI(NOLOCK)          
WHERE          
RSI.STATUSFLAG = 'A'          
AND RSI.UID=RRL.ORDERRESULTITEMUID          
and RRL.ORDERCATALOGITEMUID=OC.uid          
AND RRL.STATUSFLAG='A'          
for json path) as resultitems,          
--(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICEUID)'billingserviceuid.$oid',          
null orderiteminstructions,          
OC.code as code,          
OC.NAME as name,          
OC.description as description,          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OC.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',dateadd(HH,-5.30,OC.ACTIVETO )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',             
dbo.fGetReferenceValCode(OC.ORDERCATEGORYUID) ordercategorycode ,          
(SELECT o.code FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = OC.ORDERSUBCATEGORYUID) Ordersubcategorycode,          
(select top 1 guid from referencevalue rf where rf.uid=OC.ORDERCATEGORYUID)as 'ordercatuid.$oid',          
(select top 1 guid from ordercategory rf  where rf.uid=OC.ORDERSUBCATEGORYUID)as 'ordersubcatuid.$oid',          
CASE WHEN oc.Isexecutable='Y' THEN convert(bit,'true') else convert(bit,'false') end istaskgenerationreqd,          
CASE WHEN IsConfidential = 'Y' THEN convert(bit,'true') else convert(bit,'false') end ispermissionreqforresult,          
 convert(bit,'false') isapprovalrequired,          
 convert(bit,'false') iscosignrequired,          
 convert(bit,'false')  isdoctorshareitem,          
(select top 1 guid from referencevalue rf where rf.uid=oc.prityuid) as defaultpriorityuid,          
CASE WHEN oc.ISHOURLYCHARGE='Y' THEN convert(bit,'true') else convert(bit,'false') end ishourlycharge ,          
CASE WHEN oc.ISschedulable='Y' then convert(bit,'true') else convert(bit,'false') end  isschedulable ,          
 convert(bit,'true')  isobservationpanel,          
 convert(bit,'false') allowpriceoverride,          
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=OC.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                   
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OC.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=OC.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,OC.mWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                     
OC.statusflag statusflag,                  
(select top 1 guid from healthorganisation where uid=oc.OwnerOrganisationUID) AS 'orguid.$oid',          
(select top 1 uid from healthorganisation where uid=oc.OwnerOrganisationUID) as orgcode,          
'ordercatalogitem' externaltablename,          
'vital' bsmdduid,          
cast(OC.uid as nvarchar) externaluid          
FROM          
ORDERCATALOGITEM OC          
               
where OC.ORDTYPUID IN (DBO.FGETREFERENCEVALUEUID('VITAL','ORDCTP'),DBO.FGETREFERENCEVALUEUID('IO','ORDCTP'))           
          
for json path) as X          