package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@TableName("sys_user")
@ApiModel(value = "User Object", description = "")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("Username")
    private String username;

    @ApiModelProperty("Password")
    private String password;

    @ApiModelProperty("Nickname")
    private String nickname;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("Phone")
    private String phone;

    @ApiModelProperty("Address")
    private String address;

    @ApiModelProperty("Creation Time")
    private Date createTime;

    @ApiModelProperty("Avatar")
    private String avatarUrl;

    @ApiModelProperty("Role")
    private String role;
    private String sex;
    private String birth;

}
