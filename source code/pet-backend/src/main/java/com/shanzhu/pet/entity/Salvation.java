package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Salvation", description = "")
public class Salvation implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("description")
    private String information;

    @ApiModelProperty("photo")
    private String img;

    @ApiModelProperty("address")
    private String address;

    @ApiModelProperty("found time")
    private String time;

    @ApiModelProperty("contact person")
    private String person;

    @ApiModelProperty("contact")
    private String phone;

    @ApiModelProperty("status")
    private String state;

}
