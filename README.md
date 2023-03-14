
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



# Getting started with Neo4j Browser

## Manager Databases

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

