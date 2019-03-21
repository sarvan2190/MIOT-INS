create VIEW PayorDetailguidmapping          
As          
SELECT          
(          
SELECT          
m.guid as  '_id.$oid',                                  
m.statusflag statusflag,                  
        
'Payordetail' externaltablename,          
m.uid externaluid          
          
FROM          
PayorDetail m          
      
         
for json path) as X 