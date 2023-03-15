
# Getting Started
## System requirements

Neo4j & JVM compatibility

| Neo4j Version | JVM compliancy                    |
| :-----------: | :-------------------------------- |
|      3.x      | Java SE 8 Platform Specificaton   |
|      4.x      | Java SE 11 Platform Specificaton  |
|      5.x      | Java SE 17 Platform Specification |

## How-To: Run Neo4j in Docker

### Run Neo4j in Docker

+ docker bash

```bash
# jvm SE 11
docker stop neo4j
docker rm neo4j
NEO4J_HOME=/home_dir
docker run \
    --name neo4j \
    -p 7474:7474 -p 7687:7687 \
    -d \
    -v $NEO4J_HOME/neo4j/data:/data \
    -v $NEO4J_HOME/neo4j/logs:/logs \
    -v $NEO4J_HOME/neo4j/import:/var/lib/neo4j/import \
    -v $NEO4J_HOME/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/password \
    --restart=always \
    neo4j:4.4.18-community
```

+ neo4j config

```bash
sudo su
cd $NEO4J_HOME/neo4j/conf
# support connect from any ip address
echo 'dbms.connectors.default_listen_address=0.0.0.0' >> neo4j.conf
# change bolt listen_address
echo 'dbms.connector.bolt.listen_address=0.0.0.0:7687' >> neo4j.conf
# change http listen_address
echo 'dbms.connector.http.listen_address=0.0.0.0:7474 ' >> neo4j.conf
cat neo4j.conf 
docker restart neo4j
```

### Verifying Execution

+ verify in terminal

```bash
docker logs neo4j
docker ps
```

+ verify in browser

If already familiar with Neo4j Browser, it works the same as with other Neo4j instances. First, ensure the database is running, then open a browser window and enter the url `server-ip:7474`

+ verify in Cypher bash

We need to first access our container.

```bash
docker exec -it neo4j bash
```

After the above command is run, we can now access Cypher bash by running the cypher-bash command, which is shown below. # Notice that we also need to specify the username (-u neo4j) and password (-p password) in order to access the database, using the authentication values we set up when we created the container.

```bash
cypher-shell -u neo4j -p password
```

Then type the Cypher command. The final command exits Cypher shell using `:exit` and returns to our bash prompt.

