package com.zhimu.commons.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections.ComparatorUtils;
import org.apache.commons.collections.comparators.ComparableComparator;
import org.apache.commons.collections.comparators.ComparatorChain;

/**
 * <br/>类路径: com.pdk.commons.utils.ListUtil
 * <br/>类描述 : 处理集合相关操作
 * <br/> @author wangshanqiang
 * <br/>@date 2017年3月23日
 * <br/>@version V1.0
 */
public class ListUtil {
	/**
	 * <br/> @Description : 对集合进行排序（正/倒序）,需要排序的属性不能为空
	 * <br/> @param sortList 目标集合 
	 * <br/> @param type desc倒序，asc正序，默认是正序
	 * <br/> @param param 需要排序的属性，如果需要对集合里对象的某些属性排序可以采用  obj.xxx方式进行排序
	 * <br/> @return
	 * <br/> List<T> 返回排序后的数据
	 * <br/> @exception:
	 * <br/> @date:2017年3月23日
	 */
	 @SuppressWarnings({ "unchecked", "rawtypes" })
		public static <T> List<T> sort(List<T> sortList, String type, String ...param){
	        Comparator mycmp1 = ComparableComparator.getInstance ();
	        Comparator mycmp2 = ComparableComparator.getInstance ();
	        if("desc".equals(type)){
	            mycmp1 = ComparatorUtils. reversedComparator(mycmp1); //逆序（默认为正序）
	        }
	         
	        ArrayList<T> sortFields = new ArrayList<T>();
	        for(int i=0;i<param.length;i++){
	        	sortFields.add( (T) new BeanComparator(param[i] , mycmp1));
	        	sortFields.add( (T) new BeanComparator(param[i] , mycmp2)); 
	        	
	        }
	        ComparatorChain multiSort = new ComparatorChain(sortFields);
	        Collections.sort (sortList , multiSort);
	         
	        return sortList;
	    }
}
