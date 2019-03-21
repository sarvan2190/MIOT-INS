CREATE VIEW vairreferralMaster    
As    
Select    
(    
Select     
BM.guid as '_id.$oid',    
BM.uid  code,    
LTRIM(RTRIM(BM.identifyingname)) name,    
LTRIM(RTRIM(BM.identifyingname)) description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,CAST(BM.ACTIVEFROM AS DATETIME))) as bigint) * 1000  AS NVARCHAR(50)) as 'activefrom.$date.$numberLong',            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,CAST(BM.ACTIVETO AS DATETIME))) as bigint) * 1000  AS NVARCHAR(50)) as 'activeto.$date.$numberLong',            
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=BM.RFRTPUID) 'reftypeuid.$oid',    
null 'refsubtypeuid.$oid',    
null [address.address],    
--null as 'address.areauid.$oid',    
--null as 'address.area',    
--null as 'address.city',    
--null as 'address.cityuid.$oid',    
--null 'address.stateuid.$oid',    
--null 'add ress.state',    
----null 'address.countryuid.$oid',    
----null'address.country',    
--null 'address.zipcodeuid.$oid',    
--null 'address.zipcode',    
null organisationcode,    
--null PHONE,    
--null MOBILE,    
--null EMAILID,    
--null WEBURL,    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BM.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BM.CWHEN)) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=BM.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,BM.mWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                             
BM.statusflag statusflag,            
(select top 1 guid from healthorganisation where uid=bm.ownerorganisationuid) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=bm.ownerorganisationuid) as orgcode,    
'referralmaster' externaltablename,    
BM.UID externaluid    
FROM     
referralmaster BM    
for json path) as x  
  
  