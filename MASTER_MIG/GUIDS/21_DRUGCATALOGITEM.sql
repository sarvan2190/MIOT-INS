CREATE VIEW DRUGCATALOGITEMguid    
As    
SELECT    
(    
SELECT    
m.guid as  '_id.$oid',    
m.CODE code ,                              
m.statusflag statusflag,            
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where uid=2) as orgcode,    
'drugcatalogitem' externaltablename,    
m.uid externaluid    
    
FROM    
DRUGCATALOGITEM m    
for json path) as X    
    
    