
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
docker stop neo4j-community
docker rm neo4j-community
NEO4J_HOME=/home_dir
docker run \
    --name neo4j-community \
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
NEO4J_HOME=/home/videoai/docker/neo4j
cd $NEO4J_HOME/conf
# support connect from any ip address
echo 'dbms.connectors.default_listen_address=0.0.0.0' >> neo4j.conf
# change bolt listen_address
echo 'dbms.connector.bolt.listen_address=0.0.0.0:7687' >> neo4j.conf
# change http listen_address
echo 'dbms.connector.http.listen_address=0.0.0.0:7474 ' >> neo4j.conf
cat neo4j.conf 
docker restart neo4j-community
```

> Chinese version:
>
> ```bash
> docker stop neo4j
> docker rm neo4j
> docker run \
> 	--publish=7474:7474 \
> 	--publish=7687:7687 \
>   -d \
> 	--restart=always \
> 	--name neo4j \
> 	neo4jchina/neo4j-chs:4.2.1
> ```


#### error:
+ Neo.ClientError.Security.Unauthorized: The client is unauthorized due to authentication failure.






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

### Save Image(Chinese Version)

```cypher
WITH 'http://we-yun.com/image/' AS url
CREATE
    (张帜:人员 {名称:"张帜", image:url+'作者/张帜.jpg'}),
    (苏亮:人员 {名称:"苏亮", image:url+'作者/苏亮.jpg'}),
    (赵炳:人员 {名称:"赵炳", image:url+'作者/赵炳.jpg'}),
    (李敏:人员 {名称:"李敏", image:url+'作者/李敏.jpg'}),
    (庞国明:人员 {名称:"庞国明", image:url+'作者/庞国明.jpg'}),
    (胡佳辉:人员 {名称:"胡佳辉", image:url+'作者/胡佳辉.jpg'}),
    (陈振宇:人员 {名称:"陈振宇", image:url+'作者/陈振宇.jpg'}),
    (高兴宇:人员 {名称:"高兴宇", image:url+'作者/高兴宇.jpg'}),
    (薛述强:人员 {名称:"薛述强", image:url+'作者/薛述强.jpg'}),
    (董琴洁:人员 {名称:"董琴洁", image:url+'作者/董琴洁.jpg'}),
    (中科院:大学 {名称:'中科院', image:url+'大学/中科院.jpg'}),
    (北体大:大学 {名称:"北体大", image:url+'大学/北体大.jpg'}),
    (国防科大:大学 {名称:'国防科大', image:url+'大学/国防科大.jpg'}),
    (枣庄学院:大学 {名称:"枣庄学院", image:url+'大学/枣庄学院.jpg'}),
    (西安交大:大学 {名称:"西安交大", image:url+'大学/西安交大.jpg'}),
    (北京邮大:大学 {名称:"北京邮大", image:url+'大学/北京邮大.jpg'}),
    (西南交大:大学 {名称:"西南交大", image:url+'大学/西南交大.jpg'}),
    (权威指南:著作 {名称:'权威指南', image:url+'著作/著作.jpg'}),
    (张帜)-[:毕业于]->(国防科大),
    (苏亮)-[:毕业于]->(国防科大),
    (赵炳)-[:毕业于]->(北京邮大),
    (李敏)-[:毕业于]->(中科院),
    (庞国明)-[:毕业于]->(枣庄学院),
    (胡佳辉)-[:毕业于]->(西南交大),
    (陈振宇)-[:毕业于]->(中科院),
    (高兴宇)-[:毕业于]->(中科院),
    (薛述强)-[:毕业于]->(西安交大),
    (董琴洁)-[:毕业于]->(北体大),
    (张帜)-[:主编]->(权威指南),
    (苏亮)-[:副主编]->(权威指南),
    (庞国明)-[:副主编]->(权威指南),
    (胡佳辉)-[:副主编]->(权威指南),
    (赵炳)-[:作者]->(权威指南),
    (李敏)-[:作者]->(权威指南),
    (陈振宇)-[:作者]->(权威指南),
    (高兴宇)-[:作者]->(权威指南),
    (薛述强)-[:作者]->(权威指南),
    (董琴洁)-[:作者]->(权威指南)
RETURN *;
```



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

Property style:

```properties
and configure your database connection:

spring.neo4j.uri=bolt://localhost:7687
spring.neo4j.authentication.username=neo4j
spring.neo4j.authentication.password=secret
```

yaml style:

```yaml
spring: 
  neo4j:
    uri: bolt://server-ip:7688
    authentication: 
      username: neo4j
      password: password
    database: neo4j
```



## Create A Node

### Example Node-Entity

```java
import org.springframework.data.neo4j.core.schema.Relationship.Direction;

// `@Node`: is used to mark this class as a managed entity. It also is used to configure the Neo4j label. The label defaults to the name of the class, if you’re just using plain `@Node`.
@Node("Movie") 
public class MovieEntity {

  // `@Id`: Each entity has to have an id
  // If you don’t have such a unique key, you can use the combination of `@Id` and `@GeneratedValue` to configure SDN to use Neo4j’s internal id. On an attribute of type long or Long, @Id can be used with @GeneratedValue
  // We also provide generators for UUIDs.
	@Id 
  @GeneratedValue
	private Long id;

