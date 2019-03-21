  
CREATE VIEW roleguidmapping  
As  
SELECT   
(  
SELECT   
c.guid as '_id.$oid',c.uid as externaluid,c.code  
  
FROM Role C  
FOR JSON PATH) AS X  
  

  