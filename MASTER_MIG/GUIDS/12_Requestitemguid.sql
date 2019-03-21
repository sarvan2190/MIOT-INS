CREATE VIEW REQUESTITEMguid        
As        
SELECT        
(        
SELECT        
m.guid as  '_id.$oid',        
m.DisplyName code ,                                  
m.statusflag statusflag,                
(select top 1 guid from healthorganisation where UID=m.OwnerOrganisationUID) AS 'orguid.$oid',        
(select top 1 uid from healthorganisation where UID=m.OwnerOrganisationUID) as orgcode,        
'agemaster' externaltablename,        
m.uid externaluid        
        
FROM        
REQUESTITEM m        
--WHERE        
--PDa.STATUSFLAG = 'A'        
for json path) as X        
  
  