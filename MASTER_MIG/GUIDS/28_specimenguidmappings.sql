 CREATE view specimenguidmappings            
 AS             
 SELECT             
 (            
            
 select             
 PO.UID externaluid ,           
 PO.Code,
 po.Name       
      
 FROM             
 Specimen PO      
      

       
            
 FOR JSON PATH ) AS             
 Y 

