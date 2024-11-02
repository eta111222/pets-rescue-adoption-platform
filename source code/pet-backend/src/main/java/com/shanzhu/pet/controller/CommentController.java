package com.shanzhu.pet.controller;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Comment;
import com.shanzhu.pet.entity.User;
import com.shanzhu.pet.service.ICommentService;
import com.shanzhu.pet.service.IUserService;
import com.shanzhu.pet.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private ICommentService commentService;

    @Resource
    private IUserService userService;

    @PostMapping
    public R save(@RequestBody Comment comment) {
        comment.setUser(TokenUtils.getCurrentUser().getNickname());
        comment.setTime(DateUtil.now());
        commentService.saveOrUpdate(comment);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        commentService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        commentService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(commentService.list());
    }

    @GetMapping("/article/{type}/{articleId}")
    public R findAll(@PathVariable Integer type, @PathVariable Integer articleId) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("article_id", articleId);
        queryWrapper.eq("type", type);
        List<Comment> list = commentService.list(queryWrapper);
        List<Comment> res = new ArrayList<>();
        for (Comment comment : list) {
            User one = userService.getOne(Wrappers.<User>lambdaQuery().eq(User::getNickname, comment.getUser()));
            if (one != null) {
                comment.setAvatar(one.getAvatarUrl());
            }
            if (comment.getPid() == null) {
                res.add(comment);
                List<Comment> children = list.stream().filter(c -> comment.getId().equals(c.getPid())).collect(Collectors.toList());
                comment.setChildren(children);
            }
        }
        return R.success(res);
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(commentService.getById(id));
    }

    @GetMapping("/page")
    public R findPage(
            @RequestParam(defaultValue = "") String name,
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize
    ) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("name", name);
        }
        return R.success(commentService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }


}

