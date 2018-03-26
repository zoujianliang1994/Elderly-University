package com.zhimu.commons.utils;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.web.servlet.view.document.AbstractExcelView;

/**
 * 导入到EXCEL
 */
public class ObjectExcelView extends AbstractExcelView {

  private String type;

  public ObjectExcelView() {
    this.type = "";
  }

  public ObjectExcelView(String type) {
    this.type = type;
  }

  @Override
  protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
    Date date = new Date();
    String filename = Tools.date2Str(date, "yyyyMMdd") + type;
    HSSFSheet sheet;
    HSSFCell cell;
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");
    sheet = workbook.createSheet("sheet1");
    List<String> titles = (List<String>) model.get("titles");
    int len = titles.size();
    HSSFCellStyle headerStyle = workbook.createCellStyle(); // 标题样式
    headerStyle.setAlignment(HorizontalAlignment.CENTER);
    headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
    HSSFFont headerFont = workbook.createFont(); // 标题字体
    headerFont.setBold(true);
    headerFont.setFontHeightInPoints((short) 11);
    headerStyle.setFont(headerFont);
    short width = 20, height = 25 * 20;
    sheet.setDefaultColumnWidth(width);
    for (int i = 0; i < len; i++) { // 设置标题
      String title = titles.get(i);
      cell = getCell(sheet, 0, i);
      cell.setCellStyle(headerStyle);
      setText(cell, title);
    }
    sheet.getRow(0).setHeight(height);
    HSSFCellStyle contentStyle = workbook.createCellStyle(); // 内容样式
    contentStyle.setAlignment(HorizontalAlignment.CENTER);
    List<PageData> varList = (List<PageData>) model.get("varList");
    int varCount = varList.size();
    for (int i = 0; i < varCount; i++) {
      PageData vpd = varList.get(i);
      for (int j = 0; j < len; j++) {
        String varstr = vpd.get("var" + (j + 1)) + "";
        if ("null".equals(varstr) || varstr == null) {
          varstr = "";
        }
        cell = getCell(sheet, i + 1, j);
        String[] vararr = (String[]) vpd.get("var" + (j + 1) + "_arr");
        if (null != vararr && vararr.length > 0) {
          sheet.addValidationData(setDataValidation(sheet, vararr, 1, varCount, j, j));
        }
        cell.setCellStyle(contentStyle);
        setText(cell, varstr);
      }
    }
  }

  /**
   * 下拉列表
   */
  private static DataValidation setDataValidation(Sheet sheet, String[] textList, int firstRow, int endRow, int firstCol, int endCol) {
    DataValidationHelper helper = sheet.getDataValidationHelper();
    // 加载下拉列表内容
    DataValidationConstraint constraint = helper.createExplicitListConstraint(textList);
    constraint.setExplicitListValues(textList);
    // 设置数据有效性加载在哪个单元格上。四个参数分别是：起始行、终止行、起始列、终止列
    CellRangeAddressList regions = new CellRangeAddressList((short) firstRow, (short) endRow, (short) firstCol, (short) endCol);
    // 数据有效性对象
    DataValidation data_validation = helper.createValidation(constraint, regions);
    return data_validation;
  }
}
