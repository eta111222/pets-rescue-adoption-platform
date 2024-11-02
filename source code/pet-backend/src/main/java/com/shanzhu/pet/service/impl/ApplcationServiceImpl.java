package com.shanzhu.pet.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shanzhu.pet.entity.Applcation;
import com.shanzhu.pet.mapper.ApplcationMapper;
import com.shanzhu.pet.service.IApplcationService;
import org.springframework.stereotype.Service;

@Service
public class ApplcationServiceImpl extends ServiceImpl<ApplcationMapper, Applcation> implements IApplcationService {

}
