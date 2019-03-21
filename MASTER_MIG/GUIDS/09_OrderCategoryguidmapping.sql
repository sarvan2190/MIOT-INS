CREATE VIEW OrderCategoryguidmapping      
As      
Select      
(      
select      
s.guid as '_id.$oid',       
isnull(S.CODE,cast(s.uid as nvarchar))code,      
LTRIM(RTRIM(S.NAME))name,      
      
S.UID externaluid        
      
      
FROM OrderCategory S       
      
  FOR JSON PATH) AS X      
    
  
     