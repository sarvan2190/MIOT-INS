CREATE view vairState  
as  
select  
(  
select  
r.guid as '_id.$oid',  
r.valuecode code,  
r.description name,  
CASE WHEN r.Description <> r.ALTERNATENAME THEN r.ALTERNATENAME ELSE '' END locallangname,  
DBO.fGetReferenceguid(RRS.TargetReferenceValueUID)  'countryuid.$oid',  
DBO.fGetrfvaldescription(RRS.TargetReferenceValueUID)  country,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,r.activefrom) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,r.activeto) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',      
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=R.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,R.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=R.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,R.mWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                             
R.statusflag statusflag,          
'569794170946a3d0d588efe6' AS 'orguid.$oid',  
CAST(r.uid AS nvarchar) externaluid,  
'referencevalue'externaltablename  
  
FROM  
REFERENCEVALUE R  
LEFT OUTER JOIN  
ReferenceRelationShip RRS ON (RRS.SourceReferenceValueUID = R.UID AND RRS.SourceReferenceDomainCode = R.DOMAINCODE AND RRS.TargetReferenceDomainCode = 'CNTRY' AND RRS.STATUSFLAG = 'A')  
join referencevalue r1 on (r1.uid = rrs.TargetReferenceValueUID and r1.StatusFlag = 'a')  
WHERE  
R.DOMAINCODE = 'STATE'  
AND R.STATUSFLAG = 'A'  
for Json Path )as X