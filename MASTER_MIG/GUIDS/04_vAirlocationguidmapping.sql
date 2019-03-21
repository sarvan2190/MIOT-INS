CREATE VIEW vAirlocationguidmapping  
As  
SELECT   
(  
select L.guid as '_id.$oid',  
LTRIM(RTRIM(L.CODE)) code,  
L.UID AS orgid  
FROM   
LOCATION L  
FOR JSON PATH) AS X  
  