  // `@Property`: `@Property` as a way to use a different name for the field than for the graph property.
	@Property("tagline") 
	private String description;

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



### Map relationship properties

Neo4j supports defining properties not only on nodes but also on relationships. To express those properties in the model SDN provides `@RelationshipProperties` to be applied on a simple Java class. Within the properties class there have to be exactly one field marked as `@TargetNode` to define the entity the relationship points towards. Or, in an `INCOMING` relationship context, is coming from.

A relationship property class and its usage may look like this:

```java
@RelationshipProperties
public class Roles {

	@RelationshipId
	private Long id;

	private final List<String> roles;

	@TargetNode
	private final PersonEntity person;

	public Roles(PersonEntity person, List<String> roles) {
		this.person = person;
		this.roles = roles;
	}

	public List<String> getRoles() {
		return roles;
	}
}
```



## Working with Spring Data Repositories

This chapter explains the core concepts and interfaces of Spring Data repositories. It uses the configuration and code samples for the Jakarta Persistence API (JPA) module.

### Core concepts

#### CrudRepository

The central interface in the Spring Data repository abstraction is `Repository`. The [`CrudRepository`](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/repository/CrudRepository.html) and [`ListCrudRepository`](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/repository/ListCrudRepository.html) interfaces provide sophisticated CRUD functionality for the entity class that is being managed.

```java
public interface CrudRepository<T, ID> extends Repository<T, ID> {

  <S extends T> S save(S entity);      

  Optional<T> findById(ID primaryKey); 

  Iterable<T> findAll();               

  long count();                        

  void delete(T entity);               

  boolean existsById(ID primaryKey);   

  // … more functionality omitted.
}
```



In addition to query methods, query derivation for both count and delete queries is available. The following list shows the interface definition for a derived count query:

Example 15. Derived Count Query

```java
interface UserRepository extends CrudRepository<User, Long> {

  long countByLastname(String lastname);
}
```



The following listing shows the interface definition for a derived delete query:

Example 16. Derived Delete Query

```java
interface UserRepository extends CrudRepository<User, Long> {

  long deleteByLastname(String lastname);

  List<User> removeByLastname(String lastname);
}
```



`ListCrudRepository` offers equivalent methods, but they return `List` where the `CrudRepository` methods return an `Iterable`.

#### PagingAndSortingRepository

[`PagingAndSortingRepository`](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/repository/PagingAndSortingRepository.html) abstraction that adds additional methods to ease paginated access to entities:

```java
public interface PagingAndSortingRepository<T, ID>  {

  Iterable<T> findAll(Sort sort);

  Page<T> findAll(Pageable pageable);
}
```

To access the second page of `User` by a page size of 20, you could do something like the following:

```java
PagingAndSortingRepository<User, Long> repository = // … get access to a bean
Page<User> users = repository.findAll(PageRequest.of(1, 20));
```

## From Spring Data commons

- `@org.springframework.data.annotation.Id` same as `@Id` from SDN, in fact, `@Id` is annotated with Spring Data Common’s Id-annotation.
- `@CreatedBy`: Applied at the field level to indicate the creator of a node.
- `@CreatedDate`: Applied at the field level to indicate the creation date of a node.
- `@LastModifiedBy`: Applied at the field level to indicate the author of the last change to a node.
- `@LastModifiedDate`: Applied at the field level to indicate the last modification date of a node.
- `@PersistenceCreator`: Applied at one constructor to mark it as the preferred constructor when reading entities.
- `@Persistent`: Applied at the class level to indicate this class is a candidate for mapping to the database.
- `@Version`: Applied at field level it is used for optimistic locking and checked for modification on save operations. The initial value is zero which is bumped automatically on every update.
- `@ReadOnlyProperty`: Applied at field level to mark a property as read only. The property will be hydrated during database reads, but not be subject to writes. When used on relationships be aware that no related entity in that collection will be persisted if not related otherwise.

Have a look at [Chapter 13](https://docs.spring.io/spring-data/neo4j/docs/current/reference/html/#auditing) for all annotations regarding auditing support.



# Refence & Thanks

+ [Getting Started with Neo4j](https://neo4j.com/developer/get-started/)
+ [How-To: Run Neo4j in Docker](https://neo4j.com/developer/docker-run-neo4j/)
+ [Neo4j System requirements](https://neo4j.com/docs/operations-manual/current/installation/requirements/)
+ [Docker 安装部署 neo4j](https://blog.csdn.net/weixin_44037416/article/details/125560775)
+ [Neo4j Github Repo](https://github.com/spring-projects/spring-data-neo4j)
+ [Spring Data Neo4j Guide](https://docs.spring.io/spring-data/neo4j/docs/current/reference/html/)
+ [Neo4j Database Manager](https://neo4j.com/docs/operations-manual/4.0/)
+ [Graph Visualization](https://neo4j.com/developer/graph-visualization/)
+ [微云数聚（北京）科技有限公司-Neo4j 5.x 简体中文版指南](https://we-yun.com/doc/neo4j-chs-doc/#_%E8%8A%82%E7%82%B9%E7%9A%84%E5%9B%BE%E7%89%87%E5%B1%9E%E6%80%A7)
+ https://www.zhihu.com/question/264616413
+ https://www.google.com/search?q=java+%E6%9E%84%E5%BB%BA%E7%9F%A5%E8%AF%86%E5%9B%BE%E8%B0%B1&oq=java+%E6%9E%84%E5%BB%BA%E7%9F%A5%E8%AF%86%E5%9B%BE%E8%B0%B1&aqs=chrome..69i57j0i546l3j69i60j69i61l2.253j0j7&sourceid=chrome&ie=UTF-8
+ https://www.w3cschool.cn/neo4j/neo4j_need_for_graph_databses.html
+ [Neo4j数据库知识图谱查询关联人物关系和cypher查询](https://blog.csdn.net/for_yayun/article/details/109811935)

