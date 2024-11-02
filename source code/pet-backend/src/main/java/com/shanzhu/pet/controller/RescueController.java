package com.shanzhu.pet.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.config.interceptor.AuthAccess;
import com.shanzhu.pet.entity.Rescue;
import com.shanzhu.pet.service.IRescueService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/rescue")
public class RescueController {

    @Resource
    private IRescueService rescueService;

    @PostMapping
    public R save(@RequestBody Rescue rescue) {
        rescueService.saveOrUpdate(rescue);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        rescueService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        rescueService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(rescueService.list());
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(rescueService.getById(id));
    }

    @AuthAccess
    @GetMapping("/page")
    public R findPage(
            @RequestParam(defaultValue = "") String name,
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize
    ) {
        QueryWrapper<Rescue> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("name", name);
        }
        return R.success(rescueService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }


}

