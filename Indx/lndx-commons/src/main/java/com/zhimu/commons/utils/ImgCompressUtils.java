package com.zhimu.commons.utils;

import java.io.*;  
import java.awt.*;  
import java.awt.image.*;  
import javax.imageio.ImageIO;  
public class ImgCompressUtils {  
    
	/**
	 * 
	 * @param sourcePath	源目录路径
	 * @param sourceFileName	源文件名
	 * @param desPath	目的路径
	 * @param desFileName	目的文件
	 * @param type	1餐厅图片2商品小图片3商品大图片
	 * @param proportion	是否按照原图片等比例压缩
	 * @throws IOException
	 * @author Liang.Yuan
	 * <br>2016年7月22日
	 */
	public static void compress(String sourcePath,String sourceFileName,String desPath,String desFileName,int type,boolean proportion) throws IOException {
//        System.out.println("压缩图片开始");  
        File file = new File(sourcePath+sourceFileName);// 读入文件  
        Image img = ImageIO.read(file);
        int width = img.getWidth(null);    // 得到源图宽  
        int height = img.getHeight(null);  // 得到源图长  
        int h=0;
        int w=0;
        if(proportion){
        	double whProportion=Double.parseDouble((int)(Double.parseDouble(width+"")/Double.parseDouble(height+"")*1000)+"")/1000;
        	if(type ==1){
        		if (whProportion > 1.358) {
	        		h=210;
	        		w = (int) (width * h / height);  
	            } else {  
	            	w=285;
	            	h = (int) (height * w / width); 
	            }  
        	}else if(type==2){
        		if(whProportion >1){
        			h=180;
	        		w = (int) (width * h / height);  
        		}else{
        			w=180;
	            	h = (int) (height * w / width); 
        		}
        	}else if(type == 3){
        		if(whProportion >1){
        			h=990;
	        		w = (int) (width * h / height);  
        		}else{
        			w=990;
	            	h = (int) (height * w / width); 
        		}
        	}
        	
        }
        BufferedImage image = new BufferedImage(w, h,BufferedImage.TYPE_INT_RGB );   
        image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图  
        String formatName = sourceFileName.substring(sourceFileName.lastIndexOf(".") + 1,sourceFileName.length()); 
        desFileName+="."+formatName;
        File path=new File(desPath);
        if(!path.exists()){
        	path.mkdirs();
        }
        File destFile = new File(desPath,desFileName);  
        FileOutputStream out = new FileOutputStream(destFile); // 输出到文件流  
//        System.out.println("formatName"+formatName);
        ImageIO.write(image, formatName , destFile );  
        out.close();  
//        System.out.println("压缩图片结束");  
    }
	
	public static String compress(InputStream iStream,String sourceFileName, String desPath,String desFileName,boolean proportion) throws IOException {
      Image img = ImageIO.read(iStream);
      int width = img.getWidth(null);    // 得到源图宽  
      int height = img.getHeight(null);  // 得到源图长  
      int h=0;
      int w=0;
      if(proportion){
    	  //宽高比
      	double whProportion=Double.parseDouble((int)(Double.parseDouble(width+"")/Double.parseDouble(height+"")*1000)+"")/1000;
      	if(whProportion>1){
      		h=80;
      		w = (int) (width * h / height);  
      	}else{
      		w=80;
      		h = (int) (height * w / width); 
      	}
      }
      BufferedImage image = new BufferedImage(w, h,BufferedImage.TYPE_INT_RGB );   
      image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图  
      String formatName = sourceFileName.substring(sourceFileName.lastIndexOf(".") + 1,sourceFileName.length()); 
      desFileName+="."+formatName;
      File path=new File(desPath);
      if(!path.exists()){
      	path.mkdirs();
      }
      File destFile = new File(desPath,desFileName);  
      FileOutputStream out = new FileOutputStream(destFile); // 输出到文件流  
      ImageIO.write(image, formatName , destFile );  
      out.close();  
      return desFileName;
  }
}  