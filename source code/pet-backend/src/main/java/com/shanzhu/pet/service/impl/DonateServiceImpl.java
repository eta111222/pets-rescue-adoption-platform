package com.shanzhu.pet.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shanzhu.pet.entity.Donate;
import com.shanzhu.pet.mapper.DonateMapper;
import com.shanzhu.pet.service.IDonateService;
import org.springframework.stereotype.Service;

@Service
public class DonateServiceImpl extends ServiceImpl<DonateMapper, Donate> implements IDonateService {

}
