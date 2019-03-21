 CREATE view vairreferencevaluesguids        
 AS         
 SELECT         
 (        
        
 select         
 PO.UID externaluid ,       
 (SELECT top 1 uid from Healthorganisation where guid is not null ) OwnerOrganisationUID,  
 (SELECT top 1 uid from Healthorganisation where guid is not null ) orgcode      
  
 FROM         
 referencevalue PO  
  
 WHERE PO.GUID IS NULL  
   
        
 FOR JSON PATH ) AS         
 Y 