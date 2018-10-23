package com.yy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.abel533.mapper.Mapper;
import com.yy.pojo.Food;

public interface FoodMapper extends Mapper<Food>{

	List<Food> findFoodByPage(@Param("start")int start,@Param("rows") int rows);

	int updateStatus(@Param("ids")Long[] ids, @Param("status")int status);

	int deleteFoods(@Param("ids")Long[] ids);
}
