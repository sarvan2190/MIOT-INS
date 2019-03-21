CREATE VIEW vAirbillpackageitemguid    
As    
SELECT    
(    
SELECT    
m.guid as  '_id.$oid',                            
m.statusflag statusflag,            
  
'billableitem' externaltablename,    
m.uid externaluid    
    
FROM    
billpackageitem m    
WHERE    
m.guid is null    
for json path) as X    
    
    