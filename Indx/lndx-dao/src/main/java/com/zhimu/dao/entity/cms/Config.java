package com.zhimu.dao.entity.cms;

import java.util.Date;

public class Config {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column config.key
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    private String keyId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column config.value
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    private String value;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column config.createTime
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    private Date createTime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column config.description
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    private String description;


    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column config.value
     *
     * @return the value of config.value
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    public String getValue() {
        return value;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column config.value
     *
     * @param value the value for config.value
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column config.createTime
     *
     * @return the value of config.createTime
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column config.createTime
     *
     * @param createTime the value for config.createTime
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column config.description
     *
     * @return the value of config.description
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    public String getDescription() {
        return description;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column config.description
     *
     * @param description the value for config.description
     *
     * @mbggenerated Mon Aug 29 21:59:00 CST 2016
     */
    public void setDescription(String description) {
        this.description = description;
    }

	public String getKeyId() {
		return keyId;
	}

	public void setKeyId(String keyId) {
		this.keyId = keyId;
	}
}