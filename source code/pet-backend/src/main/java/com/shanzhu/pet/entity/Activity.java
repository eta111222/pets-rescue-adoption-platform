package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


@Data
@ApiModel(value = "Activity Object", description = "")
public class Activity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("content")
    private String content;

    @ApiModelProperty("time")
    private String time;

    @ApiModelProperty("coverimg")
    private String img;

    @ApiModelProperty("application number")
    private Integer num;

    @ApiModelProperty("address")
    private String address;
}
