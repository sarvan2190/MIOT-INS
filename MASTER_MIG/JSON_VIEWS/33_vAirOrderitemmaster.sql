CREATE VIEW vAirOrderitemmaster        
AS        
SELECT              
(              
select bi.GUID AS '_id.$oid',              
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(BID.itemname,'"','\"') + '"'               
FROM BILLABLEITEMALIAS BID  WHERE BID.BillableItemUID = BI.UID AND BID.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,             
(SELECT              
(select top 1 guid from referencevalue rf where rf.uid=DI.INSTYPUID) as 'instructiontypeuid.$oid',              
'591e82f9a57b21756dda8ab9' 'instructionuid.$oid',              
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(DI.INSTRUCTIONTEXT, CHAR(9), ' '), CHAR(13), ' '), CHAR(10), ' '))) instructiontext,              
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(DI.LOCALINSTRUCTIONTEXT, CHAR(9), ' '), CHAR(13), ' '), CHAR(10), ' ')))locallangtext,              
DI.STATUSFLAG statusflag,              
'druginstruction' as externaltablename,              
DI.UID externaluid              
FROM              
DRUGINSTRUCTION DI              
,DRUGCATALOGITEM DC              
JOIN DRUGTRADENAME(NOLOCK) DTR ON (DTR.DRUGCATALOGITEMUID = DC.UID AND DTR.STATUSFLAG = 'A')              
WHERE              
DC.STATUSFLAG = 'A'              
AND DC.UID = DI.DRUGCATALOGITEMUID              
AND DTR.itemmasteruid=m.uid              
AND DI.STATUSFLAG = 'A'              
AND  (len(INSTRUCTIONTEXT)>=1 OR len(LOCALINSTRUCTIONTEXT)>=1)              
FOR JSON PATH) AS orderiteminstructions,              
(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICEUID)'billingserviceuid.$oid',         
--(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICESAPUID)'billingservicesapuid.$oid',             
bi.code as code,              
bi.itemname as name,              
bi.description as description,              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,bi.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',                 
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,bi.ACTIVETO) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',                 
dbo.fGetReferenceValCode(BI.ORDCTUID) ordercategorycode ,              
(SELECT CAST(O.UID AS NVARCHAR) FROM ORDERCATEGORY O WHERE O.STATUSFLAG = 'A' AND O.UID = BI.ORDERSUBCATEGORYUID) Ordersubcategorycode,              
(select top 1 guid from referencevalue rf where rf.uid=bi.ORDCTUID)as 'ordercatuid.$oid',              
(select top 1 guid from ordercategory rf  where rf.uid=bi.ORDERSUBCATEGORYUID)as 'ordersubcatuid.$oid',              
convert(bit,'false')istaskgenerationreqd,              
convert(bit,'false') ispermissionreqforresult,              
convert(bit,'false') isapprovalrequired,              
convert(bit,'false') iscosignrequired,              
CASE WHEN Isconssharerequired='Y' THEN convert(bit,'true') else convert(bit,'false') end isdoctorshareitem,              
--(select top 1 guid from referencevalue rf where rf.uid=oc.prityuid) as defaultpriorityuid,              
convert(bit,'false') ishourlycharge ,              
CASE WHEN bi.ISschedulable='Y' then convert(bit,'true') else convert(bit,'false') end  isschedulable ,              
CASE WHEN iseditable='Y' then convert(bit,'true') else convert(bit,'false') end allowpriceoverride,              
CASE WHEN ispackageitem='Y' then convert(bit,'true') else convert(bit,'false') end ispackageitem,              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                      
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.mWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                         
bi.statusflag statusflag,                      
(select top 1 guid from healthorganisation where UID=BI.OwnerOrganisationUID) AS 'orguid.$oid',              
(select top 1 uid from healthorganisation where UID=BI.OwnerOrganisationUID) as orgcode,              
'billableitem' externaltablename,              
(select top 1 guid from referencevalue where UID=BSMDDUID)'servicecattypeuid.$oid',        
bi.bsmdduid bsmdduid,              
m.uid externaluiditemmaster,              
CAST(bi.uid AS NVARCHAR) externaluid  ,    
bi.HSNCode hsncode           
FROM              
ITEMMASTER(NOLOCK) M,              
BILLABLEITEM(NOLOCK) BI              
--WHERE              
--M.STATUSFLAG = 'A'              
WHERE BI.BSMDDUID IN (DBO.FGETREFERENCEVALUEUID('STORE','BSMDD'),DBO.FGETREFERENCEVALUEUID('SUPPL','BSMDD'))              
AND BI.ITEMUID = M.UID              
--AND BI.STATUSFLAG = 'A'              
for json path) as X          
    
            
        
        