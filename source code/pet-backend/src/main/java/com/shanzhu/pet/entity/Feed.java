package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Feed Object", description = "")
public class Feed implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("env pic1")
    private String img;

    @ApiModelProperty("env pic2")
    private String img2;

    @ApiModelProperty("env pic3")
    private String img3;

    @ApiModelProperty("address")
    private String address;

    @ApiModelProperty("description")
    private String information;

}
