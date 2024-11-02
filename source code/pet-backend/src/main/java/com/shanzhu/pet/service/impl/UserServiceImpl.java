package com.shanzhu.pet.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shanzhu.pet.common.Constants;
import com.shanzhu.pet.common.RoleEnum;
import com.shanzhu.pet.controller.dto.UserDTO;
import com.shanzhu.pet.controller.dto.UserPasswordDTO;
import com.shanzhu.pet.entity.Menu;
import com.shanzhu.pet.entity.User;
import com.shanzhu.pet.exception.BizException;
import com.shanzhu.pet.mapper.RoleMapper;
import com.shanzhu.pet.mapper.RoleMenuMapper;
import com.shanzhu.pet.mapper.UserMapper;
import com.shanzhu.pet.service.IMenuService;
import com.shanzhu.pet.service.IUserService;
import com.shanzhu.pet.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    private static final Log LOG = Log.get();

    @Resource
    private UserMapper userMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RoleMenuMapper roleMenuMapper;

    @Resource
    private IMenuService menuService;

    @Override
    public UserDTO login(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one != null) {
            BeanUtil.copyProperties(one, userDTO, true);
            String token = TokenUtils.genToken(one.getId().toString(), one.getPassword());
            userDTO.setToken(token);

            String role = one.getRole(); // ROLE_ADMIN
            List<Menu> roleMenus = getRoleMenus(role);
            userDTO.setMenus(roleMenus);
            return userDTO;
        } else {
            throw new BizException(Constants.CODE_600, "username or password wrong");
        }
    }

    @Override
    public User register(UserDTO userDTO) {
        User one = getOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, userDTO.getUsername()));
        if (one == null) {
            one = new User();
            BeanUtil.copyProperties(userDTO, one, true);
            one.setRole(RoleEnum.ROLE_USER.toString());
            save(one);
        } else {
            throw new BizException(Constants.CODE_600, "user already existed");
        }
        return one;
    }

    @Override
    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        int update = userMapper.updatePassword(userPasswordDTO);
        if (update < 1) {
            throw new BizException(Constants.CODE_600, "wrong password");
        }
    }

    private User getUserInfo(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", userDTO.getUsername());
        queryWrapper.eq("password", userDTO.getPassword());
        User one;
        one = getOne(queryWrapper);
        return one;
    }


    private List<Menu> getRoleMenus(String roleFlag) {
        Integer roleId = roleMapper.selectByFlag(roleFlag);

        List<Integer> menuIds = roleMenuMapper.selectByRoleId(roleId);

        List<Menu> menus = menuService.findMenus("");

        List<Menu> roleMenus = new ArrayList<>();

        for (Menu menu : menus) {
            if (menuIds.contains(menu.getId())) {
                roleMenus.add(menu);
            }
            List<Menu> children = menu.getChildren();

            children.removeIf(child -> !menuIds.contains(child.getId()));
        }
        return roleMenus;
    }

}
