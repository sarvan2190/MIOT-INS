CREATE VIEW vAirPayorAgreement                  
as                  
SELECT                  
(                  
SELECT                  
PA.GUID AS '_id.$oid',                  
PA.CODE code,                  
LTRIM(RTRIM(PA.NAME)) name,                  
LTRIM(RTRIM(PA.DESCRIPTION))  description,                  
null splitbynetamount,                  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PA.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',                     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,PA.ACTIVETO )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',                    
CASE WHEN DBO.fGetReferenceValCode(PBTYPUID)='RECEI' THEN 'BILLINGENUMS.BILLTYPERECEIPT' ELSE 'BILLINGENUMS.BILLTYPEINVOICE' END billtype,                  
null encountertypeuid,                  
(select top 1 guid from referencevalue rf where rf.uid=pa.PRIMARYPBLCTUID) 'primarytariffuid.$oid',                  
(select top 1 guid from referencevalue rf where rf.uid=SECONDARYPBLCTUID) 'secondarytariffuid.$oid',                  
(select top 1 guid from referencevalue rf where rf.uid=TERTIARYPBLCTUID) 'tertiarytariffuid.$oid',                  
 CASE WHEN(SELECT TOP 1 ADDT.IsPackage  FROM AgreementAccountDetail ADDT                   
 WHERE ADDT.PAYORAGREEMENTUID=PA.UID)='Y' THEN convert(bit,'true') else convert(bit,'false') end ispackageallowed,                  
null isspecialdiscallowed,                  
CASE WHEN PA.ClaimPercentage='0'                   
THEN NULL  ELSE  PA.ClaimPercentage end claimpercentage,                  
CASE WHEN (select  TOP 1                 
 1                  
from agreementinclusive ai                  
where ai.payoragreementuid=pa.uid                  
and pa.statusflag='a'  ) =1 THEN CONVERT(bit ,'false') else CONVERT(bit ,'true') END allgroupsincluded,               
CONVERT(bit ,'false')  allpackagecategoriesincluded,               
CONVERT(bit ,'false')  allsetcategoriesincluded,               
               
null allowedbedpackages,                  
(                  
SELECT DISTINCT                   
PA.CODE  payoagreecode,                  
(select top 1 guid from referencevalue rf where rf.uid=ad.PBLCTUID)'tarifftypeuid.$oid',                  
DBO.fGetReferenceValCode(AD.PBLCTUID) tarifftypecode,                  
(select top 1 guid from service s where s.uid=ad.SERVICEUID) 'billinggroupuid.$oid',                  
DBO.fGetServiceCodeByUID(AD.SERVICEUID) billinggroupcode,                  
'5a9e2c9a3fabfd6bfff7e084' as 'groupagreementdiscounttypeuid.$oid',                  
case when AD.ISPERCENTAGE<>'Y' then AD.DISCOUNT  else null end  discountamount,                   
case when AD.ISPERCENTAGE='Y' then AD.DISCOUNT else null end discountpercentage,                  
CASE WHEN DBO.fGetReferenceValCode(AD.ALLDIUID)='NEXPA' THEN 'BILLINGENUMS.NEXTPAYOR' ELSE 'BILLINGENUMS.CURRENTPAYOR' END allowdiscounts,                  
case when AD.ISPERCENTAGE='Y' then convert(bit,'true') else convert(bit,'false') end  ispercentage,                  
'AgreementAccountDiscount' externalAgreementAccountDiscount,                  
AD.externaluid externaluid                   
FROM GROUPDISCOUNT AD                  
where ad.payoragreementuid=pa.uid                  
and ad.statusflag='A'                  
and pa.statusflag='a'                  
FOR JSON PATH) AS groupdiscounts,                  
 (                  
select                   
(select top 1 guid from service s where s.uid=ai.serviceuid) '$oid'                  
from agreementinclusive ai                  
where ai.payoragreementuid=pa.uid                  
and pa.statusflag='a'                  
for json path) inclusions,               
                     
              
              
(                  
select                   
(select top 1 guid from service s where s.uid=ai.serviceuid) '$oid'                  
from agreementexclusion ai                  
where ai.payoragreementuid=pa.uid                  
and pa.statusflag='a'                  
for json path)  exclusions,                  
(                  
SELECT DISTINCT                   
(select top 1 guid from referencevalue rf where rf.uid=ad.PBLCTUID)'tarifftypeuid.$oid',                  
DBO.fGetReferenceValCode(AD.PBLCTUID) tarifftypecode,                  
(select top 1 bi.guid from billableitem bi where bi.uid=ad.billableitemuid)'orderitemuid.$oid',                  
DBO.fGetBillableItemCodeByUID(AD.BillableItemUID) orderitemcode,                  
case when AD.ISPERCENTAGE<>'Y' then AD.DISCOUNT  else null end  discountamount,                   
case when AD.ISPERCENTAGE='Y' then AD.DISCOUNT else null end discountpercentage,                   
CASE WHEN DBO.fGetReferenceValCode(AD.ALLDIUID)='NEXPA' THEN 'BILLINGENUMS.NEXTPAYOR' ELSE 'BILLINGENUMS.CURRENTPAYOR' END allowdiscounts,                  
'5a9e2c9a3fabfd6bfff7e084' as 'itemagreementdiscounttypeuid.$oid',                  
AD.ISPERCENTAGE ispercentage                
FROM                   
AgreementItemDiscount AD                  
WHERE                  
AD.STATUSFLAG = 'A'                  
and pa.statusflag='a'                  
AND PA.UID = AD.PayorAgreementUID                
--AND (AD.DATETO IS NULL OR AD.DATETO>GETDATE())                
AND PA.STATUSFLAG = 'A' for json path) as itemleveldiscounts,                  
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PA.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PA.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                            
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PA.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PA.MWHEN )) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                   
(SELECT TOP 1 GUID FROM HEALTHORGANISATION WHERE uid=pa.OwnerOrganisationUID)'orguid.$oid',                  
(SELECT TOP 1 UID FROM HEALTHORGANISATION WHERE uid=pa.OwnerOrganisationUID) orgcode,                  
PA.STATUSFLAG statusflag,                 
              
(              
select              
bi.guid  '$oid'              
from              
AgreementDetail ADDT,              
AgreementItem BCAAD,              
BILLABLEITEM BI              
              
              
WHERE              
PA.STATUSFLAG='A'              
AND ADDT.StatusFlag='A'              
AND ADDT.PayorAgreementUID=PA.UID              
AND BCAAD.AgreementDetailUID=ADDT.UID                
AND ADDT.StatusFlag='A'          
AND BI.UID=BCAAD.BillableItemUID            
AND PA.AGTYPUID IN(DBO.FGETREFERENCEVALUEUID('INCLU','AGTYP'))              
for json path ) as includeditems,              
              
(              
select              
bi.guid  '$oid'              
from              
AgreementDetail ADDT,              
AgreementItem BCAAD,              
BILLABLEITEM BI              
              
              
WHERE              
PA.STATUSFLAG='A'              
AND ADDT.StatusFlag='A'              
AND ADDT.PayorAgreementUID=PA.UID              
AND BCAAD.AgreementDetailUID=ADDT.UID                
AND ADDT.StatusFlag='A'              
AND BI.UID=BCAAD.BillableItemUID        
AND PA.AGTYPUID IN(DBO.FGETREFERENCEVALUEUID('INCLU','AGTYP'))               
              
for json path ) as excludeditems,              
cast(PA.uid as nvarchar)  externaluid,                  
'payoragreement'externaltablename                  
FROM                  
PAYORAGREEMENT PA                    
                  
                   
                  
FOR JSON PATH) AS X 