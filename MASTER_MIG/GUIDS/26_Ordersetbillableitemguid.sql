 CREATE view Ordersetbillableitemguid            
 AS             
 SELECT             
 (            
            
 select             
 PO.UID externaluid ,           
 PO.BillableItemUID       
      
 FROM             
 Ordersetbillableitem PO      
      
   
       
            
 FOR JSON PATH ) AS             
 Y 