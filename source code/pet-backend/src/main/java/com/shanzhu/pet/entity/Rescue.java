package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Rescue", description = "")
public class Rescue implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("address")
    private String addres;

    @ApiModelProperty("photo")
    private String img;

    @ApiModelProperty("contact person")
    private String person;

    @ApiModelProperty("contact")
    private String phone;

    @ApiModelProperty("description")
    private String information;

}
