package com.chuangbang.framework.util.excel;

import java.util.Map;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelStyleUtils {

	public final static short ALIGN_CENTER = 0x2;

	public final static short ALIGN_LEFT = 0x1;
	  
	public final static short ALIGN_RIGHT = 0x3;
	 
	public final static short VERTICAL_CENTER = 0x1;
	
	public final static String DEFAULT_HEADER = "bold_10";
	
	public final static String DEFAULT_TITLE = "bold_15";
	
	public final static String DEFAULT_CONTENT = "normal_10";

	public static void createALlStyles(Workbook wb, Map<String, CellStyle> styles){
		styles.put(DEFAULT_CONTENT, getStyle_Nor_10(wb));
		styles.put(DEFAULT_HEADER, getStyle_Bold_10(wb));
		styles.put(DEFAULT_TITLE, getStyle_Bold_15(wb));
	}
	
	public static CellStyle getStyle_Nor_10(Workbook wb) {
		return getCellStyle(wb, getFont_Nor_10(wb), ALIGN_CENTER,VERTICAL_CENTER, true, false);
	}
	
	public static CellStyle getStyle_CurrencyStyle(Workbook wb) {
		return getStyle_Right(wb, (short)4);
	}
	
	public static CellStyle getStyle_Int(Workbook wb) {
		return getStyle_Right(wb, (short)1);
	}
	
	public static CellStyle getStyle_Nor_11_Left(Workbook wb) {
		return getCellStyle(wb, getFont_Nor_11(wb), ALIGN_LEFT,VERTICAL_CENTER, true, false);
	}
	
	public static CellStyle getStyle_Right(Workbook wb) {
		return getCellStyle(wb, getFont_Nor_11(wb), ALIGN_RIGHT,VERTICAL_CENTER, true, false);
	}
	
	public static CellStyle getStyle_NoBorder(Workbook wb) {
		return getCellStyle(wb, getFont_Nor_11(wb), ALIGN_LEFT,VERTICAL_CENTER, false, false);
	}
	
	public static CellStyle getStyle_Right(Workbook wb,short type) {
		CellStyle cellStyle = getCellStyle(wb, getFont_Nor_11(wb), ALIGN_RIGHT,VERTICAL_CENTER, true, false);
		cellStyle.setDataFormat(type);
		return cellStyle;
	}
	
	public static CellStyle getStyle_Bold_10(Workbook wb) {
		return getCellStyle(wb, getFont_Bold_10(wb), ALIGN_CENTER,VERTICAL_CENTER, true, false);
	}

	public static CellStyle getStyle_Bold_15(Workbook wb) {
		return getCellStyle(wb, getFont_Bold_15(wb), ALIGN_CENTER,VERTICAL_CENTER, false, false);
	}
	
	public static Font getFont_Nor_10(Workbook wb) {
		return getFont(wb, (short)10, null, false, false);
	}
	
	private static Font getFont_Nor_11(Workbook wb) {
		return getFont(wb, (short)11, null, false, false);
	}
	
	public static Font getFont_Bold_10(Workbook wb) {
		return getFont(wb, (short)10, null, true, false);
	}
	
	public static Font getFont_Bold_15(Workbook wb) {
		return getFont(wb, (short)15, null, true, false);
	}

	public static CellStyle getCellStyle(Workbook wb, Font font, Short align,
			Short verAlign, boolean border, boolean wrapText) {
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setFont(font);
		if (align != null) {
			cellStyle.setAlignment(align);
		}
		if (verAlign != null) {
			cellStyle.setVerticalAlignment(verAlign);
		}
		if (border) {
			setBorder(cellStyle);
		}
		if (wrapText) {
			cellStyle.setWrapText(true);
		}
		return cellStyle;
	}

	public static Font getFont(Workbook wb, short fontSize, Short color,
			boolean bold, boolean underline) {
		Font font = wb.createFont();
		font.setFontHeightInPoints(fontSize);
		if (bold) {
			font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		}
		if (underline) {
			font.setUnderline((byte) 1);
		}
		if (color != null) {
			font.setColor(color);
		}
		return font;
	}

	private static void setBorder(CellStyle style) {
		// 设置边框
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	}
}
