package com.zhimu.service.manager.cms;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

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
import com.zhimu.dao.vo.ArticleVo;
import com.zhimu.dao.vo.FolderVo;
import com.zhimu.dao.vo.PageVo;

/**
 * 文章服务
 * 
 * @author GunnyZeng
 */
@Service("articleService")
public class ArticleService {

	@Resource(name = "daoSupport")
	private DaoSupport articleDao;
	@Autowired
	protected FolderService folderService;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) articleDao.findForObject("ArticleMapper.findById", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPages(Page page) throws Exception {
		return (List<PageData>) articleDao.findForList("ArticleMapper.datalistPage", page);
	}

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		// pd.put("PICTURE", returnPicturePath(pd));
		articleDao.save("ArticleMapper.addArticle", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		// pd.put("PICTURE", returnPicturePath(pd));
		articleDao.update("ArticleMapper.updateArticle", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		articleDao.delete("ArticleMapper.delete", pd);
	}

	/**
	 * 得到文件
	 * 
	 * @param
	 * @return File
	 * @throws Exception
	 */
	@Cacheable(value = "article", key = "'getArticleById_'+#articleId")
	public PageData getArticleById(String articleId) throws Exception {
		return (PageData) articleDao.findForObject("ArticleMapper.getArticleById", articleId);
	}

	/**
	 * 获取所有目录指定页码和行数的文章列表
	 * 
	 * @param pageNum
	 * @param rows
	 * @return
	 * @throws Exception
	 */
	@Cacheable(value = "article")
	public PageVo<FolderVo> getArticlePage(String path, int pageNum, int rows) throws Exception {
		PageVo<FolderVo> pageVo = new PageVo<FolderVo>(pageNum);
		pageVo.setRows(rows);
		PageData pd = new PageData();
		pd.put("PATH", path);
		Page page = new Page();
		page.setCurrentPage(pageNum);
		page.setShowCount(rows);
		page.setPd(pd);
		pageVo.setCount((int) articleDao.findForObject("ArticleMapper.getArticleCountOfDisplayByPath", path));
		@SuppressWarnings("unchecked")
		List<PageData> pageList = (List<PageData>) articleDao.findForList("ArticleMapper.articlelistPage", page);
		List<PageData> allFolderList = this.folderService.getAllFolderList();
		List<FolderVo> folderSet = new ArrayList<FolderVo>();
		if (null != pageList && pageList.size() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (PageData pdf : allFolderList) {
				List<ArticleVo> articlelist = new ArrayList<ArticleVo>();
				FolderVo fv = new FolderVo();
				fv.setName(pdf.getString("NAME"));
				fv.setFolderId(pdf.getString("FOLDER_ID"));
				fv.setEname(pdf.getString("ENAME"));
				fv.setStatus(FolderConstant.Status.valueOf(pdf.getString("STATUS")));
				for (PageData pg : pageList) {
					if (pdf.getString("FOLDER_ID").equals(pg.get("FOLDER_ID").toString())) {
						ArticleVo articleVo = new ArticleVo();
						articleVo.setTitle(pg.getString("TITLE"));
						articleVo.setPicture(pg.getString("PICTURE"));
						articleVo.setTitle(70);
						articleVo.setContent(pg.getString("CONTENT"));
						articleVo.setCreateTime(sdf.parse(pg.getString("CREATE_TIME")));
						articleVo.setFolderId(pg.get("FOLDER_ID").toString());
						articleVo.setUpdateTime(sdf.parse(pg.getString("UPDATE_TIME")));
						articleVo.setArticleId(pg.get("ARTICLE_ID").toString());
						articleVo.setSourceName(pg.get("SOURCE_NAME").toString());
						articleVo.setSummary(pg.getString("SUMMARY"));
						FolderVo fd = new FolderVo();
						fd.setName(pdf.getString("NAME"));
						fd.setStatus(FolderConstant.Status.valueOf(pdf.getString("STATUS")));
						fd.setEname(pdf.getString("ENAME"));
						fd.setFolderId(pdf.get("FOLDER_ID").toString());
						articleVo.setFolder(fd);
						articlelist.add(articleVo);
					}
				}
				fv.setArticleList(articlelist);
				folderSet.add(fv);
			}
		}
		pageVo.setList(folderSet);
		return pageVo;
	}

	/**
	 * 得到目录的显示的文件分页
	 * 
	 * @param folderId
	 * @return pageVo
	 * @throws Exception
	 */
	@Cacheable(value = "article")
	public PageVo<ArticleVo> getArticlePageByFolderId(String folderId, Page page) throws Exception {
		PageVo<ArticleVo> pageVo = new PageVo<ArticleVo>(1);
		String path = (String) articleDao.findForObject("FolderMapper.getFolderPath", folderId);
		pageVo.setRows(page.getShowCount());
		PageData pd = new PageData();
		pd.put("PATH", path);
		int count = (int) articleDao.findForObject("ArticleMapper.getArticleCountOfDisplayByPath", path);
		pageVo.setCount(count);
		page.setShowCount(10);
		page.setPd(pd);
		@SuppressWarnings("unchecked")
		List<PageData> pageDataList = (List<PageData>) articleDao.findForList("ArticleMapper.articlelistPage", page);
		List<ArticleVo> articlelist = new ArrayList<ArticleVo>();
		if (null != pageDataList && pageDataList.size() > 0) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (PageData pageData : pageDataList) {
				ArticleVo avo = new ArticleVo();
				avo.setArticleId(pageData.getString("ARTICLE_ID"));
				avo.setContent(pageData.getString("CONTENT"));
				avo.setPath(path);
				avo.setSourceName(pageData.getString("SOURCE_NAME"));
				avo.setTitle(pageData.getString("TITLE"));
				avo.setUpdateTime(formatter.parse(pageData.getString("UPDATE_TIME")));
				avo.setCreateTime(formatter.parse(pageData.getString("CREATE_TIME")));
				avo.setFolderId(pageData.getString("FOLDER_ID"));
				avo.setPicture(pageData.getString("PICTURE"));
				articlelist.add(avo);
			}
		}
		for (ArticleVo article : articlelist) {
			Folder articleFolder = (Folder) articleDao.findForObject("FolderMapper.getFolderById", article.getFolderId());
			article.setFolder(articleFolder);
		}
		pageVo.setList(articlelist);
		return pageVo;
	}

	/**
	 * @throws
	 * @Description: 更新审核状态
	 * @param: @param pd
	 * @param: @throws Exception
	 * @return: void
	 */
	@CacheEvict(value = "article", allEntries = true)
	public void updateCheck(PageData pd) throws Exception {
		articleDao.update("ArticleMapper.updateCheck", pd);
	}

	/**
	 * @throws
	 * @Description:根据路径查询文章
	 * @param: @param pd
	 * @param: @return
	 * @param: @throws Exception
	 * @return: List<ArticleVo>
	 */
	@SuppressWarnings("unchecked")
	public List<ArticleVo> getArticleListOfDisplayByPath(PageData pd) throws Exception {
		return (List<ArticleVo>) articleDao.findForList("ArticleMapper.getArticleListOfDisplayByPath", pd);
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
			picturePath = pd.getString("PICTURE");
		}
		return picturePath;
	}
}
