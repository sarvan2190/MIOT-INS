 CREATE view Patientguidmapping        
 AS           
 SELECT           
 (          
          
 select           
 PO.UID externaluid ,         
 PO.forename      
    
 FROM           
 patient PO    
    
 WHERE PO.GUID IS NULL    
     
          
 FOR JSON PATH ) AS           
 Y   