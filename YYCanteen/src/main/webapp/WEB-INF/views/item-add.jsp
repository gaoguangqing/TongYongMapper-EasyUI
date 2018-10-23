<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding: 10px 10px 10px 10px">
	<form id="itemAddForm" class="itemForm" method="post">
		<table cellpadding="5">

			<tr>
				<td>商品名称:</td>
				<td><input class="easyui-textbox" type="text" name="name"
					data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>商品价格:</td>
				<td><input class="easyui-numberbox" type="text"
					name="priceView"
					data-options="min:1,max:99999999,precision:2,required:true" /> <input
					type="hidden" name="price" /></td>
			</tr>

		</table>
	</form>
	<div style="padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()">提交</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">

	
	function submitForm(){
		//表单校验
		if(!$('#itemAddForm').form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
		//转化价格单位，将元转化为分
		$("#itemAddForm [name=price]").val(eval($("#itemAddForm [name=priceView]").val()) * 100);
		
		var paramJson = [];
		$("#itemAddForm .params li").each(function(i,e){
			var trs = $(e).find("tr");
			var group = trs.eq(0).text();
			var ps = [];
			for(var i = 1;i<trs.length;i++){
				var tr = trs.eq(i);
				ps.push({
					"k" : $.trim(tr.find("td").eq(0).find("span").text()),
					"v" : $.trim(tr.find("input").val())
				});
			}
			paramJson.push({
				"group" : group,
				"params": ps
			});
		});
		paramJson = JSON.stringify(paramJson);//将对象转化为json字符串
		
		$("#itemAddForm [name=itemParams]").val(paramJson);
		
		$.post("food/save",$("#itemAddForm").serialize(), function(data){
			if(data.status == 200){
				$.messager.alert('提示','新增商品成功!');
			}else{
				$.messager.alert("提示","新增商品失败!");
			}
		});
	}
	function clearForm(){
		$('#itemAddForm').form('reset');
	}
	
</script>