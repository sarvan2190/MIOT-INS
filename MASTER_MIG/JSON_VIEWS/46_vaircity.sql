create view vaircity  
as  
select  
(  
select distinct   
r.guid as '_id.$oid',  
r.valuecode code,  
r.description name,  
CASE WHEN r.Description <> r.ALTERNATENAME THEN r.ALTERNATENAME ELSE '' END locallangname,  
DBO.fGetrfvaldescription(RRS1.TargetReferenceValueUID)  country,  
DBO.fGetReferenceguid(RRS.TargetReferenceValueUID) 'countryuid.$oid',  
DBO.fGetrfvaldescription(RRS.TargetReferenceValueUID)  state,  
DBO.fGetReferenceguid(RRS.TargetReferenceValueUID) 'stateuid.$oid',  
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
OUTER APPLY (SELECT TOP 1 * FROM ReferenceRelationShip(NOLOCK) RRS WHERE RRS.SourceReferenceValueUID = R.UID AND RRS.SourceReferenceDomainCode = R.DOMAINCODE AND RRS.TargetReferenceDomainCode = 'STATE' AND RRS.STATUSFLAG = 'A')RRS  
OUTER APPLY (SELECT TOP 1 * FROM ReferenceRelationShip(NOLOCK) RRS1 WHERE RRS1.SourceReferenceValueUID = RRS.TargetReferenceValueUID AND RRS1.SourceReferenceDomainCode = RRS.TargetReferenceDomainCode AND RRS1.TargetReferenceDomainCode = 'CNTRY' AND RRS1.S
TATUSFLAG = 'A')RRS1  
--Eliminated the below joins due to duplication issue  
--LEFT OUTER JOIN  
--ReferenceRelationShip(NOLOCK) RRS ON (RRS.SourceReferenceValueUID = R.UID AND RRS.SourceReferenceDomainCode = R.DOMAINCODE AND RRS.TargetReferenceDomainCode = 'STATE' AND RRS.STATUSFLAG = 'A')  
--LEFT OUTER JOIN  
--ReferenceRelationShip(NOLOCK) RRS1 ON (RRS1.SourceReferenceValueUID = RRS.TargetReferenceValueUID AND RRS1.SourceReferenceDomainCode = RRS.TargetReferenceDomainCode AND RRS1.TargetReferenceDomainCode = 'CNTRY' AND RRS1.STATUSFLAG = 'A')  
WHERE  
R.DOMAINCODE = 'CITTY'  
AND R.STATUSFLAG = 'A'  
ORDER BY 2  
for Json Path )as X  