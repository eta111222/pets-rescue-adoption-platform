package com.shanzhu.pet.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shanzhu.pet.entity.Lost;
import com.shanzhu.pet.mapper.LostMapper;
import com.shanzhu.pet.service.ILostService;
import org.springframework.stereotype.Service;

@Service
public class LostServiceImpl extends ServiceImpl<LostMapper, Lost> implements ILostService {

}
