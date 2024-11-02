package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Lost Object", description = "")
public class Lost implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    @ApiModelProperty("id")
    private Integer id;

    @ApiModelProperty("nickname")
    private String nickname;

    @ApiModelProperty("type")
    private String type;

    @ApiModelProperty("sex")
    private String sex;

    @ApiModelProperty("contact person")
    private String person;

    @ApiModelProperty("contact")
    private String phone;

    @ApiModelProperty("lost/waiting")
    private String status1;

    @ApiModelProperty("status")
    private String status2;

}
