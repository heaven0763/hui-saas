package com.chuangbang.js.vo;

import java.util.List;

import com.google.common.collect.Lists;


public class FileVo {
	private String filecode;
	private String filename;
	private String fileurl;
	private String filetype;
	private Long filespace;
	private Integer fileNum;
	private List<FileVo> fileVos = Lists.newArrayList();
	
	
	public FileVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public FileVo(String filecode, String filename, String fileurl, String filetype) {
		super();
		this.filecode = filecode;
		this.filename = filename;
		this.fileurl = fileurl;
		this.filetype = filetype;
	}


	public FileVo(String filecode, String filename, String fileurl, String filetype, List<FileVo> fileVos) {
		super();
		this.filecode = filecode;
		this.filename = filename;
		this.fileurl = fileurl;
		this.filetype = filetype;
		this.fileVos = fileVos;
	}
	public String getFilecode() {
		return filecode;
	}
	public void setFilecode(String filecode) {
		this.filecode = filecode;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public List<FileVo> getFileVos() {
		return fileVos;
	}
	public void setFileVos(List<FileVo> fileVos) {
		this.fileVos = fileVos;
	}
	public Long getFilespace() {
		return filespace;
	}
	public void setFilespace(Long filespace) {
		this.filespace = filespace;
	}

	public Integer getFileNum() {
		return fileNum;
	}


	public void setFileNum(Integer fileNum) {
		this.fileNum = fileNum;
	}


	@Override
	public String toString() {
		return "FileVo [filecode=" + filecode + ", filename=" + filename + ", fileurl=" + fileurl + ", filetype="
				+ filetype + ", fileVos=" + (fileVos==null?0:fileVos.size()) + "]";
	}
	
	
	
	

}
