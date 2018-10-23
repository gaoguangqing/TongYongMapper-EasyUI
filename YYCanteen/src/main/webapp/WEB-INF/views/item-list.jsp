<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="easyui-datagrid" id="itemList" title="食物列表" 
       data-options="singleSelect:false,collapsible:true,pagination:true,url:'food/query',method:'get',pageSize:20,toolbar:toolbar">
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
        	<th data-options="field:'id',width:100">食物ID</th>
            <th data-options="field:'name',width:250">食物名称</th>
            <th data-options="field:'price',width:90,align:'right',formatter:KindEditorUtil.formatPrice">食物价格</th>
            <th data-options="field:'status',width:80,align:'center',formatter:KindEditorUtil.formatItemStatus">状态</th>
        </tr>
    </thead>
</table>
<div id="itemEditWindow" class="easyui-window" title="编辑食物" data-options="modal:true,closed:true,iconCls:'icon-save',href:'page/item-edit'" style="width:80%;height:80%;padding:10px;">
</div>
<script>

    function getSelectionsIds(){
    	var itemList = $("#itemList");
    	var sels = itemList.datagrid("getSelections");
    	var ids = [];
    	for(var i in sels){
    		ids.push(sels[i].id);
    	}
    	ids = ids.join(",");
    	return ids;
    }
    
    var toolbar = [{
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
        	$(".tree-title:contains('新增食物')").parent().click();
        }
    },{
        text:'编辑',
        iconCls:'icon-edit',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个食物才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(',') > 0){
        		$.messager.alert('提示','只能选择一个食物!');
        		return ;
        	}
        	
        	$("#itemEditWindow").window({
        		onLoad :function(){
        			//回显数据
        			var data = $("#itemList").datagrid("getSelections")[0];
        			data.priceView = KindEditorUtil.formatPrice(data.price);
        			$("#itemeEditForm").form("load",data);
        			
     
        			KindEditorUtil.init({
        				"pics" : data.image,
        				"cid" : data.cid,
        				fun:function(node){
        					KindEditorUtil.changeItemParam(node, "itemeEditForm");
        				} 
        			});
        		}
        	}).window("open");
        }
    },{
        text:'删除',
        iconCls:'icon-cancel',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中食物!');
        		return ;
        	}
        	$.messager.confirm('确认','确定删除ID为 '+ids+' 的食物吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("food/delete",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','删除食物成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}else{
            				$.messager.alert("提示",data.msg);
            			}
            		});
        	    }
        	});
        }
    },'-',{
        text:'下架',
        iconCls:'icon-remove',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中食物!');
        		return ;
        	}
        	$.messager.confirm('确认','确定下架ID为 '+ids+' 的食物吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("food/instock",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','下架食物成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    },{
        text:'上架',
        iconCls:'icon-remove',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中食物!');
        		return ;
        	}
        	$.messager.confirm('确认','确定上架ID为 '+ids+' 的食物吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("food/reshelf",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','上架食物成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    }];
</script>