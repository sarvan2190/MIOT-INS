CREATE view  vairpatientimage          
AS               
SELECT (              
select              
PIMG.GUID '_id.$oid' ,          
REPLACE(RTRIM(LTRIM(PIMG.imagejson)),'"','') patientphoto,           
dbo.fGetPatientName(Patientuid) as comments,    
PIMG.statusflag as statusflag ,                                      
ISNULL(dbo.fgetcareproviderguid( PIMG.Cuser) ,'5c7659e45d836f29be36758c')  AS  'createdby.$oid',                                               
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PIMG.Cwhen )) as bigint) * 1000  AS NVARCHAR(50))    'createdat.$date.$numberLong'  ,                                          
ISNULL(dbo.fgetcareproviderguid(PIMG. MUser) ,'5c7659e45d836f29be36758c')  AS  'modifiedby.$oid',                                          
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PIMG.MWhen )) as bigint) * 1000  AS NVARCHAR(50))   'modifiedat.$date.$numberLong',                  
(SELECT  top 1 guid from HealthOrganisation where uid=2 ) 'orguid.$oid',              
PIMG.Ownerorganisationuid ,              
cast(PIMG.UID  as nvarchar) externaluid,              
cast(PAT.UID as nvarchar) externalpatientuid,              
PAT.guid 'patientuid.$oid'              
              
from patientimage PIMG              
LEFT JOIN Patient PAT ON PIMG.Patientuid =PAT.UID           
for json PATH               
) AS Y    
    