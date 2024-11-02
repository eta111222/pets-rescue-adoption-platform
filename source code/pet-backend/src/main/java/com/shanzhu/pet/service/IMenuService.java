package com.shanzhu.pet.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shanzhu.pet.entity.Menu;

import java.util.List;

public interface IMenuService extends IService<Menu> {

    List<Menu> findMenus(String name);
}
