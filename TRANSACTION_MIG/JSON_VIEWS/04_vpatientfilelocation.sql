CREATE VIEW vpatientfilelocation    
as    
select (    
select     
p.pasid  as folderid,    
CASE WHEN EXISTS(SELECT 1 FROM PatientDeceasedDetail PD WHERE PD.PATIENTUID=P.UID) THEN convert(bit,'false') else convert(bit,'true') end isactive,    
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(HH,-5.30,p.registrationdttm)) as bigint) * 1000  AS NVARCHAR(50)) as 'foldercreatedat.$date.$numberLong',     
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PFL.CUSER),'5b862a913238d86bf03aa787') 'foldercreatedby.$oid',    
convert(bit,'false') folderautocreated,    
(select top 1 guid from storagelocation sl where pfl.storagelocationuid=sl.uid) as'owningmrdstorage.$oid',    
(select top 1 guid from location l where lotypuid=4583 )as 'owningdepartmentuid.$oid',    
(select top 1 guid from location l where l.uid=pfl.currentstoragelocationuid) as'currentdeptuid.$oid',    
isnull(pfl.volume,1) as volume,    
(    
SELECT    
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pf.cwhen)) as bigint) * 1000  AS NVARCHAR(50)) as 'auditdate.$date.$numberLong'     
FROM    
PATIENTFILELOCATION PF WHERE PF.UID=PFL.UID  FOR JSON PATH) as auditlog,    
p.guid as 'patientuid.$oid',    
(select top 1 guid from patientvisit where uid=visituid) as 'patientvisituid.$oid',    
(select top 1 guid from referencevalue where uid=mrdtypuid) as'foldertypeuid.$oid',    
pfl.statusflag statusflag,    
(select top 1 guid from referencevalue where uid=filstuid)'statusuid.$oid',    
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PFL.MWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'modifiedat.$date.$numberLong',     
isnull((select top 1 guid from careprovider c where c.uid=PFL.muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid',    
(SELECT TOP 1 GUID FROM HEALTHORGANISATION WHERE uid=2) as 'orguid.$oid',    
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PFL.CWHEN)) as bigint) * 1000  AS NVARCHAR(50)) as 'createdat.$date.$numberLong',     
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PFL.CUSER),'5c7659e45d836f29be36758c') as 'createdby.$oid',    
cast(PFL.UID as nvarchar) externaluid    
    
FROM PATIENTFILELOCATION PFL,    
PATIENT P     
WHERE     
PFL.PATIENTUID=P.UID ORDER BY PFL.UID DESC    
for json path ) as x    