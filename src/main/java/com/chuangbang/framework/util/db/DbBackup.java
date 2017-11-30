package com.chuangbang.framework.util.db;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Date;

import org.apache.log4j.Logger;

public class DbBackup {
    public static Logger logger = Logger.getLogger(DbBackup.class);
    public static boolean exp(String connString,String filename){
        Process proc = null;
        StringBuffer errorInfo = new StringBuffer();
        String[] cmds  =   new  String[ 3 ];
        cmds[ 0 ]  =   " cmd " ;
        cmds[ 1 ]  =   " /C " ;
        cmds[ 2 ] = "exp connString file=filename.dmp log=filename.log";

        
        System.out.println("filename："+filename );
        
        StringBuffer sb = new StringBuffer();
        sb.append("exp "+connString+" file="+filename+".dmp log="+filename+".log");
        
        cmds[ 2 ] = sb.toString();
        System.out.println("命令："+cmds[ 2 ] );
        try {
            proc = Runtime.getRuntime().exec(cmds[2].toString());
            InputStream istr = proc.getErrorStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(istr));
            String str;
            while ((str = br.readLine()) != null) {
                errorInfo.append(str + "\n");
            }
            proc.waitFor();
        } catch (Exception e) {
        	e.printStackTrace();
        	logger.error(e);
        }
        if (proc.exitValue() == 0) {
            proc.destroy();
            return true;
        } else {
            if (logger.isDebugEnabled())
                logger.error(errorInfo);
            proc.destroy();
            return false;
        }
    }
    public static void main(String[] args) {
        //System.out.println(exp());
    	String date = new Date().toLocaleString();
    	date = date.substring(0,date.indexOf(" "));
    	System.out.println(date+"("+new Date().getTime()+")");
    	
    	System.out.println(Long.parseLong(null));
    }
}