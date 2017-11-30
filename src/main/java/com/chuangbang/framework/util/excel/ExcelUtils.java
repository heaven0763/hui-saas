package com.chuangbang.framework.util.excel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.service.system.SystemParameterService;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.google.common.collect.Maps;

@Component
public class ExcelUtils {

	@Autowired
	private SystemParameterService systemParameterService;
	
	
	public static final String STYLE_TITLE = "title";
	
	public static final String STYLE_HEADER = "head";
	
	public static final String STYLE_CONENT = "content";
	
	public static final String STYLE_FOOT = "foot";
	
	public static final String STYLE_CURRENTY = "currency";
	public static final String STYLE_NUMBER = "NUMBER";
	private static final int MIN_CELL_WIDTH = 3500;
	
	private static final int MIN_CELL_HEIGHT = 350;
	
	public  Workbook exportCommonExcel(List objects,String title,List<ExcelModel> excelModels) {
		return exportCommonExcel(new HSSFWorkbook(),objects, title, excelModels, null);
	}
	
	public Workbook exportCommonExcel(Workbook wb,List objects,String title,List<ExcelModel> excelModels,
			Map<String,CellStyle> cellStyleMap) {
		long start = System.currentTimeMillis();
		int rowIndex = 0;
		Map<String, CellStyle> styles = Maps.newHashMap();
		// 初始化所有CellStyle
		initALlStyles(wb,cellStyleMap,styles);
		Map<String,String> addressMap = Maps.newHashMap();
		/*// 将所有镇街装进Map里面
		initaddressMap(addressMap);*/
		// 创建工作表.
		Sheet sheet = wb.createSheet("sheet");
		//合并单元格
		if(StringUtils.isNotBlank(title)){
			int shell = 65+excelModels.size()-1;
			String shetstr = "$A$1:$"+(char)shell+"$1";
			sheet.addMergedRegion(CellRangeAddress.valueOf(shetstr));
		}
		// 产生标题
		rowIndex = generateTitle(sheet, title,styles,rowIndex);
		// 产生表头
		rowIndex = generateSecondHeader(sheet,styles,rowIndex,excelModels);
		// 产生内容
		rowIndex = generateContent(objects,sheet,styles,rowIndex,excelModels,addressMap);
		// 产生表尾
		//rowIndex = generateFoot(sheet,styles,rowIndex);
		System.out.println("excel耗时》》》"+(System.currentTimeMillis() - start));
		return wb;
	}
	
	private void initaddressMap(Map<String, String> addressMap) {
		String depCode = systemParameterService.getValueByCode("depCode");
		String depName = systemParameterService.getValueByCode("depName");
		addressMap.put(depCode, depName);
	}

	private  int generateTitle(Sheet sheet, String title,Map<String, CellStyle> styles, int rowIndex) {
		if(StringUtils.isNotBlank(title)){
			Row row = sheet.createRow(rowIndex++);
			CellUtils.createCell(row, 0, title, styles.get(STYLE_TITLE));
			row.setHeight((short) 750);
		}
		return rowIndex;
	}
	
	private  int generateSecondHeader(Sheet sheet, Map<String, CellStyle> styles,int rowIndex,List<ExcelModel> excelModels) {
		if(excelModels == null || excelModels.size() < 1){
			return rowIndex;
		}
		int cellIndex = 0;
		ExcelModel firstExcelModel = excelModels.get(0);
		Row row = sheet.createRow(rowIndex++);
		int height = firstExcelModel.getHeight() == null? MIN_CELL_HEIGHT :firstExcelModel.getHeight();
		row.setHeight((short)height);
		for(ExcelModel excelModel:excelModels){
			if(excelModel.getWidth() !=null){	//如果有传入宽度参数
				sheet.setColumnWidth(cellIndex , excelModel.getWidth());
			}else{
				sheet.setColumnWidth(cellIndex , MIN_CELL_WIDTH);
			}
			CellUtils.createCell(row, cellIndex++, excelModel.getHeadName(), styles.get(STYLE_HEADER));
		}
		return rowIndex;
	}
	
