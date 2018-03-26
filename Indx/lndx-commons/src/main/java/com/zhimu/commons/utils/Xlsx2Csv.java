package com.zhimu.commons.utils;
import java.io.File;  
import java.io.IOException;  
import java.io.InputStream;  
  
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;  

import org.apache.poi.openxml4j.exceptions.OpenXML4JException;  
import org.apache.poi.openxml4j.opc.OPCPackage;  
import org.apache.poi.openxml4j.opc.PackageAccess;  
import org.apache.poi.ss.usermodel.DataFormatter;  
import org.apache.poi.ss.util.CellAddress;  
import org.apache.poi.ss.util.CellReference;  
import org.apache.poi.util.SAXHelper;  
import org.apache.poi.xssf.eventusermodel.ReadOnlySharedStringsTable;  
import org.apache.poi.xssf.eventusermodel.XSSFReader;  
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler;  
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler.SheetContentsHandler;  
import org.apache.poi.xssf.model.StylesTable;  
import org.apache.poi.xssf.usermodel.XSSFComment;  
import org.xml.sax.ContentHandler;  
import org.xml.sax.InputSource;  
import org.xml.sax.SAXException;  
import org.xml.sax.XMLReader;  
public class Xlsx2Csv {
	 /**  
     * Uses the XSSF Event SAX helpers to do most of the work  
     * of parsing the Sheet XML, and outputs the contents  
     * as a (basic) CSV.  
     */    
    private class SheetToCSV implements SheetContentsHandler {    
        private boolean firstCellOfRow = false;    
        private int currentRow = -1;    
        private int currentCol = -1;    
    
        private void outputMissingRows(int number) {    
            for (int i = 0; i < number; i++) {    
                curstr = new ArrayList<String>();  
                for (int j = 0; j < minColumns; j++) {    
                    curstr.add(null);    
                }    
                output.add(curstr);    
            }    
        }    
    
        @Override    
        public void startRow(int rowNum) {    
            curstr = new ArrayList<String>();  
            // If there were gaps, output the missing rows    
            outputMissingRows(rowNum - currentRow - 1);    
            // Prepare for this row    
            firstCellOfRow = true;    
            currentRow = rowNum;    
            currentCol = -1;    
        }    
    
        @Override    
        public void endRow(int rowNum) {    
            // Ensure the minimum number of columns    
            for (int i = currentCol; i < minColumns ; i++) {    
                curstr.add(null);    
            }    
            output.add(curstr);    
        }    
    
        @Override    
        public void cell(String cellReference, String formattedValue,    
                         XSSFComment comment) {    
//            if (firstCellOfRow) {    
//                firstCellOfRow = false;    
//            } else {    
//                curstr.append(',');    
//            }    
    
            // gracefully handle missing CellRef here in a similar way as XSSFCell does    
            if (cellReference == null) {    
                cellReference = new CellAddress(currentRow, currentCol).formatAsString();    
            }    
    
            // Did we miss any cells?    
            int thisCol = (new CellReference(cellReference)).getCol();    
            int missedCols = thisCol - currentCol - 1;    
            for (int i = 0; i < missedCols; i++) {    
                curstr.add(null);    
            }    
            currentCol = thisCol;    
    
            // Number or string?    
            try {    
                Double.parseDouble(formattedValue);    
                curstr.add(formattedValue);    
            } catch (NumberFormatException e) {    
               // output.append('"');    
                curstr.add(formattedValue);    
             //   output.append('"');    
            }    
        }    
    
        @Override    
        public void headerFooter(String text, boolean isHeader, String tagName) {    
            // Skip, no headers or footers in CSV    
        }    
    }    
    
    
    ///////////////////////////////////////    
    
    private final OPCPackage xlsxPackage;    
    
    /**  
     * Number of columns to read starting with leftmost  
     */    
    private final int minColumns;    
    
    /**  
     * Destination for data  
     */    
      
    private ArrayList<ArrayList<String>> output;  
    private ArrayList<String> curstr;  
    private int index_sheet;//第几页
    public  ArrayList<ArrayList<String>> get_output(){  
        return output;  
    }  
      
    /**  
     * Creates a new XLSX -> CSV converter  
     *  
     * @param pkg        The XLSX package to process  
     * @param output     The PrintStream to output the CSV to  
     * @param minColumns The minimum number of columns to output, or -1 for no minimum  
     */    
    public Xlsx2Csv(OPCPackage pkg, int minColumns,int index_sheetv) {    
        this.xlsxPackage = pkg;    
        this.minColumns = minColumns;   
        this.index_sheet=index_sheetv;
    }    
      
    
    /**  
     * Parses and shows the content of one sheet  
     * using the specified styles and shared-strings tables.  
     *  
     * @param styles  
     * @param strings  
     * @param sheetInputStream  
     */    
    public void processSheet(    
            StylesTable styles,    
            ReadOnlySharedStringsTable strings,    
            SheetContentsHandler sheetHandler,    
            InputStream sheetInputStream)    
            throws IOException, ParserConfigurationException, SAXException {  
        DataFormatter formatter = new DataFormatter();    
        InputSource sheetSource = new InputSource(sheetInputStream);    
        try {    
            XMLReader sheetParser = SAXHelper.newXMLReader();    
            ContentHandler handler = new XSSFSheetXMLHandler(    
                    styles, null, strings, sheetHandler, formatter, false);    
            sheetParser.setContentHandler(handler);    
            sheetParser.parse(sheetSource);    
        } catch (ParserConfigurationException e) {    
            throw new RuntimeException("SAX parser appears to be broken - " + e.getMessage());    
        }    
    }    
    
