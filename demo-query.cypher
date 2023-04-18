
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

## with match different relationship
MATCH (i:InstitutionEntity)-[:liked]-(p:PersonEntity)-[:liked2]-(n:NeoImageEntity)-[:liked3]-(v:ViolationEntity) 
WITH p,n,v,i MATCH (n:NeoImageEntity)-[:liked4]-(o:OriNeoImageEntity)
RETURN p,n,v,i,o
LIMIT 20

## There are two PersonEntities in this situation, but why can i only query one PersonEntity with `MATCH (i:InstitutionEntity)-[:liked]-(p:PersonEntity)-[:liked2]-(n:NeoImageEntity)-[:liked3]-(v:ViolationEntity) 
                                                                                                   WITH p,n,v,i MATCH (n:NeoImageEntity)-[:liked4]-(o:OriNeoImageEntity)
                                                                                                   RETURN p,n,v,i,o
                                                                                                   LIMIT 20`
## Beause you don't use `order by`, if you do not use `order by`, neo4j will sort randomly before return `limit` result
## https://blog.csdn.net/u010801439/article/details/77568531
MATCH (i:InstitutionEntity)-[:liked]-(p:PersonEntity)-[:liked2]-(n:NeoImageEntity)-[:liked3]-(v:ViolationEntity) 
WITH p,n,v,i MATCH (n:NeoImageEntity)-[:liked4]-(o:OriNeoImageEntity)
RETURN p,n,v,i,o
ORDER BY n.image DESC
LIMIT 20 

## group by 