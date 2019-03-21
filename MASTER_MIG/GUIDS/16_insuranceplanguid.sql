create VIEW insuranceplanguid          
As          
SELECT          
(          
SELECT          
m.guid as  '_id.$oid',                                  
m.statusflag statusflag,                  
        
'InsurencePlan' externaltablename,          
m.uid externaluid          
          
FROM          
INSURANCEPLAN m          
      
         
for json path) as X 