CREATE VIEW vAirmanufacturerdetailguid  
As  
SELECT  
(  
SELECT  
m.guid as  '_id.$oid',  
m.CODE code ,                            
m.statusflag statusflag,          
(select top 1 guid from healthorganisation where uid=m.OwnerOrganisationUID) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=m.OwnerOrganisationUID) as orgcode,  
'manufacturerdetail' externaltablename,  
m.uid externaluid  
  
FROM  
manufacturerdetail m  
for json path) as X  
  
  
  