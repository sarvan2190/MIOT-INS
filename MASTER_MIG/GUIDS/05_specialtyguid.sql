 CREATE view specialtyguid          
 AS           
 SELECT           
 (          
          
 select           
 PO.UID externaluid,      
 PO.name   
 FROM           
 Speciality PO    