 CREATE view Patientvisitguidmapping          
 AS             
 SELECT             
 (            
            
 select             
 PO.UID externaluid ,           
 PO.PatientUID        
      
 FROM             
 patientvisit PO      
      
     
       
            
 FOR JSON PATH ) AS             
 Y     
  