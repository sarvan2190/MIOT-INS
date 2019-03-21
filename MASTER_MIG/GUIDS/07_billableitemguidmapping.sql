CREATE VIEW billableitemguidmapping    
As    
Select    
(    
select    
s.guid as '_id.$oid',     
isnull(S.CODE,cast(s.uid as nvarchar))code,    
LTRIM(RTRIM(S.itemNAME))name,    
    
S.UID externaluid      
    
    
FROM BILLABLEITEM S     
    
  FOR JSON PATH) AS X    
  
   
    