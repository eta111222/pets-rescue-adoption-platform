package com.shanzhu.pet.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shanzhu.pet.controller.dto.UserDTO;
import com.shanzhu.pet.controller.dto.UserPasswordDTO;
import com.shanzhu.pet.entity.User;

public interface IUserService extends IService<User> {

    UserDTO login(UserDTO userDTO);

    User register(UserDTO userDTO);

    void updatePassword(UserPasswordDTO userPasswordDTO);
}
