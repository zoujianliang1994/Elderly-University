package com.zhimu.dao.vo;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.zhimu.commons.utils.SSUtils;
import com.zhimu.dao.entity.cms.Article;
import com.zhimu.dao.entity.cms.Folder;

public class ArticleVo extends Article{
	private Folder folder; 
	private List<FolderVo> folderPathList;
	//private String pictureUrl;
	
	public  Folder getFolder() {
		return folder;
	}
	public  void setFolder(Folder folder) {
		this.folder = folder;
	}
	public  List<FolderVo> getFolderPathList() {
		return folderPathList;
	}
	public  void setFolderPathList(List<FolderVo> folderPathList) {
		this.folderPathList = folderPathList;
	}
	public  String getPictureUrl() {
		if(StringUtils.isBlank(this.getPicture())){
			return "upload/blank.jpg";
		}else{
			return this.getPicture();
		}
	}	
	/**
	 * 截取某一长度字符串，多余用...表示
	 * @param len
	 * @return
	 */
	public String getTitle(int len) {
		return SSUtils.getFixedLengthStr(this.getTitle(), len);
	}
	/**
	 * 设置title为截取的长度
	 * @param len
	 */
	public void setTitle(int len) {
		setTitle(getTitle(len));
	}
	
	
	

}
