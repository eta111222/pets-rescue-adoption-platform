package com.shanzhu.pet.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Donate;
import com.shanzhu.pet.service.IDonateService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/donate")
public class DonateController {

    @Resource
    private IDonateService donateService;

    @PostMapping
    public R save(@RequestBody Donate donate) {
        donateService.saveOrUpdate(donate);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        donateService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        donateService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(donateService.list());
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(donateService.getById(id));
    }

    @GetMapping("/page")
    public R findPage(
            @RequestParam(defaultValue = "") String name,
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize
    ) {
        QueryWrapper<Donate> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("name", name);
        }
        return R.success(donateService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

