CREATE VIEW vAirusersguidmapping  
As  
SELECT   
(  
SELECT   
c.guid as '_id.$oid',c.uid as orguid,c.ForeName  
  
FROM CAREPROVIDER C  
FOR JSON PATH) AS X  
  
  