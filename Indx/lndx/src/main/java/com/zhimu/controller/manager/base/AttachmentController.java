package com.zhimu.controller.manager.base;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.FileUtil;
import com.zhimu.dao.entity.system.Attachment;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.system.attachment.AttachmentManager;

/**
 * 附件公用控制
 * 
 * @author Weiyunchao
 * 
 *         2017年8月8日上午11:14:21
 */
@Controller
@RequestMapping(value = "/attachment")
public class AttachmentController {

	protected org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());
	// private static String ATTACHMENT_FILE_PATH = "D:\\614system\\uploadFile";
	private static String ATTACHMENT_FILE_PATH = "uploadFile";
	@Resource(name = "attachmentService")
	private AttachmentManager attachmentService;
	public static final String FG = File.separator;

	@InitBinder
	public void initBinderAttachment(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("attachment.");
	}

	/**
	 * 上传附件
	 * 
	 * @param systemFile
	 *            需要上传的附件(可以是多附件)
	 * @param uploadFilePath
	 *            模块文件
	 * @param request
	 * @param response
	 * @param fileIdentity
	 *            上传文件归属归类
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public void save(@RequestParam MultipartFile[] systemFile, HttpServletRequest request, HttpServletResponse response, @RequestParam String uploadFilePath, @RequestParam String fileIdentity)
			throws IOException {
		try {
			// 可以在上传文件的同时接收其它参数
			// 如果用的是Tomcat服务器，则文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\upload\\文件夹中
			// 这里实现文件上传操作用的是commons.io.FileUtils类,它会自动判断/upload是否存在,不存在会自动创建
			String realPath = request.getSession().getServletContext().getRealPath(Const.FILEPATHFILE) + "/" + uploadFilePath + "/" + DateUtil.getDays();
			// 设置响应给前台内容的数据格式
			response.setContentType("text/plain; charset=UTF-8");
			// 设置响应给前台内容的PrintWriter对象
			PrintWriter out = response.getWriter();
			// 上传文件的原名(即上传前的文件名字)
			String originalFilename = null;
			JSONObject jsonObj = new JSONObject();// 创建json格式的数据
			// 如果只是上传一个文件,则只需要MultipartFile类型接收文件即可,而且无需显式指定@RequestParam注解
			// 如果想上传多个文件,那么这里就要用MultipartFile[]类型来接收文件,并且要指定@RequestParam注解
			// 上传多个文件时,前台表单中的所有<input
			// type="file"/>的name都应该是importFile,否则参数里的importFile无法获取到所有上传的文件
			String attachmentIds = "";// 多附件ID
			String attachmentNames = "";// 多附件名称
			for (MultipartFile myfile : systemFile) {
				if (myfile.isEmpty()) {
					jsonObj.put("status", "请选择文件后上传!");
					out.print(jsonObj.toString());
					out.flush();
				} else {
					originalFilename = myfile.getOriginalFilename();
					// 判断文件在该目录是否已存在
					File file = new File(realPath, originalFilename);
					SimpleDateFormat simple = new SimpleDateFormat("yyyy:MM:dd:HH:mm:ss");
					String datetime = simple.format(new Date()).replaceAll(":", "");
					if (file.exists()) {
						originalFilename = originalFilename.split("\\.")[0] + "(" + datetime + ")." + originalFilename.split("\\.")[1];
					}
					// System.out.println("文件原名: " + originalFilename);
					// System.out.println("文件名称: " + myfile.getName());
					// System.out.println("文件长度: " + myfile.getSize());
					// System.out.println("文件类型: " + myfile.getContentType());
					// System.out.println("========================================");
					try {
						// 这里不必处理IO流关闭的问题,因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉
						FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, originalFilename));
						String filePath = Const.FILEPATHFILE + uploadFilePath + "/" + DateUtil.getDays() + "/" + originalFilename;
						// String filePath =
						// FtpUtils.uploadMutipartFile(myfile,ATTACHMENT_FILE_PATH);
						// //上传到ftp配置路径下
						// String[] fileType = filePath.split("\\.");
						String fileName = file.getName();
						String prefix = fileName.substring(fileName.lastIndexOf(".") + 1);
						Attachment attachment = new Attachment();
						attachment.setPath(filePath);
						attachment.setFileType(prefix);
						attachment.setName(originalFilename);
						attachment.setIsDel("N");
						// attachment.setFileIdentity(AttachmentFileIdentity.MEETING.toString());
						attachment.setFileIdentity(fileIdentity);
						attachment.setCreateBy(Jurisdiction.getUsername());
						attachment.setCreateTime(new Timestamp(System.currentTimeMillis()).toString());
						attachmentService.save(attachment);
						attachmentIds = attachmentIds + "," + attachment.getId();
						attachmentNames = attachmentNames + "," + attachment.getName();
					} catch (IOException e) {
						jsonObj.put("status", "文件上传成功!");
						out.print(jsonObj.toString());
						out.flush();
						logger.error(ErrorUtils.getErrorMessage(e, "文件[" + originalFilename + "]上传失败,堆栈轨迹如下"));
					}
				}
			}
			jsonObj.put("status", "文件上传成功!");
			jsonObj.put("attatchmentId", attachmentIds);
			jsonObj.put("attatchmentName", attachmentNames);
			out.print(jsonObj.toString());
			out.flush();
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "保存附件出错"));
		}
	}

	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAttachment", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteAttachment(Attachment attachment) throws Exception {
		String status = "";// 删除状态
		attachmentService.deleteAttachment(attachment);
		// File file = new File(ATTACHMENT_FILE_PATH, attachment.getName());
		// if (!file.exists()) {
		// status = "删除文件失败:" + attachment.getName() + "不存在！";
		// } else {
		// if (file.isFile())
		// {
		// deleteFile(attachment);
		// status = "文件删除成功";
		// }
		// }
		return "文件删除成功！";
	}

	/**
	 * 删除单个文件
	 * 
	 * @param attachment
	 *            要删除的文件的文件名
	 * @return 单个文件删除成功返回true，否则返回false
	 * @throws Exception
	 */
	public boolean deleteFile(Attachment attachment) throws Exception {
		File file = new File(ATTACHMENT_FILE_PATH, attachment.getName());
		// 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
		if (file.exists() && file.isFile()) {
			if (file.delete()) {
				attachmentService.deleteAttachment(attachment);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	/**
	 * 文件下载
	 * 
	 * @Description:
	 * @param fileName
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/download")
	public void downloadFile(@RequestParam("fileName") String fileName, @RequestParam("filePath") String filePath, HttpServletRequest request, HttpServletResponse response) {
		if (fileName != null) {
			// inputStream = FtpUtils.readFile(filePath);
			String realPath = request.getSession().getServletContext().getRealPath(filePath);
			File file = new File(realPath);
			if (file.exists()) {
				response.setContentType("application/force-download");// 设置强制下载不打开
				// 设置response的Header
				try {
					response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("gbk"), "iso-8859-1"));// 转码之后下载的文件不会出现中文乱码
				} catch (UnsupportedEncodingException e1) {
					logger.error(ErrorUtils.getErrorMessage(e1, "设置response头出错"));
				}
				byte[] buffer = new byte[1024];
				FileInputStream fis = null;
				BufferedInputStream bis = null;
				try {
					fis = new FileInputStream(file);
					bis = new BufferedInputStream(fis);
					OutputStream os = response.getOutputStream();
					int i = bis.read(buffer);
					while (i != -1) {
						os.write(buffer, 0, i);
						i = bis.read(buffer);
					}
				} catch (Exception e) {
					logger.error(ErrorUtils.getErrorMessage(e, "读写文件出错"));
				} finally {
					if (bis != null) {
						try {
							bis.close();
						} catch (IOException e) {
							logger.error(ErrorUtils.getErrorMessage(e, "字节关闭流出错"));
						}
					}
					if (fis != null) {
						try {
							fis.close();
						} catch (IOException e) {
							logger.error(ErrorUtils.getErrorMessage(e, "文件输入流关闭流出错"));
						}
					}
				}
			} else {
				response.setContentType("application/force-download");// 设置强制下载不打开
				// 设置response的Header
				try {
					response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("gbk"), "iso-8859-1"));// 转码之后下载的文件不会出现中文乱码
					response.sendError(404);
				} catch (IOException e1) {
					logger.error(ErrorUtils.getErrorMessage(e1, "设置response头出错"));
				}

			}
		}
	}

	/**
	 * @param response
	 * @param filePath
	 *            //文件完整路径(包括文件名和扩展名)
	 * @param fileName
	 *            //下载后看到的文件名
	 * @return 文件名
	 */
	@RequestMapping(value = "fileDownload")
	public void fileDownload(final HttpServletResponse response, String filePath, String fileName) {
		byte[] data = null;
		try {
			data = FileUtil.toByteArray2(filePath);
			fileName = URLEncoder.encode(fileName, "UTF-8");
			response.reset();
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			response.addHeader("Content-Length", "" + data.length);
			response.setContentType("application/octet-stream;charset=UTF-8");
			OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
			outputStream.write(data);
			outputStream.flush();
			outputStream.close();
			response.flushBuffer();
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "文件[" + fileName + "]下载失败"));
			e.printStackTrace();
		}

	}

}
