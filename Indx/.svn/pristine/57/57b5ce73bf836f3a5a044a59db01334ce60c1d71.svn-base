package com.zhimu.commons.utils;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * 解析EXcel
 */
public class ObjectExcelRead {

  /**
   * filepath //文件路径
   * filename //文件名
   * startrow //开始行号
   * startcol //开始列号
   * endRow   //末尾的行数据不读取 有的用于解释说明  默认0
   * numSheet //sheet
   */
  public static List<Object> readExcel(String filepath, String filename, int startrow, int startcol, int endRow, int numSheet) {
    List<Object> varList = new ArrayList<Object>();
    try {
      File target = new File(filepath, filename);
      FileInputStream fi = new FileInputStream(target);

      Workbook workbook = null;
      if (filename.endsWith(".xls")) {
        workbook = new HSSFWorkbook(fi);
      } else if (filename.endsWith(".xlsx")) {
        workbook = new XSSFWorkbook(fi);
      } else {
        varList = null;
      }
      varList = getWorkBook(workbook, startrow, startcol, endRow, numSheet);

    } catch (Exception e) {
      return varList;
    }
    return varList;
  }


  /**
   * 解析Excel并且返回内容
   * workbook
   */
  private static List<Object> getWorkBook(Workbook workbook, int startrow, int startcol, int endRow, int numSheet) {
    StringBuffer sb = new StringBuffer();
    PageData pd;
    List<Object> list = new ArrayList<Object>();
    try {
      Sheet sheet = workbook.getSheetAt(numSheet);
      if (sheet == null) {
        return list;
      }
      int firstRowIndex = sheet.getFirstRowNum() + startrow - 1;
      int lastRowIndex = sheet.getLastRowNum() - endRow;
      // 读取数据行
      for (int rowIndex = firstRowIndex; rowIndex <= lastRowIndex; rowIndex++) {
        // 当前行
        Row currentRow = sheet.getRow(rowIndex);
        if (currentRow != null) {
          pd = new PageData();
          // 首列
          int firstColumnIndex = currentRow.getFirstCellNum() + startcol;
          // 最后一列
          int lastColumnIndex = currentRow.getLastCellNum();
          for (int columnIndex = firstColumnIndex; columnIndex <= lastColumnIndex; columnIndex++) {
            // 当前单元格
            Cell currentCell = currentRow.getCell(columnIndex);
            // 当前单元格的值
            String currentCellValue = getCellValue(currentCell, true);
            pd.put("var" + columnIndex, currentCellValue);
          }
          list.add(pd);
        }
      }
    } catch (Exception e) {
    }
    return list;
  }

  /**
   * 取单元格的值
   * cell单元格对象
   * treatAsStr 为true时，当做文本来取值 (取到的是文本，不会把“1”取成“1.0”)
   */
  private static String getCellValue(Cell cell, boolean treatAsStr) {
    if (cell == null) {
      return "";
    }
    if (treatAsStr) {
      // 虽然excel中设置的都是文本，但是数字文本还被读错，如“1”取成“1.0” 加上下面这句，临时把它当做文本来读取
      cell.setCellType(Cell.CELL_TYPE_STRING);
    }
    if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
      return String.valueOf(cell.getBooleanCellValue());
    } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
      return String.valueOf(cell.getNumericCellValue());
    } else {
      return String.valueOf(cell.getStringCellValue());
    }
  }
}
