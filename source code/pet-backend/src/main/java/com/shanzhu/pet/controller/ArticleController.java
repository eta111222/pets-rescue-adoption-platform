package com.shanzhu.pet.controller;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Article;
import com.shanzhu.pet.service.IArticleService;
import com.shanzhu.pet.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/article")
public class ArticleController {

    @Resource
    private IArticleService articleService;

    private final String now = DateUtil.now();

    @PostMapping
    public R save(@RequestBody Article article) {
        if (article.getId() == null) {
            article.setTime(DateUtil.now());
            article.setUserId(TokenUtils.getCurrentUser().getId());
            article.setUser(TokenUtils.getCurrentUser().getNickname());
        }
        articleService.saveOrUpdate(article);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        articleService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        articleService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(articleService.list());
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(articleService.getById(id));
    }

    @GetMapping("/page")
    public R findPage(
            @RequestParam(defaultValue = "") String name,
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize
    ) {
        QueryWrapper<Article> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("name", name);
        }
        return R.success(articleService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

