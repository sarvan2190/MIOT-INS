 CREATE view patientimageguids          
 AS           
 SELECT           
 (          
          
 select           
 PO.UID externaluid ,         
 PO.PatientUID      
    
 FROM           
 patientimage PO    
    
 WHERE PO.GUID IS NULL    
     
          
 FOR JSON PATH ) AS           
 Y 