	private  int generateContent(List<Object> objects,Sheet sheet, Map<String, CellStyle> styles,int rowIndex,
			List<ExcelModel> excelModels,Map<String, String> addressMap) {
		// 为空或者小于1的时候表示未查询到数据，不填充
		if (objects == null || objects.size() < 1 || excelModels == null) {
			return rowIndex;
		}
		Row row = null;
		int rowIndexTemp = rowIndex;
		ExcelModel firstExcelModel = excelModels.get(0);
		int cellIndex = 0;
		for(ExcelModel excelModel:excelModels){
			rowIndex = rowIndexTemp;
			for (Object object:objects) {
				row = sheet.getRow(rowIndex) ==null? sheet.createRow(rowIndex):sheet.getRow(rowIndex);	//生成新的一行
				int height = firstExcelModel.getHeight() == null? MIN_CELL_HEIGHT :firstExcelModel.getHeight();
				row.setHeight((short)height);
				try {
					String propertyValue = BeanUtils.getProperty(object, excelModel.getProperty());
					switch (excelModel.cellStyle) {
					case NUMBER:
						propertyValue = StringUtils.isBlank(propertyValue)? "0":propertyValue;
						CellUtils.createCell(row, cellIndex, Long.valueOf(propertyValue),styles.get(STYLE_NUMBER));
						break;
					case CURRENTY:
						propertyValue = StringUtils.isBlank(propertyValue)? "0.00":propertyValue;
						CellUtils.createCell(row, cellIndex, Double.valueOf(propertyValue),styles.get(STYLE_CURRENTY));
						break;
					case DEPT:
						propertyValue = addressMap.get(propertyValue);
						CellUtils.createCell(row, cellIndex, propertyValue,styles.get(STYLE_CONENT));
						break;
					case DATE:
						if(StringUtils.isNotBlank(propertyValue)){
							propertyValue=DateTimeUtils.toSecond(DateTimeUtils.string2Date(propertyValue, DateTimeUtils.PATTERN_TO_SECOND));
						}
						CellUtils.createCell(row, cellIndex, propertyValue,styles.get(STYLE_CONENT));
						break;
					default:
						propertyValue = StringUtils.isBlank(propertyValue)? "":propertyValue;
						CellUtils.createCell(row, cellIndex, propertyValue,styles.get(STYLE_CONENT));
						break;
					}
				} catch (Exception e) {
					e.printStackTrace();
				} 
				rowIndex++;
			}
			cellIndex++;
		}
		return rowIndex;
	}

	public  void initALlStyles(Workbook wb, Map<String, CellStyle> cellStyleMap, Map<String, CellStyle> styles){
		if(cellStyleMap != null && cellStyleMap.get(STYLE_CONENT) != null){
			styles.put(STYLE_CONENT, cellStyleMap.get(STYLE_CONENT));
		}else{
			styles.put(STYLE_CONENT, ExcelStyleUtils.getStyle_Nor_10(wb));
		}
		if(cellStyleMap != null && cellStyleMap.get(STYLE_HEADER) != null){
			styles.put(STYLE_HEADER, cellStyleMap.get(STYLE_HEADER));
		}else{
			styles.put(STYLE_HEADER, ExcelStyleUtils.getStyle_Bold_10(wb));
		}
		if(cellStyleMap != null && cellStyleMap.get(STYLE_TITLE) != null){
			styles.put(STYLE_TITLE, cellStyleMap.get(STYLE_TITLE));
		}else{
			styles.put(STYLE_TITLE, ExcelStyleUtils.getStyle_Bold_15(wb));
		}
		styles.put(STYLE_CURRENTY, ExcelStyleUtils.getStyle_CurrencyStyle(wb));
		styles.put(STYLE_NUMBER,ExcelStyleUtils.getStyle_Int(wb));
	}
	
	
	public Workbook excel(List objects,String title,List<ExcelModel> excelModels,
			Map<String,CellStyle> cellStyleMap) throws FileNotFoundException, IOException{

		String filename = System.getProperty(Constant.WORKDIR)+"/UpFiles/trip/template/template.xls";
		HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(filename));
		Map<String, CellStyle> styles = Maps.newHashMap();
		// 初始化所有CellStyle
		initALlStyles(workbook,cellStyleMap,styles);
		int rowIndex = 0;
		//按名引用excel工作表
		//也可以用以下方式来获取excel的工作表，采用工作表的索引值
		HSSFSheet sheet = workbook.getSheetAt(0);
		rowIndex = generateTitle(sheet, title,styles,rowIndex);
		// 产生内容
		rowIndex = generateContent(objects,sheet,styles,rowIndex+2,excelModels,null);
		
