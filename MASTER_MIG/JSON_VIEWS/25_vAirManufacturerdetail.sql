CREATE VIEW vAirManufacturerdetail    
As    
SELECT     
(    
select md.GUID AS '_id.$oid',    
md.Code code,    
LTRIM(RTRIM(MD.CompanyName))name,    
LTRIM(RTRIM(MD.CompanyName))companyname,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,md.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,md.ACTIVETO) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
(select top 1 guid from referencevalue rf where rf.uid=md.mnftpuid) 'vendortypeuid.$oid',    
null vendorclassuid,    
null credittermuid,    
MD.CompanyName contactpersonname,    
isnull(EA.line1,'')+isnull(EA.line2,'')+Isnull(Line3,'')+Isnull(Line4,'')[address.address],    
dbo.fGetReferenceValueguid(EA.CITTYUID) 'address.cityuid.$oid',    
dbo.fGetReferenceValCode(EA.CITTYUID)[address.city],    
dbo.fGetReferenceValCode(EA.STATEUID) [address.state],    
dbo.fGetReferenceValueguid(EA.STATEUID) 'address.stateuid.$oid',    
dbo.fGetReferenceValCode(EA.CNTRYUID) [address.country],    
dbo.fGetReferenceValueguid(EA.CNTRYUID) 'address.countryuid.$oid',    
EA.PinCode [address.zipcode],    
(select top 1 pm.guid from PinCodeMapping pm where pm.PinCode=EA.PinCode) 'address.zipcodeuid.$oid',    
null workphone,    
null mobilephone,    
null alternatephone,    
null emailid,    
isnull((select top 1 guid from careprovider c where c.uid=MD.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,MD.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=MD.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,MD.MWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                             
(select top 1 guid from healthorganisation where UID=MD.OwnerOrganisationUID) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where UID=MD.OwnerOrganisationUID) as orgcode,    
MD.VendorURL weburl,    
MD.STATUSFLAG statusflag,    
cast(MD.UID as nvarchar) externaluid    
from ManufacturerDetail MD OUTER APPLY     
(SELECT TOP 1 EA.Line1,EA.Line2,EA.Line3,EA.Line4,EA.CITTYUID,EA.STATEUID,EA.CNTRYUID,EA.Pincode        
,EA.ADTYPUID  FROM EnterpriseAddress(NOLOCK) EA WHERE EA.StatusFlag = 'A' AND EA.identifyinguid = MD.UID AND EA.ADTYPUID = DBO.fGetReferenceValueUID('DEFADD','ADTYP')) EA        
FOR JSON PATH) AS X    
  
  
  
  