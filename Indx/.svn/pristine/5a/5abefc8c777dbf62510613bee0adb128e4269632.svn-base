package com.zhimu.commons.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.SocketException;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class FtpUtils {

	public static final Log logger = LogFactory.getLog(FtpUtils.class);

	/******* 172.32.2.24:21 ***************/
	public static final String USERNAME = "Administrator"; // FTP 登录用户名
	public static final String PASSWORD = "123456"; // FTP 登录密码
	public static final String IP = "172.32.2.24"; // FTP 服务器地址IP地址
	public static final int PORT = 21; // FTP 端口

	/******* 211.149.188.146:33790 ***************/
	// public static final String USERNAME = "administrator"; // FTP 登录用户名
	// public static final String PASSWORD = "qwe123"; // FTP 登录密码
	// public static final String IP = "211.149.188.146"; // FTP 服务器地址IP地址
	// public static final int PORT = 33790; // FTP 端口

	public static final String IMGPATH = "614Img/"; // 图片位置
	public static final String FILEPATH = "614File/"; // 文件位置
	public static final String FG = File.separator;

	public static FTPClient ftpClient = null;

	/**
	 * 连接到服务器
	 * 
	 * @return true 连接服务器成功，false 连接服务器失败
	 */
	private static boolean connectServer() {
		boolean flag = false;
		int reply;
		try {
			ftpClient = new FTPClient();
			ftpClient.setControlEncoding("UTF-8");
			ftpClient.connect(IP, PORT);
			ftpClient.login(USERNAME, PASSWORD);
			reply = ftpClient.getReplyCode();
			ftpClient.setDataTimeout(120000);
			if (!FTPReply.isPositiveCompletion(reply)) {
				ftpClient.disconnect();
				logger.error("FTP 服务拒绝连接!");
				flag = false;
			}
			flag = true;
		} catch (SocketException e) {
			logger.error(ErrorUtils.getErrorMessage(e, "登录ftp服务器 " + IP + " 失败,连接超时!"));
		} catch (IOException e) {
			logger.error(ErrorUtils.getErrorMessage(e, "登录ftp服务器 " + IP + " 失败，FTP服务器无法打开!"));
		}
		return flag;
	}

	/**
	 * 读取Ftp的文件
	 * 
	 */
	public static InputStream readFile(String fileName) {
		InputStream ins = null;
		try {
			if (connectServer()) {
				// 从服务器上读取指定的文件
				ins = ftpClient.retrieveFileStream(fileName);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ins;
	}

	/**
	 * 上传图片到Ftp
	 */
	public static String uploadImg(File file) {
		return uploadFunction(file, IMGPATH);
	}

	/**
	 * 上传文件到Ftp
	 */
	public static String uploadFile(File file) {
		return uploadFunction(file, FILEPATH);
	}

	/**
	 * 上传文件的具体方法
	 * 
	 */
	private static String uploadFunction(File file, String uploadPath) {
		InputStream inputStream;
		String filePath = "";
		try {
			if (connectServer()) {
				String datePath = DateUtil.getDays();
				String fileName = file.getName();
				String prefix = fileName.substring(fileName.lastIndexOf(".") + 1);
				fileName = UuidUtil.get32UUID() + "." + prefix;
				inputStream = new FileInputStream(file);
				ftpClient.setControlEncoding("UTF-8");
				ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
				ftpClient.makeDirectory(uploadPath + FG + DateUtil.getDays());
				ftpClient.changeWorkingDirectory(uploadPath + FG + DateUtil.getDays());
				ftpClient.storeFile(fileName, inputStream);
				inputStream.close();
				ftpClient.logout();
				filePath = datePath + FG + fileName;
			}
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "上传文件失败!"));
		} finally {
			if (ftpClient.isConnected()) {
				try {
					ftpClient.disconnect();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return filePath;
	}

	public static File multipartToFile(MultipartFile multfile) throws IOException {
		CommonsMultipartFile cf = (CommonsMultipartFile) multfile;
		DiskFileItem fi = (DiskFileItem) cf.getFileItem();
		String fileName = fi.getName();
		File tmpFile = new File(System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") + fileName);
		multfile.transferTo(tmpFile);
		return tmpFile;
	}

	public static void main(String[] args) {
		// connectServer();
	}
}
