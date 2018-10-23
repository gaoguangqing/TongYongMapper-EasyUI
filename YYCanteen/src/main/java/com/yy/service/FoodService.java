package com.yy.service;

import com.yy.common.EasyUIResult;
import com.yy.pojo.Food;

public interface FoodService {

	EasyUIResult findFoodByPage(int page, int rows);

	int saveFood(Food food);

	int updateStatus(Long[] ids, int status);

	int updateFood(Food food);

	int deleteFoods(Long[] ids);

}
