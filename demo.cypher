
MATCH (node:label)<-[: Relationship]-(n) 
RETURN n 

# query

## query by condition
MATCH (i:InstitutionEntity)-[:belong]-(p:PersonEntity)-[:exist]-(n:NeoImageEntity)
WHERE n.name="test"
RETURN p,n,i
LIMIT 50

## query by list
MATCH (ee:NeoImageEntity) WHERE e.name IN ["name"] RETURN ee;

## query by ID list
MATCH (ee:NeoImageEntity) WHERE ID(ee) IN [8,10,11,12] RETURN ee;

## count
MATCH (ee:NeoImageEntity) RETURN count(ee) as cnt;
MATCH (ee:NeoImageEntity) WHERE e.name IN ["name"] RETURN count(ee) as cnt;

## query by multiple relationships
match (gal:Person{name:"Yoav"})-[:liked|:watched|:other]->(movie:Movie) 
return movie

match (Yoav:Person{name:"Yoav"})-[:liked]->(movie:Movie),
(Yoav)-[:watched]->(movie),
(Yoav)-[:other]->(movie)
return movie

## fuzzy match 
### contains
MATCH (n:Person)
WHERE n.name CONTAINS 'ete'
RETURN n.name, n.age

### regular fuzzy match
MATCH (n:Person)
WHERE n.name =~ 'Tim.*'
RETURN n.name, n.age

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

