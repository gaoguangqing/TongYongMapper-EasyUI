package com.yy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yy.common.EasyUIResult;
import com.yy.common.SysResult;
import com.yy.pojo.Food;
import com.yy.service.FoodService;


@Controller
@RequestMapping("/food")
public class FoodController {
	@Autowired
	private FoodService foodService;
	@RequestMapping("/query")
	@ResponseBody
	public EasyUIResult findFoodByPage(int page,int rows){
		System.out.println(page+" "+rows);
		return foodService.findFoodByPage(page,rows);
		
	}
	@RequestMapping("/save")
	@ResponseBody
	public SysResult saveFood(Food food)
	{
		try {
			foodService.saveFood(food);
			return SysResult.oK();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "食物添加失败");
	}
	//食物下架
		@RequestMapping("/instock")
		@ResponseBody
		public SysResult instock(Long[] ids){
			try {
				int status=2;//2是下架 1是上架
				foodService.updateStatus(ids,status);
				return SysResult.oK();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return SysResult.build(201, "食物下架失败");
		}
		//食物上架
		@RequestMapping("/reshelf")
		@ResponseBody
		public SysResult reshelf(Long[] ids){
			try {
				int status=1;//1是上架 2是下架
				foodService.updateStatus(ids,status);
				return SysResult.oK();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return SysResult.build(201, "食物上架失败");
		}
		//食物修改
		@RequestMapping("/update")
		@ResponseBody
		public SysResult updateFood(Food food)
		{
			try {
				foodService.updateFood(food);
				return SysResult.oK();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return SysResult.build(201, "食物更新失败");
		}
		//食物删除
		@RequestMapping("/delete")
		@ResponseBody
		public SysResult delete(Long[] ids)
		{
			try {
				foodService.deleteFoods(ids);
				return SysResult.oK();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return SysResult.build(201, "食物删除失败");
		}
}
