CREATE VIEW vAirBillingSubGroups    
As    
SELECT     
(    
SELECT      
S.GUID AS '_id.$oid',    
(CASE WHEN S.UID IN (SELECT S.UID FROM    
SERVICE(NOLOCK) S    
WHERE    
S.STATUSFLAG = 'A'    
AND S.SETYPUID IN (DBO.FGETREFERENCEVALUEUID('DePT','SPTYP'))    
AND S.CODE IN (SELECT  S1.CODE FROM SERVICE S1 WHERE S1.SETYPUID = 1711 AND S1.STATUSFLAG = 'A' GROUP BY S1.CODE HAVING COUNT(*) >1))      
THEN  (SELECT S.CODE+'_'+CAST(UID AS nvarchar) FROM SERVICE S1 WHERE S1.STATUSFLAG = 'A' AND S1.UID = S.UID)    
ELSE (SELECT S.CODE FROM SERVICE S2 WHERE S2.STATUSFLAG = 'A' AND S2.UID = S.UID) END)code,    
LTRIM(RTRIM(S.NAME)) name,    
LTRIM(RTRIM(S.DESCRIPTION)) description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', ActiveFrom ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', ActiveTo) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
null allowpriceoverride,    
null accountcode,    
convert(bit,'true') allowspecialdiscount,    
convert(bit,'true') allowsplitting,    
null chargegroupcodeuid,    
s.DisplayOrder displayorder,    
convert(bit,'true') issubgroup,    
CASE WHEN S.NAME <> S.DESCRIPTION THEN S.DESCRIPTION ELSE '' END locallangdesc,    
(SELECT S1.GUID FROM SERVICE(NOLOCK) S1 WHERE S1.STATUSFLAG = 'A' AND S1.UID = S.PARENTSERVICEUID) 'parentgroup.$oid',    
(SELECT S1.CODE FROM SERVICE(NOLOCK) S1 WHERE S1.STATUSFLAG = 'A' AND S1.UID = S.PARENTSERVICEUID)  'parentgroupcode',    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=S.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,S.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=S.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,S.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',                        
s.STATUSFLAG statusflag,            
(select top 1 guid from healthorganisation where uid=s.HealthOrganisationUID) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=s.HealthOrganisationUID) as orgcode,    
'service' externaltablename,    
 '5c763c315d836f29be355fa4' 'billinggrouptypeuid.$oid',    
cast(S.uid as nvarchar) externaluid    
    
FROM    
SERVICE S    
WHERE    
S.SETYPUID IN (DBO.FGETREFERENCEVALUEUID('DePT','SPTYP'))  
   
FOR JSON PATH) AS x    
    