    /**  
     * Initiates the processing of the XLS workbook file to CSV.  
     *  
     * @throws IOException  
     * @throws OpenXML4JException  
     * @throws ParserConfigurationException  
     * @throws SAXException  
     */    
    public void process()    
            throws IOException, OpenXML4JException, ParserConfigurationException, SAXException {    
        ReadOnlySharedStringsTable strings = new ReadOnlySharedStringsTable(this.xlsxPackage);    
        XSSFReader xssfReader = new XSSFReader(this.xlsxPackage);    
        StylesTable styles = xssfReader.getStylesTable();    
        XSSFReader.SheetIterator iter = (XSSFReader.SheetIterator) xssfReader.getSheetsData();    
        int index = 0;    
        while (iter.hasNext()) {    
            output = new ArrayList<ArrayList<String>> ();  
            InputStream stream = iter.next();    
            String sheetName = iter.getSheetName();
            
            if(this.index_sheet==index){
            	 System.out.println("正在读取sheet： "+sheetName + " [index=" + index + "]:"); 
            	 SheetToCSV st = new SheetToCSV();
            	 st.startRow(5);
                 processSheet(styles, strings, st, stream);    
                 System.out.println("sheet 读取完成!");  
                 stream.close();    
            }
            ++index;    
        }    
    }    
    /**
     * 
     *@desc:解析excel，使用csv格式解析
     *@param path
     *@return
     *@throws IOException
     *@throws OpenXML4JException
     *@throws ParserConfigurationException
     *@throws SAXException
     *@author：wsq
     *@createDate:2017年11月20日
     *@version:V1.0
     *@updateDate:
     */
    public  static ArrayList<ArrayList<String>> analysisPeopleExcel(String path,String fileName,int sheetNum) throws IOException, OpenXML4JException, ParserConfigurationException, SAXException{
    	 OPCPackage p = OPCPackage.open(path+fileName, PackageAccess.READ);  
         Xlsx2Csv xlsx2csv = new Xlsx2Csv(p, -1,sheetNum);
         xlsx2csv.process();
         ArrayList<ArrayList<String>> excel_output = new ArrayList<ArrayList<String>>();  
         excel_output = xlsx2csv.get_output();
         p.close();
         ArrayList<ArrayList<String>> ans = new ArrayList<ArrayList<String>>();
         if(excel_output.size()<9){
        	 return ans;
         }
         for (int rowNum2 = 9; rowNum2 < excel_output.size(); rowNum2++) {  
        	 if(rowNum2==excel_output.size()-1){
             	break;
             }
             ArrayList<String> curarr = excel_output.get(rowNum2);
             if(curarr == null || curarr.size()<2){
            	 break;
             }
             ans.add(curarr);
         }
         return ans;
    }
    
    
    public static void main(String[] args) throws Exception {  
      /*  if (args.length < 1) { 
            System.err.println("Use:"); 
            System.err.println("  XLSX2CSV <xlsx file> [min columns]"); 
            return; 
        }*/  
  
        File xlsxFile = new File("E:\\老龄委项目\\绵阳市三台县潼川镇草堂社区.xlsx");  
        if (!xlsxFile.exists()) {  
            System.err.println("Not found or not a file: " + xlsxFile.getPath());  
            return;  
        }  
  
        int minColumns = -1;  
        if (args.length >= 2)  
            minColumns = Integer.parseInt(args[1]);  
  
        // The package open is instantaneous, as it should be.  
        OPCPackage p = OPCPackage.open(xlsxFile.getPath(), PackageAccess.READ);  
        Xlsx2Csv xlsx2csv = new Xlsx2Csv(p, minColumns,1);  
        xlsx2csv.process();  
        
        ArrayList<ArrayList<String>> excel_output = new ArrayList<ArrayList<String>>();  
        //Xlsx2Csv xlsx2csv2 = new Xlsx2Csv(p, 20); // 20代表最大列数  
        excel_output = xlsx2csv.get_output();  
        p.close();  
        ArrayList<ArrayList<String>> ans = new ArrayList<ArrayList<String>>();  
        // 遍历xlsx中的sheet  
  
        // 对于每个sheet，读取其中的每一行  
        for (int rowNum2 = 9; rowNum2 < excel_output.size(); rowNum2++) {  
            ArrayList<String> curarr = excel_output.get(rowNum2);
            if(rowNum2==excel_output.size()-1){
            	break;
            }
            for (int i = 0; i < curarr.size(); i++) {
				System.out.println(curarr.get(i));
			}
        }  
        
    }  
}
