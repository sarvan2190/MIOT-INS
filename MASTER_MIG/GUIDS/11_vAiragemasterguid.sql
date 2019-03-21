CREATE VIEW vAiragemasterguid      
As      
SELECT      
(      
SELECT      
m.guid as  '_id.$oid',      
m.Name code ,                                
m.statusflag statusflag,              
(select top 1 guid from healthorganisation where UID=2) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where UID=2) as orgcode,      
'agemaster' externaltablename,      
m.uid externaluid      
      
FROM      
AgeMaster m      
--WHERE      
--PDa.STATUSFLAG = 'A'      
for json path) as X      
    
  