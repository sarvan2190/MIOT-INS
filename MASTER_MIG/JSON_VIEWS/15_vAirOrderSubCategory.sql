CREATE VIEW vAirOrderSubCategory      
As      
SELECT      
(      
SELECT        
O.GUID AS '_id.$oid',      
O.CODE code,      
O.name name,      
o.description description,      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', getdate()-1 ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',         
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', null ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',         
CASE RF.NUMERICVALUE       
  WHEN 1 THEN 'LAB'      
  WHEN 2 THEN 'RADIOLOGY'      
  WHEN 3 THEN 'MEDICINE'      
  WHEN 4 THEN 'SUPPLY'      
  WHEN 5 THEN 'DOCTORFEE'      
  WHEN 6 THEN 'DIET'      
  WHEN 7 THEN 'OTHERS'      
  WHEN 8 THEN 'OTHERS'      
  WHEN 9 THEN 'DIET'      
  WHEN 10 THEN 'EQUIPMENT'      
  ELSE 'OTHERS' END ordercattype,      
  CASE WHEN OBTYPUID=DBO.FGETREFERENCEVALUEUID('ONCOMP','ORBLTY') THEN 'ON EXECUTION'      
  ELSE ltrim(rtrim(UPPER(DBO.fGetRfValDescription(OBTYPUID)))) END billingtype,      
convert(bit,'true') issubcategory,      
CASE RF.NUMERICVALUE WHEN 5 THEN convert(bit,'true') ELSE convert(bit,'false') END iscareprovidermandatory,      
CASE RF.NumericValue WHEN 3 THEN convert(bit,'true')       
WHEN 4 THEN convert(bit,'true')  else convert(bit,'false')  END showpopupduringentry,      
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=o.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,o.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=o.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',              
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,o.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',                                                     
O.STATUSFLAG statusflag,              
(select top 1 guid from healthorganisation where uid=o.OwnerOrganisationUID) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=o.OwnerOrganisationUID) as orgcode,      
rf.guid as 'parentcategoryuid.$oid',      
convert(bit,'true')alertforduplicate,      
CASE Rf.NUMERICVALUE      
  WHEN 3 THEN convert(bit,'true')      
  WHEN 4 THEN convert(bit,'true')      
   else convert(bit,'false') END allowcontinuousorders,      
CASE Rf.NUMERICVALUE      
  WHEN 2 THEN convert(bit,'true')      
   else convert(bit,'false') END isclinicalinfomandatory,      
'ordercategory' externaltablename,      
cast(O.uid as nvarchar) externaluid      
FROM      
ReferenceValue(NOLOCK) RF      
,OrderCategory(NOLOCK) O      
WHERE      
RF.UID = O.PARENTUID      
AND RF.DOMAINCODE = 'ORDCT'      
AND RF.StatusFlag = 'A'      
AND O.STATUSFLAG = 'A'      
FOR JSON PATH) AS X      
      
      