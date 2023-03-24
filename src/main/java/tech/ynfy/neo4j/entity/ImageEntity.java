package tech.ynfy.neo4j.entity;

import lombok.Data;
import org.springframework.data.neo4j.core.schema.*;
import org.springframework.data.neo4j.core.schema.Relationship.Direction;

import java.util.List;

/**
 * https://we-yun.com/doc/neo4j-chs-doc/#_%E8%8A%82%E7%82%B9%E7%9A%84%E6%A0%87%E9%A2%98%E5%B1%9E%E6%80%A7
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/3/17
 */
@Node
@Data
public class ImageEntity {

    // `@Id`: Each entity has to have an id. The movie class shown here uses the attribute `title` as a unique business key. If you don’t have such a unique key, you can use the combination of `@Id` and `@GeneratedValue` to configure SDN to use Neo4j’s internal id. We also provide generators for UUIDs.
    @Id
    @GeneratedValue
    private Long id;

    // `@Property`: `@Property` as a way to use a different name for the field than for the graph property.
    @Property("image")
    private String img;

    // Relationship.INCOMING means end with this node
    @Relationship(type = "出现了", direction = Direction.OUTGOING)
    private List<PersonEntity> personEntityList;

    // Getters omitted for brevity
}
