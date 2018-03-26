package com.zhimu.dao.entity.cms;

import java.util.Date;

import com.zhimu.commons.constant.ArticleConstant;

public class Article {

	private String articleId;

	private String folderId;

	private String picture;

	private String path;

	private String title;

	private String summary;

	private Integer viewCount;

	private Integer commentCount;

	private ArticleConstant.Status status;

	private ArticleConstant.Check check;

	private Date createTime;

	private Date updateTime;

	private String content;

	private String sourceName;

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public String getArticleId() {
		return articleId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.articleId
	 * 
	 * @param articleId
	 *            the value for article.articleId
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.folderId
	 * 
	 * @return the value of article.folderId
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public String getFolderId() {
		return folderId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.folderId
	 * 
	 * @param folderId
	 *            the value for article.folderId
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.path
	 * 
	 * @return the value of article.path
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public String getPath() {
		return path;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.path
	 * 
	 * @param path
	 *            the value for article.path
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setPath(String path) {
		this.path = path;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.picture
	 * 
	 * @return the value of article.picture
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public String getPicture() {
		return picture;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.picture
	 * 
	 * @param picture
	 *            the value for article.picture
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setPicture(String picture) {
		this.picture = picture;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.title
	 * 
	 * @return the value of article.title
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.title
	 * 
	 * @param title
	 *            the value for article.title
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.summary
	 * 
	 * @return the value of article.summary
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public String getSummary() {
		return summary;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.summary
	 * 
	 * @param summary
	 *            the value for article.summary
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setSummary(String summary) {
		this.summary = summary;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.viewCount
	 * 
	 * @return the value of article.viewCount
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public Integer getViewCount() {
		return viewCount;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.viewCount
	 * 
	 * @param viewCount
	 *            the value for article.viewCount
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.commentCount
	 * 
	 * @return the value of article.commentCount
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public Integer getCommentCount() {
		return commentCount;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.commentCount
	 * 
	 * @param commentCount
	 *            the value for article.commentCount
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setCommentCount(Integer commentCount) {
		this.commentCount = commentCount;
	}

	public final ArticleConstant.Status getStatus() {
		return status;
	}

	public final void setStatus(ArticleConstant.Status status) {
		this.status = status;
	}

	public final ArticleConstant.Check getCheck() {
		return check;
	}

	public final void setCheck(ArticleConstant.Check check) {
		this.check = check;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.createTime
	 * 
	 * @return the value of article.createTime
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.createTime
	 * 
	 * @param createTime
	 *            the value for article.createTime
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.updateTime
	 * 
	 * @return the value of article.updateTime
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public Date getUpdateTime() {
		return updateTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.updateTime
	 * 
	 * @param updateTime
	 *            the value for article.updateTime
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the
	 * value of the database column article.content
	 * 
	 * @return the value of article.content
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public String getContent() {
		return content;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the
	 * value of the database column article.content
	 * 
	 * @param content
	 *            the value for article.content
	 * @mbggenerated Mon Aug 29 21:59:00 CST 2016
	 */
	public void setContent(String content) {
		this.content = content;
	}
}