		return workbook;

	}
                                                                                                             
    public static List<Map<String,Object>> readExcelFile(String filePath){  
    	
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();  
        HSSFWorkbook workbook;  
        try {  
            FileInputStream excelFile = new FileInputStream(filePath);  
            workbook = new HSSFWorkbook(excelFile);  
            //读入Excel文件的第一个表  
            HSSFSheet sheet = workbook.getSheetAt(0);  
           /* Map<Integer,String> titles = Maps.newHashMap();
            for(int i=1;i<=2;i++){ 
            	 HSSFRow row = sheet.getRow(i);  
                 if(row==null){  
                     continue;  
                 }  
                 for(int j=1;j<=row.getPhysicalNumberOfCells();j++){  
                     if(row.getCell(j)!=null){  
                         // 注意：一定要设成这个，否则可能会出现乱码  
//                       row.getCell(j).setEncoding(HSSFCell.ENCODING_UTF_16);  
                         String str = getCellValue(row.getCell(j));  
                         if(StringUtils.isNotBlank(str)){
                        	 titles.put(j, str);
                         }  
                     }  
                 }
            }
            System.out.println(titles.toString());*/
            //从文件第4行开始读取，第一行为标识行  
            for(int i=3;i<=sheet.getLastRowNum();i++){  
//                System.out.println("行数："+sheet.getPhysicalNumberOfRows());  
                HSSFRow row = sheet.getRow(i);  
                if(row==null){  
                    continue;  
                }  
                Map<String,Object> map = new HashMap<String,Object>();  
                for(int j=0;j<=row.getPhysicalNumberOfCells();j++){  
                    if(row.getCell(j)!=null){  
                        // 注意：一定要设成这个，否则可能会出现乱码  
//                      row.getCell(j).setEncoding(HSSFCell.ENCODING_UTF_16);  
                        String str = getCellValue(row.getCell(j));  
                        map.put(j+"",str);  
                    }  
                }
                list.add(map);
            }  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
            System.out.println("【Excel路径有误，请重新确认Excel路径...】");  
        } catch (IOException e) {  
            e.printStackTrace();  
            System.out.println("【文件输入有误，请重新确定您要加入的文件...】");  
        }  
        return list;
    }  
                                                                                                             
    //传入cell的值，进行cell值类型的判断，并返回String类型  
     private static String getCellValue(HSSFCell cell){  
            String value = null;  
            //简单的查检列类型  
//            System.out.println("cell.getCellType():"+cell.getCellType());  
            switch(cell.getCellType())  {  
                case HSSFCell.CELL_TYPE_STRING://字符串  
//                    System.out.println("HSSFCell.CELL_TYPE_STRING:"+HSSFCell.CELL_TYPE_STRING);  
                    value = cell.getRichStringCellValue().toString();  
                    break;  
                case HSSFCell.CELL_TYPE_NUMERIC://数字  
//                    System.out.println("HSSFCell.CELL_TYPE_NUMERIC:"+HSSFCell.CELL_TYPE_NUMERIC);  
                    long dd = (long)cell.getNumericCellValue();  
                    value = dd+"";  
                    break;  
                case HSSFCell.CELL_TYPE_BLANK:  
//                    System.out.println("HSSFCell.CELL_TYPE_BLANK:"+HSSFCell.CELL_TYPE_BLANK);  
                    value = "";  
                    break;     
                case HSSFCell.CELL_TYPE_FORMULA:  
//                    System.out.println("HSSFCell.CELL_TYPE_FORMULA:"+HSSFCell.CELL_TYPE_FORMULA);  
                    value = String.valueOf(cell.getCellFormula());  
                    break;  
                case HSSFCell.CELL_TYPE_BOOLEAN://boolean型值  
//                    System.out.println("HSSFCell.CELL_TYPE_BOOLEAN:"+HSSFCell.CELL_TYPE_BOOLEAN);  
                    value = String.valueOf(cell.getBooleanCellValue());  
                    break;  
                case HSSFCell.CELL_TYPE_ERROR:  
//                    System.out.println("HSSFCell.CELL_TYPE_ERROR:"+HSSFCell.CELL_TYPE_ERROR);  
                    value = String.valueOf(cell.getErrorCellValue());  
                    break;  
                default:  
//                    System.out.println("default");  
                    break;  
            }  
            return value;  
        }
	
}
