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
