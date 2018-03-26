package com.zhimu.commons.utils;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
 import java.io.IOException;
import java.io.InputStreamReader;

/**
  * 网页转图片处理类，使用外部CMD
  * @author lekkoli
  */
 public class PhantomTools {
 
 
     // private static final String _tempPath = "/data/temp/phantom_";
     // private static final String _shellCommand = "/usr/local/xxx/phantomjs /usr/local/xxx/rasterize.js ";  Linux下的命令
     private static final String _tempPath = "D:/phantomjs/phantom_";
     private static final String _savePngCommand = "D:/phantomjs/bin/phantomjs D:/phantomjs/bin/rasterize.js ";
     private static final String _getURLCommand="D:/phantomjs/bin/phantomjs D:/phantomjs/bin/getUrl.js ";
     
     private String _file;
     private String _size;
 
     /**
      * 构造函数
      */
     public PhantomTools(){
     }
     /**
      * 构造截图类
      * @parm hash 用于临时文件的目录唯一化
      */
     public PhantomTools(int hash) {
         _file = _tempPath + hash + ".png";
     }
      /**
      * 构造截图类
      * @parm hash 用于临时文件的目录唯一化
      * @param size 图片的大小，如800px*600px（此时高度会裁切），或800px（此时 高度最少=宽度*9/16，高度不裁切）
      */
     public PhantomTools(int hash, String size) {
         this(hash);
         if (size != null)
             _size = " " + size;
     }
      /**  
      * 将目标网页转为图片字节流
      * @param url 目标网页地址
      * @return 字节流
      */
     public byte[] getByteImg(String url) throws IOException {
         BufferedInputStream in = null;
         ByteArrayOutputStream out = null;
         File file = null;
         byte[] ret = null;
         try {
             if (exeCmd(_savePngCommand + url + " " + _file + (_size != null ? _size : ""))) {
                 file = new File(_file);
                 if (file.exists()) {
                     out = new ByteArrayOutputStream();
                     byte[] b = new byte[5120];
                     in = new BufferedInputStream(new FileInputStream(file));
                     int n;
                     while ((n = in.read(b, 0, 5120)) != -1) {
                         out.write(b, 0, n);
                     }
                     file.delete();
                     ret = out.toByteArray();
                 }
             } else {
                 ret = new byte[] {};
             }
         } finally {
             try {
                 if (out != null) {
                     out.close();
                 }
             } catch (IOException e) {
            	 e.printStackTrace();
             }
             try {
                 if (in != null) {
                     in.close();
                 }
             } catch (IOException e) {
            	 e.printStackTrace();
             }
             if (file != null && file.exists()) {
                 file.delete();
             }
                      }
         return ret;
    }
     
     public static String exeCmdGetURL(String url){
    	 return exeCmdGetIOStream(_getURLCommand+url);
     }
     public void  exeCmdSavePng(String url,String fileName,String _size){
    	 System.out.print(exeCmd(_savePngCommand + url + " " +  _tempPath + fileName + ".png" + " "+(_size != null ? _size : "")));
     }
    /**
     * 执行CMD命令
      */
     private static boolean exeCmd(String commandStr) {
    	 System.out.println(commandStr);
         BufferedReader br = null;
        try {
            Process p = Runtime.getRuntime().exec(commandStr);
             if (p.waitFor() != 0 && p.exitValue() == 1) {
                 return false;
            }
        } catch (Exception e) {
        	e.printStackTrace();
         } finally {
            if (br != null) {
               try {
                    br.close();
                 } catch (Exception e) {
                	 e.printStackTrace();
                }
           }
        }
         return true;
     }
     private static String exeCmdGetIOStream(String commandStr){
    	 System.out.println(commandStr);
    	 BufferedReader br = null;
    	 try {
    		 Process process = Runtime.getRuntime().exec(commandStr);
    		 if (process.waitFor() != 0 && process.exitValue() == 1) {
    			 return null;
    		 }
    		 br = new BufferedReader(new InputStreamReader(process.getInputStream(),"GB2312"));
    		 String line=null;
    		 String result="";
    		 while((line=br.readLine())!=null){
    			 result+=line;
    		 }
    		 return result;
		} catch (Exception e) {
			return null;
		}
     }
     
     public static void main(String[] args) {
		new PhantomTools().exeCmdSavePng("http://www.bigoutianxia.com","sdsdfdsfdsfsd","800px*600px");
		System.out.println(PhantomTools.exeCmdGetURL("http://www.bigoutianxia.com"));
	}
 }