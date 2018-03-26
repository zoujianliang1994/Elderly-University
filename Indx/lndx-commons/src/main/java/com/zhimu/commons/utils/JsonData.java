package com.zhimu.commons.utils;

/**
 * <br/>
 * 类路径: com.pdk.commons.utils.JsonData <br/>
 * 类描述 : json数据返回封装,默认返回成功 <br/>
 * @author wangshanqiang <br/>
 * @date 2017年3月8日 <br/>
 * @version V1.0
 */
public class JsonData {
	/** 成功 1 **/
	public static final Integer SUCCESS = 1;
	/** 失败 0 */
	public static final Integer FAILED = 0;

	/** 其他 999999999 */
	public static final Integer OTHER_CODE = 999999999;

	private Integer code = 1; // 1成功,0代表失败 //默认成功
	private Object data;
	private Object other;
	private String desc = "保存成功";
	private Integer totals;

	public JsonData() {

	}

	/**
	 *
	 * @param code
	 *            返回码，非0为错误
	 * @param data
	 *            返回的数据
	 * @param desc
	 *            错误描述
	 */
	public JsonData(int code, Object data, String desc) {
		this.code = code;
		this.data = data;
		this.desc = desc;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public Object getOther() {
		return other;
	}

	public void setOther(Object other) {
		this.other = other;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Integer getTotals() {
		return totals;
	}

	public void setTotals(Integer totals) {
		this.totals = totals;
	}

	@Override
	public String toString() {
		return "JsonData [code=" + code + ", data=" + data + ", other=" + other
				+ ", desc=" + desc + ", totals=" + totals + "]";
	}

}
