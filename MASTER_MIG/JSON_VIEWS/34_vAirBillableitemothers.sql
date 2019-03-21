CREATE VIEW [dbo].vAirBillableitemothers              
As              
SELECT              
(              
select bi.GUID AS '_id.$oid',              
JSON_QUERY('[' + STUFF(( SELECT ',' + '"' + REPLACE(BID.itemname,'"','\"') + '"'   FROM BILLABLEITEMALIAS BID  WHERE BID.BillableItemUID = BI.UID AND BID.STATUSFLAG='A' FOR XML PATH('')),1,1,'') + ']' )  as aliasnames,            
(SELECT TOP 1 GUID FROM BILLINGSERVICE WHERE UID=BILLINGSERVICEUID) 'billingserviceuid.$oid',             
            
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
convert(bit,'false') istaskgenerationreqd,              
convert(bit,'false') ispermissionreqforresult,              
convert(bit,'false') isapprovalrequired,              
convert(bit,'false') iscosignrequired,              
CASE WHEN Isconssharerequired='Y' THEN convert(bit,'true') else convert(bit,'false') end isdoctorshareitem,              
null as 'defaultpriorityuid',              
convert(bit,'false') ishourlycharge ,              
convert(bit,'false')  isschedulable ,              
CASE WHEN iseditable='Y' then convert(bit,'true') else convert(bit,'false') end allowpriceoverride,              
CASE WHEN ispackageitem='Y' then convert(bit,'true') else convert(bit,'false') end ispackageitem,              
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                                    
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BI.MUSER) ,'5c7659e45d836f29be36758c')AS 'modifiedby.$oid',                                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BI.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',                                       
bi.statusflag statusflag,                      
(select top 1 guid from healthorganisation where uid=bi.OwnerOrganisationUID) AS 'orguid.$oid',              
(select top 1 uid from healthorganisation where uid=bi.OwnerOrganisationUID) as orgcode,              
'billableitem' externalidentifier,              
            
(select top 1 r.guid from referencevalue r where r.UID=BSMDDUID)'servicecattypeuid.$oid',            
bi.bsmdduid bsmdduid,            
'BillableitemOthers' type,              
             
cast(bi.uid as nvarchar) externaluid ,      
bi.HSNCode hsncode            
FROM               
BILLABLEITEM(NOLOCK) BI              
WHERE              
--bi.BSMDDUID IN(1410,1642,4358,1164,4466,1646,1163) AND            
            
BI.BSMDDUID IN             
(            
DBO.FGETREFERENCEVALUEUID('MISCE','BSMDD'),            
DBO.FGETREFERENCEVALUEUID('LABPR','BSMDD'),            
DBO.FGETREFERENCEVALUEUID('ADVNCE','BSMDD'),            
DBO.FGETREFERENCEVALUEUID('IMPLA','BSMDD'),            
DBO.FGETREFERENCEVALUEUID('TMTCHG','BSMDD'),            
DBO.FGETREFERENCEVALUEUID('ROOMM','BSMDD'),            
DBO.FGETREFERENCEVALUEUID('PROCE','BSMDD') ,        
DBO.FGETREFERENCEVALUEUID('ORDSET','BSMDD'),          
DBO.FGETREFERENCEVALUEUID('REGIS','REGIS')         
)              
            
for json path) as x           
  
  
  