package com.shanzhu.pet.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.Constants;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Dict;
import com.shanzhu.pet.entity.Menu;
import com.shanzhu.pet.mapper.DictMapper;
import com.shanzhu.pet.service.IMenuService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/menu")
public class MenuController {

    @Resource
    private IMenuService menuService;

    @Resource
    private DictMapper dictMapper;

    @PostMapping
    public R save(@RequestBody Menu menu) {
        menuService.saveOrUpdate(menu);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        menuService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        menuService.removeByIds(ids);
        return R.success();
    }

    @GetMapping("/ids")
    public R findAllIds() {
        return R.success(menuService.list().stream().map(Menu::getId));
    }

    @GetMapping
    public R findAll(@RequestParam(defaultValue = "") String name) {
        return R.success(menuService.findMenus(name));
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(menuService.getById(id));
    }

    @GetMapping("/page")
    public R findPage(@RequestParam String name,
                      @RequestParam Integer pageNum,
                      @RequestParam Integer pageSize) {
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("name", name);
        queryWrapper.orderByDesc("id");
        return R.success(menuService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @GetMapping("/icons")
    public R getIcons() {
        QueryWrapper<Dict> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type", Constants.DICT_TYPE_ICON);
        return R.success(dictMapper.selectList(queryWrapper));
    }

}

