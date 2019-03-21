CREATE VIEW vAiritemmasterguid  
As  
SELECT  
(  
SELECT  
m.guid as  '_id.$oid',  
m.CODE code ,                            
m.statusflag statusflag,          
(select top 1 guid from healthorganisation where guid is not null) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where guid is not null) as orgcode,  
'itemmaster' externaltablename,  
m.uid externaluid  
  
FROM  
itemmaster m  
--WHERE  
--PDa.STATUSFLAG = 'A'  
for json path) as X  
  
  
  