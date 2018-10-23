# TongYongMapper-EasyUI
通用Mapper实现增删改查和EasyUI展示

## 1.引入通用mapper的maven依赖
```
<dependency>
			<groupId>com.github.abel533</groupId>
			<artifactId>mapper</artifactId>
			<version>2.3.2</version>
</dependency>
```
当然如果你是完整的ssm项目
那么可以按照如下代码写pom.xml
```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.yy</groupId>
	<artifactId>YYCanteen</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>war</packaging>
	<build>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>3.5.1</version>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
					<encoding>UTF-8</encoding>
				</configuration>
			</plugin>
		</plugins>
	</build>
	<dependencies>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>4.3.9.RELEASE</version>
		</dependency>
		<dependency>
			<groupId>com.github.abel533</groupId>
			<artifactId>mapper</artifactId>
			<version>2.3.2</version>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>5.1.40</version>
		</dependency>
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>druid</artifactId>
			<version>1.0.29</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.2.8</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>1.3.1</version>
		</dependency>
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-databind</artifactId>
			<version>2.8.5</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>4.3.9.RELEASE</version>
		</dependency>
	</dependencies>
</project>
```
## 2.在mybatis配置文件中添加```<plugins>```
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<!--配置的顺序 Content Model : (properties?, settings?, typeAliases?, typeHandlers?, 
		objectFactory?, objectWrapperFactory?, reflectorFactory?, plugins?, environments?, 
		databaseIdProvider?, mappers?) -->
	<!--开启驼峰规则 对象 表 属性 字段 id id userId user_id 下划线去掉，下划线后的首字母大写 说明：当查询sql返回结果时，会自动根据驼峰规则实现字段和属性的一一映射 -->
	<settings>
		<!-- 开启驼峰自动映射 -->
		<setting name="mapUnderscoreToCamelCase" value="true" />
	</settings>
	<plugins>
		<!-- 通用Mapper插件 -->
		<plugin interceptor="com.github.abel533.mapperhelper.MapperInterceptor">
			<!--主键自增回写方法,默认值MYSQL,详细说明请看文档 -->
			<property name="IDENTITY" value="MYSQL" />
			<!--通用Mapper接口，多个通用接口用逗号隔开 -->
			<property name="mappers" value="com.github.abel533.mapper.Mapper" />
		</plugin>
	</plugins>
</configuration>
```
## 3.建库建表，表的名字tb_food。表有了以后要写对应的pojo,这里是Food,注意pojo的定义要有@Table注解定义表名，@Id注解定义主键，@GeneratedValue(strategy=GenerationType.IDENTITY)注解定义主键自增
```
root@localhost:store_yh>desc tb_food;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| id     | int(11)     | NO   | PRI | NULL    | auto_increment |
| name   | varchar(50) | YES  |     | NULL    |                |
| price  | double      | YES  |     | NULL    |                |
| status | tinyint(4)  | YES  |     | 1       |                |
+--------+-------------+------+-----+---------+----------------+
```
```
package com.yy.pojo;

import java.io.Serializable;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="tb_food")
public class Food implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id //定义主键
	@GeneratedValue(strategy=GenerationType.IDENTITY)//定义主键自增
	private Integer id;
	private String name;
	private Double price;
	private Integer status;	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Food [id=" + id + ", name=" + name + ", price=" + price + ", status=" + status + "]";
	}
	
	
}
```
## 4.接着就要吧ssm环境配置好，各个配置文件，请参照项目配置，这里不再赘述。
## 5.写Mapper继承```Mapper<T>```这是通用Mapper第二个关键的设置
```
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
```
## 6.接着写你的Service接口,可以看到，如果使用了通用Mapper那么很多方法不用在Mapper接口写，直接声明调用就可以了。
另外，说个与通用Mapper无关的事，因为前端用了EasyUI框架，所以笔者定义了一个EasyUIResult。具体参照FoodService后面的那段代码
```
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
```
```
package com.yy.common;

import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class EasyUIResult {
	 // 定义jackson对象
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private Integer total;

    private List<?> rows;

    public EasyUIResult() {
    }

    public EasyUIResult(Integer total, List<?> rows) {
        this.total = total;
        this.rows = rows;
    }

    public EasyUIResult(Long total, List<?> rows) {
        this.total = total.intValue();
        this.rows = rows;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<?> rows) {
        this.rows = rows;
    }

    /**
     * Object是集合转化
     * 
     * @param jsonData json数据
     * @param clazz 集合中的类型
     * @return
     */
    public static EasyUIResult formatToList(String jsonData, Class<?> clazz) {
        try {
            JsonNode jsonNode = MAPPER.readTree(jsonData);
            JsonNode data = jsonNode.get("rows");
            List<?> list = null;
            if (data.isArray() && data.size() > 0) {
                list = MAPPER.readValue(data.traverse(),
                        MAPPER.getTypeFactory().constructCollectionType(List.class, clazz));
            }
            return new EasyUIResult(jsonNode.get("total").intValue(), list);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
```
## 7.接着就是写你的Servies实现类了,笔者的saveFood，updateFood用的都是通用Mapper
```
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
```
## 8.如果你是SSM项目，那么就要写Controller来调用Service,注意SysResult也是笔者写的工具类，视情况使用。具体如下
```
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
```
