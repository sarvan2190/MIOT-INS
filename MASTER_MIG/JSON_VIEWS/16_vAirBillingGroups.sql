CREATE VIEW vAirBillingGroups    
As    
SELECT     
(    
SELECT      
S.GUID AS '_id.$oid',    
S.code code,    
LTRIM(RTRIM(S.NAME )) name,    
LTRIM(RTRIM(S.DESCRIPTION ))description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', s.activefrom ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', s.activeto ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
null allowpriceoverride,    
'false' allowspecialdiscount,    
convert(bit,'true') allowsplitting,    
null chargegroupcodeuid,    
s.DisplayOrder displayorder,    
convert(bit,'false') issubgroup,    
CASE WHEN S.NAME <> S.DESCRIPTION THEN S.DESCRIPTION ELSE '' END locallangdesc,    
null parentgroup,    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=S.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,S.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=S.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,S.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',                          
s.STATUSFLAG statusflag,            
(select top 1 guid from healthorganisation where uid=s.OwnerOrganisationUID) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=s.OwnerOrganisationUID) as orgcode,    
'service' externaltablename,    
'5c763c315d836f29be35638e' 'billinggrouptypeuid.$oid',    
S.uid externaluid    
    
FROM    
SERVICE S    
WHERE    
S.SETYPUID IN (DBO.FGETREFERENCEVALUEUID('LCCTR','SPTYP'))     
FOR JSON PATH) AS x    
    