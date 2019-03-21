CREATE VIEW vAirSTOREmasterguid    
As    
SELECT    
(    
SELECT    
m.guid as  '_id.$oid',    
m.CODE code ,                              
m.statusflag statusflag,            
(select top 1 guid from healthorganisation where UID=2) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where UID=2) as orgcode,    
'itemmaster' externaltablename,    
m.uid externaluid    
    
FROM    
STORE m    
--WHERE    
--PDa.STATUSFLAG = 'A'    
for json path) as X    
  