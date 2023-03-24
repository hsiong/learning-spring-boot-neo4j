package tech.ynfy.neo4j.service;

import tech.ynfy.neo4j.entity.ImageEntity;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/3/17
 */
public interface ImageEntityService {


    /**
     * 保存图片
     */
    void saveImage(ImageEntity imageEntity);

    
}
