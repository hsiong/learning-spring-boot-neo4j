
MATCH (node:label)<-[: Relationship]-(n) 
RETURN n 

# delete all
MATCH (n) detach delete n

# 根据关系查询
MATCH (i:InstitutionEntity)-[:belong]-(p:PersonEntity)-[:exist]-(n:NeoImageEntity)
WHERE n.name="test"
RETURN p,n,i
LIMIT 50