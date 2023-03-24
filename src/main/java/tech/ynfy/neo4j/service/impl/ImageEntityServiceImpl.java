package tech.ynfy.neo4j.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tech.ynfy.neo4j.entity.ImageEntity;
import tech.ynfy.neo4j.repository.ImageEntityRepository;
import tech.ynfy.neo4j.service.ImageEntityService;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/3/17
 */
@Service
public class ImageEntityServiceImpl implements ImageEntityService {

    @Autowired
    private ImageEntityRepository imageEntityRepository;


    @Override
    public void saveImage(ImageEntity imageEntity) {
        imageEntityRepository.save(imageEntity);
    }
}
