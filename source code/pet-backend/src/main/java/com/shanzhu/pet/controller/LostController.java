package com.shanzhu.pet.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Lost;
import com.shanzhu.pet.service.ILostService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/lost")
public class LostController {

    @Resource
    private ILostService lostService;

    @PostMapping
    public R save(@RequestBody Lost lost) {
        lostService.saveOrUpdate(lost);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        lostService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        lostService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(lostService.list());
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(lostService.getById(id));
    }

    @GetMapping("/page")
    public R findPage(
            @RequestParam(defaultValue = "") String name,
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize
    ) {
        QueryWrapper<Lost> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("nickname", name);
        }
        return R.success(lostService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }


}

