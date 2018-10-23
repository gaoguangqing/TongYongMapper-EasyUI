package com.yy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class IndexController {
	@RequestMapping("index")
	public String index(){
		return "index";
	}
	/**
	 * url
	 *  /page/item-add
	 *  /page/item-update
	 *  
	 *  设想:
	 *   1.参数的位置必须固定
	 *   2.如果有多个参数时，使用"/"分割
	 *   3.需要接收的参数使用{}包装,使用@PathVariable注解接收参数
	 *  用法:
	 *   @RequestMapping("page/{aaa}")
	 *   @PathVariable(value="aaa") String moduleName
	 *   如果参数名称不一致。可以使用
	 *   @PathVariable(value="aaa")方法获取数据
	 *   get请求
	 *   localhost:8091/addUser?id=1&name=tom
	 *   rest风格
	 *   localhost:8091/addUser/1/tom
	 * @return
	 */
	@RequestMapping("page/{moduleName}")
	public String item_add(@PathVariable String moduleName){
		return moduleName;
	}
}
