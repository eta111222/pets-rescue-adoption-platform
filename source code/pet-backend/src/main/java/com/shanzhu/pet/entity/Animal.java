package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Animal Object", description = "")
public class Animal implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("Nickname")
    private String nickname;

    @ApiModelProperty("Sex")
    private String sex;

    @ApiModelProperty("Type")
    private String type;

    @ApiModelProperty("Age")
    private String age;

    @ApiModelProperty("Animal Photo")
    private String img;

    @ApiModelProperty("Activity Area")
    private String address;

    @ApiModelProperty("Physical Condition")
    private String status;

    @ApiModelProperty("Sterilization")
    private String sterilization;

    @ApiModelProperty("Vaccination")
    private String vaccine;

    @ApiModelProperty("Adoption Status")
    private String adopt;

    @ApiModelProperty("Additional Information")
    private String information;
    private String isAdopt;
    private Integer praise;

}
