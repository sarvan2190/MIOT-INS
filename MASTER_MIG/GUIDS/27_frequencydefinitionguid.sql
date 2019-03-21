 CREATE view frequencydefinitionguid            
 AS             
 SELECT             
 (            
            
 select             
 PO.UID externaluid ,           
 PO.Code,
 po.Name       
      
 FROM             
 FrequencyDefinition PO      
      

       
            
 FOR JSON PATH ) AS             
 Y 