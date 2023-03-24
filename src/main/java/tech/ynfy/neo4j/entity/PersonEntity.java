package tech.ynfy.neo4j.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.data.neo4j.core.schema.*;
import org.springframework.data.neo4j.core.schema.Relationship.Direction;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/3/17
 */
@Node
@Data
public class PersonEntity {

    // `@Id`: Each entity has to have an id. The movie class shown here uses the attribute `title` as a unique business key. If you don’t have such a unique key, you can use the combination of `@Id` and `@GeneratedValue` to configure SDN to use Neo4j’s internal id. We also provide generators for UUIDs.
    @Id
    @GeneratedValue
    private Long id;

    /** 头像url */
    @Property("image")
    private String img;

    /** 用户姓名 */
    @Property(value = "用户姓名")
    private String userName;

    /** 性别 */
    @Property(value = "性别")
    private String gender;

    @Property(value = "身份证号码")
    private String cardNoDesensitized;

    /** 电话号码 */
    @Property(value = "手机号")
    private String phoneNo;

    /** 家庭住址 */
    @Property(value = "家庭住址")
    private String address;

    /** 人员类型  */
    @Property(value = "人员类型")
    private String workerType;

    /** 职位类型字符串, 逗号分隔 */
    @Property("职位")
    private String workerRoleDictText;

    /**
     * 生日
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd")
    @Property("生日")
    private Date birth;

    @Relationship(type = "属于", direction = Direction.OUTGOING)
    private List<InstitutionEntity> institutionEntityList;
    
    
}
