create VIEW vaircchpimasterguid          
As          
SELECT          
(          
SELECT          
m.guid as  '_id.$oid',                                  
m.statusflag statusflag,                  
        
'PayorAgreement' externaltablename,          
m.uid externaluid          
          
FROM          
CCHPIMaster m          
      
         
for json path) as X 