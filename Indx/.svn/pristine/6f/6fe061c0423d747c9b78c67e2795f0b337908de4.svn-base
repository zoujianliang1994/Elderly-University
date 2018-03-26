package com.zhimu.service.manager.cms;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.mail.FolderNotFoundException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.constant.FolderConstant;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.FileUpload;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PathUtil;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.cms.Folder;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.vo.FolderVo;

@Service("folderService")
public class FolderService {
	protected final Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private DaoSupport folderDao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		// pd.put("PICTURES_PATH", returnPicturePath(pd));
		folderDao.save("FolderMapper.addFolder", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPages(Page page) throws Exception {
		return (List<PageData>) folderDao.findForList("FolderMapper.datalistPage", page);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		// pd.put("PICTURES_PATH", returnPicturePath(pd));
		folderDao.update("FolderMapper.updateFolder", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) folderDao.findForObject("FolderMapper.findById", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		folderDao.delete("FolderMapper.deleteFolder", pd);
	}

	/**
	 * @Description: 根據目录Id查询对象 @param: @param folderId @param: @return @param: @throws
	 *               Exception @return: Folder @throws
	 */
	public Folder getFolderById(String folderId) throws Exception {
		return (Folder) folderDao.findForObject("FolderMapper.getFolderById", folderId);
	}

	public String secondFolderId(String folderId) throws Exception {
		Folder folder = (Folder) folderDao.findForObject("FolderMapper.getFolderById", folderId);
		String[] folderList = folder.getPath().split("#");
		return folderList[1];
	}

	public long firstFolderId(String folderId) throws Exception {
		Folder folder = this.getFolderById(folderId);
		String[] folderList = folder.getPath().split("#");
		return Long.parseLong(folderList[0]);
	}

	public boolean isFolderEname(String ename) throws Exception {
		PageData f = this.getFolderByEname(ename);
		if (null != f) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 获取当前用户的所有目录
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getAllFolderList(Page page) throws Exception {
		return (List<PageData>) folderDao.findForList("FolderMapper.getAllFolderList", page);
	}

	/**
	 * 得到目录的path
	 * 
	 * @param folderId
	 * @return
	 * @throws Exception
	 */
	public List<FolderVo> getFolderPathListByFolderId(String folderId) throws Exception {
		List<FolderVo> list = new ArrayList<FolderVo>();
		if ("0".equals(folderId)) {
			return list;
		} else {
			return list;
		}
	}

	/**
	 * 获得所有子目录
	 * 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getAllFolderList() throws Exception {
		return (List<PageData>) folderDao.findForList("FolderMapper.getAllFolder", "");
	}

	/**
	 * 根据类型获取目录信息
	 * 
	 * @param type
	 *            目录类型
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<FolderVo> getAllFolderListByType(String type) throws Exception {
		List<PageData> pageDataList = (List<PageData>) folderDao.findForList("FolderMapper.getAllFolderByType", type);
		List<FolderVo> folderVoList = new ArrayList<FolderVo>();
		if (null != pageDataList && pageDataList.size() > 0) {
			for (PageData pd : pageDataList) {
				FolderVo fv = new FolderVo();
				fv.setFolderId(pd.getString("FOLDER_ID"));
				fv.setName(pd.getString("NAME"));
				fv.setEname(pd.getString("ENAME"));
				fv.setPath(pd.getString("PATH"));
				fv.setPicturesPath(pd.getString("PICTURES_PATH"));
				fv.setPicturesId(pd.getString("PICTURES_ID"));
				folderVoList.add(fv);
			}
		}
		return folderVoList;
	}

	/**
	 * 根据fatherId获得子目录
	 * 
	 * @param fatherId
	 * @return
	 * @throws Exception
	 */
	@Cacheable(value = "folder")
	public List<FolderVo> getFolderListByFatherId(String fatherId) throws Exception {
		List<FolderVo> folderVoList = new ArrayList<FolderVo>();
		@SuppressWarnings("unchecked")
		List<PageData> pageList = (List<PageData>) folderDao.findForList("FolderMapper.getFolderListByFatherId", fatherId);
		if (null != pageList && pageList.size() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (PageData pd : pageList) {
				FolderVo fv = new FolderVo();
				fv.setTitle(pd.getString("TITLE"));
				fv.setCreateTime(sdf.parse(pd.getString("CREATE_TIME")));
				fv.setContent(pd.getString("CONTENT"));
				fv.setFolderId(pd.getString("FOLDER_ID"));
				fv.setName(pd.getString("NAME"));
				fv.setFatherId(fatherId);
				fv.setPath(pd.getString("PATH"));
				folderVoList.add(fv);
			}
		}
		return folderVoList;
	}

	/**
	 * 通过ename
	 * 
	 * @param ename
	 * @return
	 * @throws Exception
	 */
	@Cacheable(value = "folder")
	public PageData getFolderByEname(String ename) throws Exception {
		PageData pageData = (PageData) folderDao.findForObject("FolderMapper.getFolderByEname", ename);
		if (pageData == null) {
			throw new FolderNotFoundException(null, ename + " 目录,不存在");
		} else {
			return pageData;
		}
	}

	/**
	 * @Description: 更新狀態 @param: @param folderId @param: @param status @param: @throws
	 *               Exception @return: void @throws
	 */
	@CacheEvict(value = "folder")
	public void updateStatus(long folderId, FolderConstant.Status status) throws Exception {
		folderDao.update("FolderMapper.updateStatus", status);
	}

	private String returnPicturePath(PageData pd) throws Exception {
		// 保存图片信息
		MultipartFile files = (MultipartFile) pd.get("files");
		String PICTURES_FLAG = pd.getString("PICTURES_FLAG");
		String picturePath = "";
		if (files != null && "1".equals(PICTURES_FLAG)) {
			String fileDate = DateUtil.getDays();
			String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + fileDate; // 文件上传路径
			String fileName = FileUpload.fileUp(files, filePath, UuidUtil.get32UUID()); // 执行上传
			picturePath = Const.FILEPATHIMG + fileDate + File.separator + fileName;
		} else {
			picturePath = pd.getString("PICTURES_PATH");
		}
		return picturePath;
	}
}
