CREATE VIEW vAirOrderCategory        
As        
SELECT        
(        
SELECT          
RF.GUID AS '_id.$oid',        
RF.VALUECODE code,        
description name,        
description description,        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', RF.activefrom ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', RF.activeto ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',           
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
'ON RAISING'billingtype,        
convert(bit,'false') issubcategory,        
CASE RF.NUMERICVALUE when 5 THEN convert(bit,'true') ELSE convert(bit,'false') END iscareprovidermandatory,        
null showpopupduringentry,        
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=RF.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                 
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RF.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                  
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=RF.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,RF.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',                                            
RF.STATUSFLAG statusflag,                
(select top 1 guid from healthorganisation where uid=1) AS 'orguid.$oid',        
(select top 1 uid from healthorganisation where uid=1) as orgcode,        
null parentcategoryuid,        
convert(bit,'true')alertforduplicate,        
CASE RF.NUMERICVALUE        
  WHEN 3 THEN convert(bit,'true')        
  WHEN 4 THEN convert(bit,'true')        
   else convert(bit,'false') END allowcontinuousorders,        
CASE RF.NUMERICVALUE        
  WHEN 2 THEN convert(bit,'true')        
   else convert(bit,'false') END isclinicalinfomandatory,        
'Referencevalue' externaltablename,        
cast(RF.uid as nvarchar) externaluid        
        
FROM REFERENCEVALUE RF WHERE DOMAINCODE='ORDCT'        
FOR JSON PATH) AS X        
        
  