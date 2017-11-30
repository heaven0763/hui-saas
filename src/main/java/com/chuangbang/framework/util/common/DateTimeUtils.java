package com.chuangbang.framework.util.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.SystemUtils;
import org.apache.commons.lang3.time.FastDateFormat;

public class DateTimeUtils {
	
	public static final String PATTERN_TO_MONTH = "yyyy-MM";
	
	public static final String PATTERN_TO_DAY = "yyyy-MM-dd";
	
	public static final String PATTERN_TO_HOUR = "yyyy-MM-dd HH";
	
	public static final String PATTERN_TO_MINUTE = "yyyy-MM-dd HH:mm";
	
	public static final String PATTERN_TO_SECOND = "yyyy-MM-dd HH:mm:ss";
	
	public static final String PATTERN_ZH_DATE = "yyyy年MM月dd日";
	
	public static final String PATTERN_ZH_MINUTE = "yyyy年MM月dd日 HH时mm分";
	
	public static final String PATTERN_HOURE_MINUTE = "HH:mm";
	
	private static final FastDateFormat monthFormatter = FastDateFormat.getInstance(PATTERN_TO_MONTH);
	
	private static final FastDateFormat dayFormatter = FastDateFormat.getInstance(PATTERN_TO_DAY);
	
	private static final FastDateFormat hourFormatter = FastDateFormat.getInstance(PATTERN_TO_HOUR);
	
	private static final FastDateFormat minuteFormatter = FastDateFormat.getInstance(PATTERN_TO_MINUTE);
	
	private static final FastDateFormat secondFormatter = FastDateFormat.getInstance(PATTERN_TO_SECOND);
	
	private static final FastDateFormat hourMinuteFormatter = FastDateFormat.getInstance(PATTERN_HOURE_MINUTE);
	
	private static final FastDateFormat zhDayFormatter = FastDateFormat.getInstance(PATTERN_ZH_DATE);
	
	private static final FastDateFormat zhMinuteFormatter = FastDateFormat.getInstance(PATTERN_ZH_MINUTE);
	
	public static String toMonth(Date date){
		return date == null? "":monthFormatter.format(date);
	}
	
	public static String toDay(Date date){
		return date == null? "":dayFormatter.format(date);
	}
	
	public static String toHour(Date date){
		return date == null? "":hourFormatter.format(date);
	}
	
	public static String toMinute(Date date){
		return date==null? "":minuteFormatter.format(date);
	}
	
	public static String toSecond(Date date){
		return date == null? "":secondFormatter.format(date);
	}
	
	public static String toHourAndMinute(Date date){
		return date == null? "":hourMinuteFormatter.format(date);
	}
	
	public static String toZHDay(Date date){
		return date == null? "":zhDayFormatter.format(date);
	}
	
	public static String toZHMinute(Date date){
		return date == null? "":zhMinuteFormatter.format(date);
	}
	
	
	/**
	 * 获取当前日期，格式 yyyy-MM-dd 
	 * @return
	 */
	public static String getCurrentDate() {
		return toDay(new Date());
	}
	
	
	/**
	 * 获取当前日期，格式 yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static String getCurrentTimeStamp() {
		return toSecond(new Date());
	}
	
	public static String getFirstDayOfMonth(){
		return toMonth(new Date()) +"-01";
	}
	
	public static String getLastDayOfMonth(){
		return toMonth(new Date()) + "-" +Calendar.getInstance().getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	public static String getLastMonthDay( Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int year = 0;
        int month = cal.get(Calendar.MONTH)+1; // 上个月月份
        // int day1 = cal.getActualMinimum(Calendar.DAY_OF_MONTH);//起始天数
        int day = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 结束天数
        System.out.println("###last month:" + month);
        if (month == 0) {
            year = cal.get(Calendar.YEAR) - 1;
            month = 12;
        } else {
            year = cal.get(Calendar.YEAR);
        }
        String mon = (month/10)>0?month+"":"0"+month;
        String endDay = year + "-" + mon + "-" + day;
        return endDay;
    }
	public static String getCurtMonth( Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int month = cal.get(Calendar.MONTH)+1; // 上个月月份
        String mon = (month/10)>0?month+"":"0"+month;
        return mon;
    }
	
	public static String getCurtYear( Date date) {
		Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int year = cal.get(Calendar.YEAR);
        return year+"";
    }
	
	public Integer getAge(Date birthday) {
		Integer age = null;
		Calendar cal = Calendar.getInstance();

		if (birthday == null || cal.before(birthday)) {
			return null;
		}

		int yearNow = cal.get(Calendar.YEAR);
		int monthNow = cal.get(Calendar.MONTH);
		int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
		cal.setTime(birthday);

		int yearBirth = cal.get(Calendar.YEAR);
		int monthBirth = cal.get(Calendar.MONTH);
		int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);

		age = yearNow - yearBirth;

		if (monthNow <= monthBirth) {
			if (monthNow == monthBirth) {
				if (dayOfMonthNow < dayOfMonthBirth) {
					age--;
				}
			} else {
				age--;
			}
		}
		return age;
	}
	
	public static int getDiffMonths(Date oldDate){
		Calendar cal = Calendar.getInstance();
		if (oldDate == null || cal.before(oldDate)) {
			return 0;
		}
		int yearNow = cal.get(Calendar.YEAR);
		int monthNow = cal.get(Calendar.MONTH);
		int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
		cal.setTime(oldDate);
		int yearOld = cal.get(Calendar.YEAR);
		int monthOld = cal.get(Calendar.MONTH);
		int dayOfMonthOld = cal.get(Calendar.DAY_OF_MONTH);
		int diffMonth = (yearNow - yearOld) *12 + (monthNow - monthOld);
		if(dayOfMonthNow <= dayOfMonthOld){
			diffMonth -- ;
		}
		return diffMonth;
	}
	
	public static Date getLastMonth() throws Exception{
		SimpleDateFormat format = new SimpleDateFormat(PATTERN_TO_SECOND); 
		
		Calendar cal=Calendar.getInstance(); 

		cal.add(Calendar.DATE, -1);    //得到前一天 
		cal.add(Calendar.MONTH, -1);    //得到前一个月 

		long date = cal.getTimeInMillis(); 

		Date kk=format.parse(format.format(new Date(date)));
		return kk; 
	}
	
	/**  
     *  返回毫秒  
     *    
     *  @param  date  
     *                        日期  
     *  @return  返回毫秒  
     */  
   public  static  long  getMillis(java.util.Date  date)  {  
       java.util.Calendar  c  =  java.util.Calendar.getInstance();  
       c.setTime(date);  
       return  c.getTimeInMillis();  
   }  
   
