package com.shanzhu.pet.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shanzhu.pet.common.R;
import com.shanzhu.pet.entity.Animal;
import com.shanzhu.pet.entity.Applcation;
import com.shanzhu.pet.entity.User;
import com.shanzhu.pet.service.IAnimalService;
import com.shanzhu.pet.service.IApplcationService;
import com.shanzhu.pet.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/applcation")
public class ApplcationController {

    @Resource
    private IApplcationService applcationService;

    @Resource
    private IAnimalService animalService;

    @PostMapping
    public R save(@RequestBody Applcation applcation) {
        applcationService.saveOrUpdate(applcation);
        return R.success();
    }

    @PostMapping("/state/{id}/{state}")
    public R state(@PathVariable Integer id, @PathVariable String state) {
        Applcation applcation = applcationService.getById(id);
        applcation.setState(state);

        QueryWrapper<Applcation> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("animal_id", applcation.getAnimalId());
        List<Applcation> list = applcationService.list(queryWrapper);
        for (Applcation app : list) {
            app.setState("Review Failed");
            applcationService.updateById(app);
        }

        applcationService.updateById(applcation);

        Animal animal = animalService.getById(applcation.getAnimalId());
        animal.setIsAdopt("Yes");
        animal.setAdopt("Not Available for Adoption");
        animalService.updateById(animal);
        return R.success();
    }

    @DeleteMapping("/{id}")
    public R delete(@PathVariable Integer id) {
        applcationService.removeById(id);
        return R.success();
    }

    @PostMapping("/del/batch")
    public R deleteBatch(@RequestBody List<Integer> ids) {
        applcationService.removeByIds(ids);
        return R.success();
    }

    @GetMapping
    public R findAll() {
        return R.success(applcationService.list());
    }

    @GetMapping("/{id}")
    public R findOne(@PathVariable Integer id) {
        return R.success(applcationService.getById(id));
    }

    @GetMapping("/my")
    public R my() {
        List<Animal> animals = animalService.list();
        QueryWrapper<Applcation> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        User currentUser = TokenUtils.getCurrentUser();
        if (currentUser == null) {
            return R.success(new ArrayList<>());
        }
        queryWrapper.eq("user_id", currentUser.getId());
        List<Applcation> applcations = applcationService.list(queryWrapper);
        for (Applcation record : applcations) {
            animals.stream().filter(animal -> animal.getId().equals(record.getAnimalId())).findFirst().ifPresent(record::setAnimal);
        }
        return R.success(applcations);
    }

    @GetMapping("/page")
    public R findPage(@RequestParam(defaultValue = "") String name,
                      @RequestParam Integer pageNum,
                      @RequestParam Integer pageSize) {
        List<Animal> animals = animalService.list();
        QueryWrapper<Applcation> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("name", name);
        }
        Page<Applcation> page = applcationService.page(new Page<>(pageNum, pageSize), queryWrapper);
        for (Applcation record : page.getRecords()) {
            animals.stream().filter(animal -> animal.getId().equals(record.getAnimalId())).findFirst().ifPresent(record::setAnimal);
        }
        return R.success(page);
    }

}

