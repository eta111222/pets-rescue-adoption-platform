package com.shanzhu.pet.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shanzhu.pet.entity.Feed;
import com.shanzhu.pet.mapper.FeedMapper;
import com.shanzhu.pet.service.IFeedService;
import org.springframework.stereotype.Service;

@Service
public class FeedServiceImpl extends ServiceImpl<FeedMapper, Feed> implements IFeedService {

}