![docker cypher shell](https://dist.neo4j.com/wp-content/uploads/docker_cypher_shell.jpg)



# Getting started with Neo4j Browser - Cypher

## Getting started

Once you have an AuraDB database, you can use the `:play cypher` command inside of Neo4j Browser to get started.

![play cypher command](https://dist.neo4j.com/wp-content/uploads/play-cypher-command.png)

## Databases

+ Show the status of all databases

  ```cypher
  neo4j@system> SHOW DATABASES;
  ```

+ Show the status of a specific database

  ```cypher
  neo4j@system> SHOW DATABASE neo4j;
  ```

+ Show the status of the default database

  ```cypher
  neo4j@system> SHOW DEFAULT DATABASE;
  ```
+ Switch a database

  ```
  :use sales
  ```

> In Community Edition, the default database is the only database available



[enterprise edition]

+ Create a database


+ Create or replace a database
+ Stop a database
+ Start a database
+ Drop or remove a database

## Node

### Create a node 

```cypher
CREATE (ee:Person { name: "Emil", from: "Sweden", klout: 99 })
```

- `CREATE` clause to create data
- `()` parenthesis to indicate a node
- `ee:Person` a <u>variable</u> 'ee' and <u>label</u> 'Person' for the new node
- `{}` brackets to add properties to the node

### Finding nodes

```cypher
MATCH (ee:Person) WHERE ee.name = "Emil" RETURN ee;
```

- `MATCH` clause to specify a pattern of nodes and relationships
- `(ee:Person)` a single node pattern with label 'Person' which will assign matches to the variable 'ee'
- `WHERE` clause to constrain the results
- `ee.name = "Emil"` compares name property to the value "Emil"
- `RETURN` clause used to request particular results

### Create more Nodes and relationships

```cypher
MATCH (ee:Person) WHERE ee.name = "Emil"
CREATE (js:Person { name: "Johan", from: "Sweden", learn: "surfing" }),
(ir:Person { name: "Ian", from: "England", title: "author" }),
(rvb:Person { name: "Rik", from: "Belgium", pet: "Orval" }),
(ally:Person { name: "Allison", from: "California", hobby: "surfing" }),
(ee)-[:KNOWS {since: 2001}]->(js),(ee)-[:KNOWS {rating: 5}]->(ir),
(js)-[:KNOWS]->(ir),(js)-[:KNOWS]->(rvb),
(ir)-[:KNOWS]->(js),(ir)-[:KNOWS]->(ally),
(rvb)-[:KNOWS]->(ally)
```

+ `[]`: relationship
+ `:KNOWS`: relationship-lable
+ :KNOWS `{rating: 5}`:relationship-lable's property

### Pattern matching

```cypher
MATCH (js:Person)-[:KNOWS]-()-[:KNOWS]-(surfer)
WHERE js.name = "Johan" AND surfer.hobby = "surfing"
RETURN DISTINCT surfer
```

+ `surfer`: a common node
+ `()`: result



# Java Driver - Spring Data Neo4j

## Getting Started

For Java developers who use the Spring Framework or Spring Boot and want to take advantage of reactive development principles, this guide introduces Spring integration through the Spring Data Neo4j project. The library provides convenient access to Neo4j including object mapping, Spring Data repositories, conversion, transaction handling, reactive support, and more.

+ Maven configuration

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-data-neo4j</artifactId>
</dependency>
```

+ configure your database connection

```yaml
spring: 
  neo4j:
    uri: bolt://server-ip:7687
    username: neo4j
    password: secret
```

## Create your domain

### Example Node-Entity

```java
// `@Node`: is used to mark this class as a managed entity. It also is used to configure the Neo4j label. The label defaults to the name of the class, if you’re just using plain `@Node`.
@Node("Movie") 
public class MovieEntity {

  // `@Id`: Each entity has to have an id. The movie class shown here uses the attribute `title` as a unique business key. If you don’t have such a unique key, you can use the combination of `@Id` and `@GeneratedValue` to configure SDN to use Neo4j’s internal id. We also provide generators for UUIDs.
	@Id 
	private final String title;

  // `@Property`: `@Property` as a way to use a different name for the field than for the graph property.
	@Property("tagline") 
	private final String description;

	@Relationship(type = "ACTED_IN", direction = Direction.INCOMING) 
	private List<Roles> actorsAndRoles;

  // `Relationship`: This defines a relationship to a class of type `PersonEntity` and the relationship type `ACTED_IN`
	@Relationship(type = "DIRECTED", direction = Direction.INCOMING)
	private List<PersonEntity> directors = new ArrayList<>();

  // This is the constructor to be used by your application code
	public MovieEntity(String title, String description) { 
		this.title = title;
		this.description = description;
	}

	// Getters omitted for brevity
}
```



# Refence & Thanks

+ [Getting Started with Neo4j](https://neo4j.com/developer/get-started/)
+ [How-To: Run Neo4j in Docker](https://neo4j.com/developer/docker-run-neo4j/)
+ [Neo4j System requirements](https://neo4j.com/docs/operations-manual/current/installation/requirements/)
+ [Docker 安装部署 neo4j](https://blog.csdn.net/weixin_44037416/article/details/125560775)
+ [Neo4j Github Repo](https://github.com/spring-projects/spring-data-neo4j)
+ [Spring Data Neo4j Guide](https://docs.spring.io/spring-data/neo4j/docs/current/reference/html/)
+ [Neo4j Database Manager](https://neo4j.com/docs/operations-manual/4.0/)
+ [Graph Visualization](https://neo4j.com/developer/graph-visualization/)
+ 

