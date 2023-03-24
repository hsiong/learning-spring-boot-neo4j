package tech.ynfy.neo4j.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tech.ynfy.neo4j.entity.ImageEntity;
import tech.ynfy.neo4j.service.ImageEntityService;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/3/17
 */
@RestController
@RequestMapping("image")
public class ImageEntityController {
    
    @Autowired
    private ImageEntityService imageEntityService;

    @PostMapping("saveImage")
    public String saveImage(@RequestBody ImageEntity imageEntity) {
        imageEntityService.saveImage(imageEntity);
        return "操作成功";
    }

}