   public static void main(String[] args) throws Exception {
	   System.out.println(getFirstDayOfMonth());
	   System.out.println(getLastDayOfMonth());
	   System.out.println(getFirstDayOfLastMonth());
	   List<String> s = getMonthBetween("2017-09-17","2017-10-17");
	   System.out.println(s.toString());
	   for (String string : s) {
		   System.out.println(string);
	   }
   }

   public static String getFirstDayOfLastMonth() {
	   try {
			return toMonth(getLastMonth()) +"-01";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

public static Date string2Date(String strDate, String pattern) {
	   if (strDate == null || strDate.equals("")) {
		   throw new RuntimeException("str date null");
	   }
	   if (pattern == null || pattern.equals("")) {
		   pattern = DateTimeUtils.PATTERN_TO_SECOND;
	   }
	   SimpleDateFormat sdf = new SimpleDateFormat(pattern);
	   Date date = null;

	   try {
		   date = sdf.parse(strDate);
	   } catch (ParseException e) {
		   throw new RuntimeException(e);
	   }
	   return date;
   }
   
   /**  
    * 计算两个日期之间相差的天数  
    * @param smdate 较小的时间 
    * @param bdate  较大的时间 
    * @return 相差天数 
    * @throws ParseException  
    */    
   public static int daysBetween(Date smdate,Date bdate) throws ParseException    
   {    
	   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
	   smdate=sdf.parse(sdf.format(smdate));  
	   bdate=sdf.parse(sdf.format(bdate));  
	   Calendar cal = Calendar.getInstance();    
	   cal.setTime(smdate);    
	   long time1 = cal.getTimeInMillis();                 
	   cal.setTime(bdate);    
	   long time2 = cal.getTimeInMillis();         
	   long between_days=(time2-time1)/(1000*3600*24);  

	   return Integer.parseInt(String.valueOf(between_days));           
   }    

   /** 
    *字符串的日期格式的计算 
    */  
   public static int daysBetween(String smdate,String bdate) throws ParseException{  
	   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
	   Calendar cal = Calendar.getInstance();    
	   cal.setTime(sdf.parse(smdate));    
	   long time1 = cal.getTimeInMillis();                 
	   cal.setTime(sdf.parse(bdate));    
	   long time2 = cal.getTimeInMillis();         
	   long between_days=(time2-time1)/(1000*3600*24);  

	   return Integer.parseInt(String.valueOf(between_days));     
   }
   public static List<String> getMonthBetween(String minDate, String maxDate){
	    ArrayList<String> result = new ArrayList<String>();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");//格式化为年月

	    Calendar min = Calendar.getInstance();
	    Calendar max = Calendar.getInstance();
	    
	    try {
			min.setTime(sdf.parse(minDate));
			min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);

		    max.setTime(sdf.parse(maxDate));
		    max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);

		    Calendar curr = min;
		    while (curr.before(max)) {
		     result.add(sdf.format(curr.getTime()));
		     curr.add(Calendar.MONTH, 1);
		    }
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
	    return result;
	  }
}
