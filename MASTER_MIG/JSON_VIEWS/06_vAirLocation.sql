CREATE VIEW vAirLocation  
As  
Select  
(  
select  
s.guid as '_id.$oid',   
isnull(S.CODE,cast(s.uid as nvarchar))code,  
LTRIM(RTRIM(S.NAME))name,  
LTRIM(RTRIM(S.NAME))description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,s.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HH,-5.30,s.ACTIVETO)) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',     
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=s.CUSER),'5b862a913238d86bf03aa787') AS 'createdby.$oid',    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,s.CWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
(SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=s.MUSER) AS 'modifiedby.$oid',          
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,s.MWHEN )) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong',    
  
dbo.fGetReferenceValueguid(SETYPUID)as'loctypuid.$oid',  
(SELECT TOP 1 S1.GUID FROM SERVICE S1 WHERE S1.UID=S.PARENTSERVICEUID AND S1.STATUSFLAG='A')'parentlocuid.$oid',  
S.DISPLAYORDER displayorder,  
null directions,  
null phone,  
null photourl,  
(SELECT TOP 1 l.guid FROM ServiceLocation SL,LOCATION L where sl.ServiceUID=s.uid and sl.StatusFlag='A'  
and l.uid=sl.locationuid and l.statusflag='A') 'owningdeptuid.$oid',  
S.STATUSFLAG statusflag,  
S.UID externaluid,       
(select top 1 guid from healthorganisation where uid=s.OwnerOrganisationUID) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=s.OwnerOrganisationUID) as orgcode  
  
FROM SERVICE S   
WHERE   
--sTATUSFLAG='A'  
 DBO.FGETREFERENCEVALCODE(SETYPUID) in('CLNIC','THETR','LAABB','WARDD','APPTSR','DEPART','NURST','EMWARD')  
  FOR JSON PATH) AS X  
  
  