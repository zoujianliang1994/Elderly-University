package com.zhimu.dao.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;

/**
 * 分页器
 * 
 * @author Herbert
 * 
 * @param <T>
 */
public class PageVo<T> {
	/**
	 * 页码
	 */
	private int pageNum;
	/**
	 * 页码总数
	 */
	private int pageCount;
	/**
	 * 总数
	 */
	private int count;
	/**
	 * 偏移
	 */
	private int offset;
	/**
	 * 数量
	 */
	private int rows=20;
	/**
	 * 数据
	 */
	private List<T> list;
	/**
	 * 页码HTML
	 */
	private String pageNumHtml;
	/**
	 * 参数
	 */
	private Map<String, String> args = new HashMap<String, String>();

	public PageVo(int pageNum) {
		this.pageNum = pageNum;
	}
	/**
	 * 获取当前页码
	 * @return
	 */
	public int getPageNum() {
		if (this.pageNum <= 0) {
			this.pageNum = 1;
			return 1;
		} else {
			return pageNum;
		}
	}
	/**
	 * 设置页码
	 * @param pageNum
	 */
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	/**
	 * 获取列表总页数
	 * @return
	 */
	public int getPageCount() {
		this.pageCount = ((this.getCount() - 1) / this.getRows()) + 1;
		return pageCount;
	}
	/**
	 * 设置总页数
	 * @param pageCount
	 */
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	/**
	 * 获取偏移量，当前页的起始位置
	 * @return
	 */
	public int getOffset() {
		this.offset = (this.getPageNum() - 1) * this.getRows();
		return offset;
	}
	/**
	 * 设置偏移量，当前页的起始位置
	 * @param offset
	 */
	public void setOffset(int offset) {
		this.offset = offset;
	}
	/**
	 * 获取一页中的条目数
	 * @return
	 */
	public int getRows() {
		return rows;
	}
	/**
	 * 设置一页中的条目数(默认20行)
	 * @param rows
	 */
	public void setRows(int rows) {
		this.rows = rows;
	}
	/**
	 * 查询结果集
	 * @return
	 */
	public List<T> getList() {
		return list;
	}
	/**
	 * 设置查询结果集
	 * @param list
	 */
	public void setList(List<T> list) {
		this.list = list;
	}

	public String getUrl(int num) {
		Iterator<Entry<String, String>> iter = this.getArgs().entrySet()
				.iterator();
		List<String> values = new ArrayList<String>();
		while (iter.hasNext()) {
			Map.Entry<String, String> entry = iter.next();
			Object key = entry.getKey();
			Object val = entry.getValue();
			values.add(key + "=" + val);
		}
		values.add("p=" + num);
		return "?" + StringUtils.join(values.toArray(), "&");
	}

	public void setPageNumHtml(String pageNumHtml) {
		this.pageNumHtml = pageNumHtml;
	}

	public String getPageNumHtml() {
		StringBuffer sb = new StringBuffer();
		sb.append("<ul class=\"pagination\">");
		// 首页，上一页
		if (this.getPageNum() != 1) {
			sb.append("<li><a href='" + this.getUrl(1)
					+ "' title='首页'>&lt;&lt;</a></li>");
			sb.append("<li><a href='" + this.getUrl(this.getPageNum() - 1)
					+ "' title='上一页'>&lt;</a></li>");
		}
		// 页码
		if (this.getPageCount() != 1) {
			int startNum = this.getPageNum() - 3 <= 1 ? 1
					: this.getPageNum() - 3;
			int endNum = this.getPageNum() + 3 >= this.getPageCount() ? this
					.getPageCount() : this.getPageNum() + 3;
			if (startNum > 1) {
				sb.append("<li><a href='javascript:void(0);'>...</a></li>");
			}
			for (int i = startNum; i <= endNum; i++) {
				if (i == pageNum) {
					sb.append("<li class='active'><a   href='" + this.getUrl(i)
							+ "' class='number current' title='" + i + "'>" + i
							+ "</a></li>");
				} else {
					sb.append("<li><a href='" + this.getUrl(i)
							+ "' class='number' title='" + i + "'>" + i
							+ "</a></li>");
				}
			}
			if (endNum < this.getPageCount()) {
				sb.append("<li><a href='javascript:void(0);'>...</a></li>");
			}
		}
		// 下一页，尾页
		if (this.getPageNum() < this.getPageCount()) {
			sb.append("<li><a href='" + this.getUrl(this.getPageNum() + 1)
					+ "' title='下一页'>&gt;</a></li>");
			sb.append("<li><a href='" + this.getUrl(this.getPageCount())
					+ "' title='末页'>&gt;&gt;</a></li>");
		}
		sb.append("</ul>");
		return sb.toString();
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Map<String, String> getArgs() {
		return args;
	}

	public void setArgs(Map<String, String> args) {
		this.args = args;
	}
	/**
	 * 判断是否为最后一页
	 * @return
	 */
	public boolean isLastPage(){
		if(this.getPageNum()>=this.getPageCount()){
			return true;
		}else{
			return false;
		}
	}

}
