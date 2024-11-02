package com.shanzhu.pet.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
@ApiModel(value = "Comment Object", description = "")
public class Comment implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("reply content")
    private String content;

    @ApiModelProperty("reply user")
    private String user;

    @ApiModelProperty("time")
    private String time;

    @ApiModelProperty("parent id")
    private Integer pid;

    @ApiModelProperty("article id")
    private Integer articleId;
    private Integer type;
    @TableField(exist = false)
    private String avatar;
    @TableField(exist = false)
    private List<Comment> children;

}
