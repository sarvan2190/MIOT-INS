CREATE VIEW  vAirSpecimenMaster    
As    
SELECT    
(    
SELECT     
sp.guid as '_id.$oid',    
LTRIM(RTRIM(SP.CODE))code,    
LTRIM(RTRIM(SP.NAME)) name,    
LTRIM(RTRIM(SP.NAME)) description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', getdate()-10 ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', null ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',       
convert(bit,'true')canconsolidate,    
convert(bit,'false')istimedcollection,    
convert(bit,'1') nooftimes,    
(select top 1 guid from ReferenceValue where uid=SPMTPUID)'specimentypeuid.$oid',    
null volumeuom,    
(select top 1 guid from ReferenceValue where uid=CONTAINERUID)'containertypeuid.$oid',    
(select top 1 guid from ReferenceValue where uid=BODSTUID)'bodysiteuid.$oid',    
(select top 1 guid from ReferenceValue where uid=COLMDUID)'collectionmethoduid.$oid',    
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=SP.CUSER) AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', SP.CWHEN ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=SP.MUSER) AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', SP.MWHEN ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                              
SP.statusflag statusflag,            
(select top 1 guid from healthorganisation where uid=SP.OwnerOrganisationUID) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=SP.OwnerOrganisationUID) as orgcode,    
'specimen' externaltablename,    
sp.uid externaluid    
FROM SPECIMEN SP    
FOR JSON PATH) AS X    
  
  
  
    
    