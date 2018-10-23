package com.yy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yy.common.EasyUIResult;
import com.yy.mapper.FoodMapper;
import com.yy.pojo.Food;
@Service
public class FoodServiceImpl implements FoodService {

	@Autowired
	FoodMapper foodMapper;
	@Override
	public EasyUIResult findFoodByPage(int page, int rows) {
		int total = foodMapper.selectCount(null);
		System.out.println("食物总数"+total);
		int start=(page-1)*rows;
		List<Food> foodList=foodMapper.findFoodByPage(start,rows);
		return new EasyUIResult(total,foodList);
	}
	@Override
	public int saveFood(Food food) {
		food.setStatus(1);
		int rows=foodMapper.insert(food);
		if(rows>0)System.out.println("食物保存成功");
		return rows;
	}
	@Override
	public int updateStatus(Long[] ids, int status) {
		int rows = foodMapper.updateStatus(ids,status);
		if(rows>0) System.out.println("食物上/下架成功");
		return rows;
	}
	@Override
	public int updateFood(Food food) {
		int rows=foodMapper.updateByPrimaryKeySelective(food);
		if(rows>0)System.out.println("食物更新成功");
		return rows;
	}
	@Override
	public int deleteFoods(Long[] ids) {
		int rows=foodMapper.deleteFoods(ids);
		if(rows>0)System.out.println("食物删除成功");
		return rows;
	}

}
