CREATE view vairarea  
as  
select  
(  
select  
r.guid as '_id.$oid',  
r.valuecode code,  
r.description name,  
CASE WHEN r.Description <> r.ALTERNATENAME THEN r.ALTERNATENAME ELSE '' END locallangname,  
DBO.fGetrfvaldescription(RRS1.TargetReferenceValueUID)country,  
dbo.fGetReferenceguid(RRS1.TargetReferenceValueUID) 'countryuid.$oid',  
DBO.fGetrfvaldescription(RRS2.TargetReferenceValueUID)state,  
dbo.fGetReferenceguid(RRS2.TargetReferenceValueUID) 'stateuid.$oid',  
DBO.fGetrfvaldescription(RRS3.TargetReferenceValueUID) city,  
dbo.fGetReferenceguid(RRS3.TargetReferenceValueUID) 'cityuid.$oid',  
(SELECT TOP 1 CASE WHEN ISNUMERIC(PM.PinCode)=1 THEN PM.PinCode ELSE PM.PinCode END  FROM PinCodeMapping(NOLOCK) PM WHERE PM.StatusFlag = 'A' AND PM.AREAUID = R.UID AND PM.CITTYUID = RRS3.TargetReferenceValueUID) zipcode,  
(SELECT TOP 1 CASE WHEN ISNUMERIC(PM.PinCode)=1 THEN PM.GUID ELSE PM.GUID END  FROM PinCodeMapping(NOLOCK) PM WHERE PM.StatusFlag = 'A' AND PM.AREAUID = R.UID AND PM.CITTYUID = RRS3.TargetReferenceValueUID) 'zipcodeuid.$oid',  
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,r.activefrom) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,r.activeto) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',      
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=R.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,R.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=R.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,R.mWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                             
R.statusflag statusflag,          
'569794170946a3d0d588efe6' AS 'orguid.$oid',  
cast(r.uid as nvarchar) externaluid,  
'referencevalue'externaltablename  
FROM  
REFERENCEVALUE(NOLOCK) R  
OUTER APPLY (SELECT TOP 1 * FROM ReferenceRelationShip(NOLOCK) RRS3  WHERE RRS3.SourceReferenceValueUID = R.UID AND RRS3.SourceReferenceDomainCode = R.DOMAINCODE AND RRS3.TargetReferenceDomainCode = 'CITTY' AND RRS3.STATUSFLAG = 'A')RRS3    
OUTER APPLY (SELECT TOP 1 * FROM ReferenceRelationShip(NOLOCK) RRS2  WHERE RRS2.SourceReferenceValueUID = RRS3.TargetReferenceValueUID AND RRS2.SourceReferenceDomainCode = RRS3.TargetReferenceDomainCode AND RRS2.TargetReferenceDomainCode = 'STATE' AND RRS
2.STATUSFLAG = 'A')RRS2    
OUTER APPLY (SELECT TOP 1 * FROM ReferenceRelationShip(NOLOCK) RRS1  WHERE RRS1.SourceReferenceValueUID = RRS2.TargetReferenceValueUID AND RRS1.SourceReferenceDomainCode = RRS2.TargetReferenceDomainCode AND RRS1.TargetReferenceDomainCode = 'CNTRY' AND RRS
1.STATUSFLAG = 'A')RRS1    
--eliminated due to duplication  
--LEFT OUTER JOIN  
--ReferenceRelationShip(NOLOCK) RRS3 ON (RRS3.SourceReferenceValueUID = R.UID AND RRS3.SourceReferenceDomainCode = R.DOMAINCODE AND RRS3.TargetReferenceDomainCode = 'CITTY' AND RRS3.STATUSFLAG = 'A')  
--LEFT OUTER JOIN  
--ReferenceRelationShip(NOLOCK) RRS2 ON (RRS2.SourceReferenceValueUID = RRS3.TargetReferenceValueUID AND RRS2.SourceReferenceDomainCode = RRS3.TargetReferenceDomainCode AND RRS2.TargetReferenceDomainCode = 'STATE' AND RRS2.STATUSFLAG = 'A')  
--LEFT OUTER JOIN  
--ReferenceRelationShip(NOLOCK) RRS1 ON (RRS1.SourceReferenceValueUID = RRS2.TargetReferenceValueUID AND RRS1.SourceReferenceDomainCode = RRS2.TargetReferenceDomainCode AND RRS1.TargetReferenceDomainCode = 'CNTRY' AND RRS1.STATUSFLAG = 'A')  
WHERE  
R.DOMAINCODE = 'AREEA'  
AND R.STATUSFLAG = 'A'  
--and (r.activeto is null or r.activeto > getdate())  
----ORDER BY 2  
for json path)as x  
  
  
  
  