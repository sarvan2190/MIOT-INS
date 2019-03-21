CREATE view vairpincodemapping  
as  
select  
(  
select  
PM.PinCode  code,  
PM.PinCode  name,  
(SELECT TOP 1 DBO.fGetReferenceValCode(RRS1.TargetReferenceValueUID)   
FROM  
ReferenceRelationShip(NOLOCK) RRS2,  
ReferenceRelationShip(NOLOCK) RRS1   
,REFERENCEVALUE R1  
WHERE  
RRS2.SourceReferenceValueUID = PM.CITTYUID   
--AND RRS2.SourceReferenceDomainCode = 'CITTY'   
AND RRS2.TargetReferenceDomainCode = 'STATE'   
AND RRS2.STATUSFLAG = 'A'  
AND RRS1.SourceReferenceValueUID = RRS2.TargetReferenceValueUID   
--AND RRS1.SourceReferenceDomainCode = RRS2.TargetReferenceDomainCode   
AND RRS1.TargetReferenceDomainCode = 'CNTRY'   
AND RRS1.STATUSFLAG = 'A'  
AND R1.STATUSFLAG = 'A'  
AND R1.UID = RRS1.TargetReferenceValueUID) country,  
(SELECT TOP 1 DBO.fGetReferenceguid(RRS1.TargetReferenceValueUID)   
FROM  
ReferenceRelationShip(NOLOCK) RRS2,  
ReferenceRelationShip(NOLOCK) RRS1   
,REFERENCEVALUE R1  
WHERE  
RRS2.SourceReferenceValueUID = PM.CITTYUID   
--AND RRS2.SourceReferenceDomainCode = 'CITTY'   
AND RRS2.TargetReferenceDomainCode = 'STATE'   
AND RRS2.STATUSFLAG = 'A'  
AND RRS1.SourceReferenceValueUID = RRS2.TargetReferenceValueUID   
--AND RRS1.SourceReferenceDomainCode = RRS2.TargetReferenceDomainCode   
AND RRS1.TargetReferenceDomainCode = 'CNTRY'   
AND RRS1.STATUSFLAG = 'A'  
AND R1.STATUSFLAG = 'A'  
AND R1.UID = RRS1.TargetReferenceValueUID) 'countryuid.$oid',  
null locallangname,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,GETDATE()-10) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,null) ) as bigint) * 1000  AS NVARCHAR(50)) as  'activeto.$date.$numberLong',      
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PM.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PM.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PM.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PM.mWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                             
PM.statusflag statusflag,          
'569794170946a3d0d588efe6' AS 'orguid.$oid',  
cast(PM.uid as nvarchar) externaluid,  
'pincodemapping'externaltablename  
FROM  
PINCODEMAPPING(NOLOCK) PM  
WHERE  
PM.STATUSFLAG = 'A'  
for json path  ) as x  