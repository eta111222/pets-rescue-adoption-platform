package com.shanzhu.pet.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Sterilization;
import com.shanzhu.pet.service.ISterilizationService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/sterilization")
public class SterilizationController {

    @Resource
    private ISterilizationService sterilizationService;

    @PostMapping
    public R save(@RequestBody Sterilization sterilization) {
        sterilizationService.saveOrUpdate(sterilization);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        sterilizationService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        sterilizationService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(sterilizationService.list());
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(sterilizationService.getById(id));
    }

    @GetMapping("/page")
    public R findPage(
            @RequestParam(defaultValue = "") String name,
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize
    ) {
        QueryWrapper<Sterilization> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("animal_name", name);
        }
        Page<Sterilization> page = sterilizationService.page(new Page<>(pageNum, pageSize), queryWrapper);
        return R.success(page);
    }

}

