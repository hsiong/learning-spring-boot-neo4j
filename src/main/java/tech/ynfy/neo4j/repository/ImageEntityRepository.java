package tech.ynfy.neo4j.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import tech.ynfy.neo4j.entity.ImageEntity;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/3/17
 */
@Repository
public interface ImageEntityRepository extends CrudRepository<ImageEntity, Long> {


}
