CREATE VIEW vairprocedurelist  
As  
Select  
(  
Select   
distinct   
pl.guid as '_id.$oid',  
PL.ProcedureCode  code ,  
LTRIM(RTRIM(PL.ProcedureName)) name ,  
LTRIM(RTRIM(PL.ProcedureDesc))description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', getdate() ) as bigint) * 1000  AS NVARCHAR(50)) as  'activefrom.$date.$numberLong',      
null activeto,  
null locallangdesc ,  
'56ded114859934d87173c236' 'codingschemeuid.$oid' ,--icd9  
DBO.fGetReferenceGuid(PL.SURTPUID) 'planningtypeuid.$oid' ,  
null criticalityuid ,  
DBO.fGetReferenceGuid(PL.ANEASUID) 'anaesthesiauid.$oid' ,  
DBO.fGetReferenceGuid(PL.BODSTUID) 'bodysiteuid.$oid' ,  
DBO.fGetReferenceGuid(PL.LATLTYUID) 'lateralityuid.$oid' ,  
PL.STANDARDDURATION standardduration,  
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PL.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PL.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',                          
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PL.MUSER) ,'5c7659e45d836f29be36758c')AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PL.MWHEN)) as bigint) * 1000  AS NVARCHAR(50))as 'modifiedat.$date.$numberLong',  
PL.statusflag statusflag,          
'569794170946a3d0d588efe6' AS 'orguid.$oid',-- Parentorganisationuid  
'ProcedureList' externaltablename,  
CAST(pl.uid AS nvarchar) externaluid   
FROM  
ProcedureList(NOLOCK) PL  
LEFT OUTER JOIN PROCEDURECODE(NOLOCK) PP ON (PL.UID = PP.ProcedureUID AND PP.STATUSFLAG = 'A')  
WHERE  
PL.StatusFlag ='A'  
for json path) AS X  
  
  
  
  
  
  