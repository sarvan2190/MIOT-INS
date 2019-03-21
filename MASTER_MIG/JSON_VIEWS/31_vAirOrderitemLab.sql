CREATE VIEW vAirOrderitemLab          
As          
SELECT          
(          
select bi.GUID AS '_id.$oid',          
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(BID.itemname,'"','\"') + '"'                 
FROM BILLABLEITEMALIAS BID  WHERE BID.BillableItemUID = BI.UID AND BID.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,          
(          
SELECT          
rsi.guid as  'resultitemuid.$oid',          
RRL.PrintOrder displayorder,          
BI.CODE code ,          
RSI.CODE resultitemcode ,          
CASE WHEN RSI.ExcludeFrmPrint='Y' THEN convert(bit,'true') else convert(bit,'false') End excludefromprint,          
rsi.uid externaluid,          
'resultitem'externaltablename          
FROM          
RESULTITEM RSI(NOLOCK),          
REQUESTRESULTLINK RRL(NOLOCK)          
WHERE          
RI.STATUSFLAG = 'A'          
AND RRL.REQUESTITEMUID=RI.UID          
AND RRL.RESULTITEMUID=RSI.UID          
AND BI.ITEMUID = RI.UID          
AND BI.STATUSFLAG = 'A'          
AND RRL.STATUSFLAG='A'          
AND RI.STATUSFLAG='A'          
for json path) as resultitems,          
(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICEUID)'billingserviceuid.$oid',          
--(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICESAPUID)'billingservicesapuid.$oid',          
null orderiteminstructions,          
bi.code as code,          
bi.itemname as name,          
bi.description as description,          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,bi.activefrom )) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH, -5.30,bi.activeto )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',             
DBO.fGetReferenceValCode(BI.ORDCTUID) ordercategorycode ,          
(SELECT CAST(O.UID AS NVARCHAR) FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = BI.ORDERSUBCATEGORYUID) Ordersubcategorycode,          
(select top 1 guid from referencevalue rf where rf.uid=bi.ORDCTUID)as 'ordercatuid.$oid',          
(select top 1 guid from ordercategory rf  where rf.uid=bi.ORDERSUBCATEGORYUID)as 'ordersubcatuid.$oid',          
convert(bit,'false') istaskgenerationreqd,          
CASE WHEN IsConfidential = 'Y' THEN convert(bit,'true') else convert(bit,'false') end ispermissionreqforresult,          
convert(bit,'false') isapprovalrequired,          
convert(bit,'false') iscosignrequired,          
CASE WHEN ISconssharerequired='Y' THEN convert(bit,'true') else convert(bit,'false') end isdoctorshareitem,          
--(select top 1 guid from referencevalue rf where rf.uid=RI.prityuid) as defaultpriorityuid,          
convert(bit,'false')  ishourlycharge ,          
CASE WHEN bi.ISschedulable='Y' then convert(bit,'true') else convert(bit,'false') end  isschedulable ,          
CASE WHEN iseditable='Y' then convert(bit,'true') else convert(bit,'false') end allowpriceoverride,          
CASE WHEN ispackageitem='Y' then convert(bit,'true') else convert(bit,'false') end ispackageitem,          
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                   
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.mWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                    
BI.STATUSFLAG statusflag,               
(select top 1 guid from healthorganisation where UID=bi.OwnerOrganisationUID) AS 'orguid.$oid',          
(select top 1 uid from healthorganisation where UID=bi.OwnerOrganisationUID) as orgcode,          
----(select top 1 guid from bdmsincomesource bd where bd.uid=bi.bdmsincomesourceuid)'incomesourceuid.$oid',          
(select top 1 guid from referencevalue where UID=BI.BSMDDUID)'servicecattypeuid.$oid',          
'billableitem' externaltablename,          
bi.bsmdduid bsmmduid,          
RI.uid externaluidrequest,          
cast(bi.uid as nvarchar) externaluid,      
bi.HSNCode hsncode,  
(select top 1 guid from referencevalue where UID=RI.SEXXXUID)'restrictgender.$oid'  
          
FROM          
REQUESTITEM(NOLOCK) RI,          
BILLABLEITEM(NOLOCK) BI          
WHERE          
--M.STATUSFLAG = 'A'          
BI.BSMDDUID IN (DBO.FGETREFERENCEVALUEUID('LABBB','BSMDD'),DBO.FGETREFERENCEVALUEUID('RADIO','BSMDD'))          
AND BI.ITEMUID = RI.UID          
for json path) as X         
  
  
  
          
          
          