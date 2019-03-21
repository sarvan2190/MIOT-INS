CREATE VIEW vAirLocationservice    
As    
Select    
(    
select    
s.guid as '_id.$oid',     
isnull(S.CODE,cast(s.uid as nvarchar))code,    
LTRIM(RTRIM(S.NAME))name,    
LTRIM(RTRIM(S.NAME))description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,s.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',        
NULL 'activeto.$date.$numberLong',       
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=s.CUSER),'5c000297a5d2c09fffeadf8e') AS 'createdby.$oid',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,s.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=s.MUSER) AS 'modifiedby.$oid',            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,s.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',      
(select top 1 guid from referencevalue rf where rf.uid=s.LOTYPUID)   'loctypuid.$oid',    
(SELECT TOP 1 S1.GUID FROM SERVICE S1 WHERE S1.UID=S.PARENTLOCATIONUID AND S1.STATUSFLAG='A')'parentlocuid.$oid',    
S.DISPLAYORDER displayorder,    
null directions,    
null phone,    
null photourl,    
(SELECT TOP 1 l.guid FROM ServiceLocation SL,LOCATION L where sl.ServiceUID=s.uid and sl.StatusFlag='A'    
and l.uid=sl.locationuid and l.statusflag='A') 'owningdeptuid.$oid',    
S.STATUSFLAG statusflag,    
cast(S.UID as nvarchar) externaluid,         
(select top 1 guid from healthorganisation where uid=s.OwnerOrganisationUID) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=s.OwnerOrganisationUID) as orgcode    
    
FROM LOCATION S     
WHERE     
--sTATUSFLAG='A'    
 DBO.FGETREFERENCEVALCODE(LOTYPUID) in('WARRD','BEEDD','ROOOM','EMWARRD')    
  FOR JSON PATH) AS X    
    