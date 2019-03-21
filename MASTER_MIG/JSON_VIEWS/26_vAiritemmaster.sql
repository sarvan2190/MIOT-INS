CREATE VIEW vAiritemmaster          
As          
SELECT          
(          
SELECT          
          
m.guid as  '_id.$oid',          
m.CODE code ,          
LTRIM(RTRIM(M.NAME))name,          
CASE WHEN M.IsStock ='Y' THEN convert(bit,'false') else convert(bit,'true') END isnoninventoryitem,          
(select top 1 b.guid from billableitem b where b.itemuid=m.uid          
and b.bsmdduid in(5183,1945))as 'orderitemuid.$oid',          
LTRIM(RTRIM(M.DESCRIPTION))description,          
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(M.Comments, CHAR(9), ' '), CHAR(13), ' '), CHAR(10), ' '))) notes,          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,m.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,m.activeto) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',             
(select top 1 rf.guid from referencevalue  rf where rf.uid=SLUOMUID) 'baseuomuid.$oid',          
isnull((select top 1 rf.guid from referencevalue rf where rf.uid=PURCHASEUOM),          
(select top 1 rf.guid from referencevalue rf where rf.uid=SALESUOM)) 'purchasinguomuid.$oid',          
CASE WHEN M.IsBatchIDMandatory = 'Y' THEN convert(bit,'true') else convert(bit,'false') END isbatchidmandatory ,          
CASE WHEN M.IsExpiryDateMandatory = 'Y' THEN convert(bit,'true') else convert(bit,'false') END isexpirydatemandatory ,          
(select top 1 rf.guid from referencevalue  rf where rf.uid=STGRPUID) 'stockauditgroup.$oid',          
(select top 1 rf.guid from referencevalue  rf where rf.uid=STCATUID) 'productcategoryuid.$oid',          
CASE WHEN M.isconsignmentitem = 'Y' THEN convert(bit,'true') else convert(bit,'false') end  allowconsignmentstock,          
CASE WHEN M.IsIntegerQty = 'Y' THEN convert(bit,'true') else convert(bit,'false') end  allowfractions,          
CASE WHEN M.CanDispenseWithOutStock = 'Y' THEN convert(bit,'true') else convert(bit,'false') END allownegativestock,          
CASE WHEN M.IsManufactureItem = 'Y' THEN convert(bit,'true') else convert(bit,'false') END ismanufacturingitem,          
(SELECT (SELECT TOP 1 GUID FROM ITEMMASTER IM where im.uid=itemf.itemuid) 'ingredient.$oid',          
 Quantity as inputquantity          
FROM ITEMFORMULA itemf          
 where itemf.itemmasteruid=m.uid          
and itemf.statusflag='A'          
FOR JSON PATH) AS manufactureformula,          
m.outputquantity manufactureminquantity,          
m.outputquantity manufacturemaxquantity,          
m.outputquantity manufacturequantity,          
'30' expiryaftermanufacture,          
null allowrepacking ,          
null taxcode,          
(select top 1 guid from itemmasterimage where itemmasteruid=m.uid) as 'itemimageuid.$oid',          
(SELECT MD.GUID FROM ManufacturerDetail(NOLOCK)  MD WHERE MD.STATUSFLAG ='A' AND MD.UID = M.ManufacturedByUID) 'manufacturedby.$oid',          
(SELECT MD.GUID FROM ManufacturerDetail(NOLOCK)  MD WHERE MD.STATUSFLAG ='A' AND MD.UID = M.MarketedByUID) 'distributedby.$oid',          
(select top 1 rf.guid from referencevalue  rf where rf.uid=ITMTYPUID) 'itemtypeuid.$oid',          
null stogareins,          
(SELECT TOP 1 IMA.AliasName FROM ItemMasterAlias IMA WHERE IMA.ItemMasterUID=M.UID AND IMA.StatusFlag='A')aliasnames,          
(SELECT MD.GUID FROM ManufacturerDetail(NOLOCK)  MD WHERE MD.STATUSFLAG ='A' AND MD.UID = M.MarketedByUID) 'abcanalysisuid.$oid',          
null venanalysisuid,     
null reorderdetails,       
--(          
--select distinct         
--s.guid as 'storeuid.$oid',          
--si.minstocklevel,          
--si.maxstocklevel,          
--null refilltomaxlevel,          
--null eoq,          
--si.reorderlevel,          
--si.reorderquantity,          
--null reorderlevelformula,          
--null reorderqtyformula,          
--si.uid externalstoreitemuid,          
--'storeitem' externaltablename          
--from storeitem si,store s          
--where si.storeuid=s.uid          
--and si.itemmasteruid=m.uid          
--and si.statusflag='A'          
--AND s.statusflag='A'          
--FOR JSON PATH) AS reorderdetails,          
(          
select          
Im.GUID AS 'vendoruid.$oid',          
null as orderofpreference,          
cast(I.UID as nvarchar) externalitemmanfuid,          
'itemmanufacturerdetail' externaltablename          
FROM          
manufacturerdetail im,          
ITEMMANUFACTURERDETAIL I          
WHERE I.ITEMMASTERUID=m.uid          
and im.uid=i.manufactureruid          
and i.statusflag='A'          
and im.statusflag='A'          
for json path) vendordetails,    
       
(select  distinct         
s.guid as 'storeuid.$oid',          
(select top 1 sb.guid from storebin sb where sb.uid=si.storebinuid)'binuid.$oid',          
convert(bit,'true') isstockitem          
 from storeitem si,store s          
where si.storeuid=s.uid          
and si.itemmasteruid=m.uid          
and si.statusflag='A'          
AND s.statusflag='A'          
FOR JSON PATH) AS handlingstores,          
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=M.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,M.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=m.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                         
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,M.MWHEN )) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                    
m.statusflag statusflag,                  
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',          
(select top 1 uid from healthorganisation where uid=2) as orgcode,          
'itemmaster' externaltablename,          
cast(m.uid as nvarchar) externaluid ,         
case when m.VATPercentage=0 then '5c8f430c792dc06f76992bec'   
when m.VATPercentage=14.5 then '5c8f4337792dc06f76992bee'   
when m.VATPercentage=5 then '5c89c0c5792dc06f769929b3'   
when m.VATPercentage=12 then '5c89c0eb792dc06f769929b5'  
when m.VATPercentage=18 then '5c89c119792dc06f769929b7'  
when m.VATPercentage=28 then '5c89c13c792dc06f769929b9'  
else null end as   'taxcodeuid.$oid'       
FROM          
itemmaster m          
for json path) as X          
          
  
  