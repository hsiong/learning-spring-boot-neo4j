
# delete all
MATCH (n) DETACH DELETE n

## delete by condition
MATCH (ee:NeoImageEntity) WHERE ee.name='name' DETACH DELETE ee;

## delete by ID list
MATCH (ee:NeoImageEntity) WHERE ID(ee) IN [8,10,11,12] DETACH DELETE ee;

## delete by relation value
MATCH (i:InstitutionEntity)-[:belong]-(p:PersonEntity)-[:exist]-(n:NeoImageEntity)
WHERE i.name="name" AND ID(n) NOT IN [1, 2, 3]
RETURN i, p, n;

MATCH (i:InstitutionEntity)-[:belong]-(p:PersonEntity)-[:exist]-(n:NeoImageEntity)
WHERE i.name="name" AND ID(n) NOT IN [1, 2, 3]
DETACH DELETE ee

