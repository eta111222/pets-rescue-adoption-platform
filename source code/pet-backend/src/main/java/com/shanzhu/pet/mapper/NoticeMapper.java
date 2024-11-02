package com.shanzhu.pet.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shanzhu.pet.entity.Notice;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface NoticeMapper extends BaseMapper<Notice> {

    @Select("select * from notice order by id desc limit 5 ")
    List<Notice> limit(int i);
}
