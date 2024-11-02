package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Sterilization Object", description = "")
public class Sterilization implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    @ApiModelProperty("id")
    private Integer id;

    @ApiModelProperty("Stray Animal ID")
    private Integer animalId;

    @ApiModelProperty("Capture Status")
    private String catch1;
    private String animalName;

    @ApiModelProperty("Sterilization Status")
    private String sterilization;

    @ApiModelProperty("Release Status")
    private String release1;

    @ApiModelProperty("Vaccine Status")
    private String vaccine;

}
