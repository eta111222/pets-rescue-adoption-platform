package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Application Object", description = "")
public class Applcation implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("Name")
    private String name;

    @ApiModelProperty("Gender")
    private String sex;

    @ApiModelProperty("Age")
    private Integer age;

    @ApiModelProperty("Pet Experience")
    private String experience;

    @ApiModelProperty("Pet")
    private String pet;

    @ApiModelProperty("Contact Info")
    private String phone;

    @ApiModelProperty("Marital Status")
    private String married;

    @ApiModelProperty("Income")
    private String income;

    @ApiModelProperty("Profession")
    private String profession;

    @ApiModelProperty("Address")
    private String address;

    @ApiModelProperty("Reason for Adoption")
    private String reason;

    @ApiModelProperty("Status")
    private String state;

    @ApiModelProperty("Animal ID")
    private Integer animalId;
    private Integer userId;
    @TableField(exist = false)
    private Animal animal;

}
