package com.chuangbang.base.service.hotel;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.hql.internal.ast.tree.FromElement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.SiteImgModel;
import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.dao.hotel.SiteImgDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelDynamic;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.SiteImg;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.img.DrawImageUtil;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 场地图片Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class SiteImgService extends BaseService<SiteImg,SiteImgDao> {

	@Autowired
	private SiteImgDao siteImgDao;
	@Autowired
	private HotelDao hotelDao;
	@Autowired
	private HotelPlaceDao hotelPlaceDao;
	@Autowired
	private CusQueryService cusQueryService;
	
	public SiteImg getEntity(Long id) {
		return siteImgDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveSiteImg(SiteImg siteImg,Long hotelId,String siteType,Long siteId,String picType,String imgs,String from) throws IOException {
		String img[] = imgs.split(",");
		for (String image : img) {
			String imageFileName = System.getProperty(Constant.WORKDIR)+image.substring(image.indexOf("/static"));
			String thumbImg = Constant.DOMAIN+DrawImageUtil.zoomImage(imageFileName, "medium", 0.5).substring(imageFileName.indexOf("static")-2).replace("\\", "/");
			String littleImg = Constant.DOMAIN+DrawImageUtil.zoomImage(imageFileName, "small", 0.2).substring(imageFileName.indexOf("static")-2).replace("\\", "/");
			SiteImg stImg = new SiteImg(hotelId, siteType, siteId, picType, image,thumbImg, littleImg, 999, new Date(), from);
			siteImgDao.save(stImg);
		}
	}
	
	@Transactional(readOnly = false)
	public void saveSiteImg(SiteImg siteImg) {
		siteImgDao.save(siteImg);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		SiteImg siteImg = this.siteImgDao.findOne(id);
		if(siteImg.getPicType().equals("COVER")){
			siteImg.setPicType("BASEPIC");
			siteImgDao.save(siteImg);
		}else{
			String ofileName =System.getProperty(Constant.WORKDIR)+ siteImg.getOriginalImg().substring(siteImg.getOriginalImg().indexOf("static"));
			String lfileName =System.getProperty(Constant.WORKDIR)+ siteImg.getLittleImg().substring(siteImg.getLittleImg().indexOf("static"));
			String otfileName =System.getProperty(Constant.WORKDIR)+ siteImg.getThumbImg().substring(siteImg.getThumbImg().indexOf("static"));
			FileUtils.deleteFile(ofileName);
			FileUtils.deleteFile(lfileName);
			FileUtils.deleteFile(otfileName);
			siteImgDao.delete(siteImg);
		}
	}
	
	public List<SiteImg> findBySiteIdAndSiteType(Long siteId,String siteType){
		return siteImgDao.findBySiteIdAndSiteType(siteId,siteType);
	}
	
	public List<SiteImg> findByHotelId(Map<String, Object> filterParams){
		List<String> sorts = Lists.newArrayList();
		sorts.add("hotelId");
		sorts.add("siteType");
		sorts.add("picType");
		return this.getEntities(filterParams, new Sort(Direction.ASC, sorts));
	}
	
	@Transactional(readOnly = false)
	public void cover(Long id) {
		SiteImg siteImg = siteImgDao.findOne(id);
		this.batchUpdateSiteType(siteImg.getSiteId(), siteImg.getSiteType(), "COVER", "BASEPIC");
		if(siteImg.getSiteType().equals("HOTEL")){
			Hotel hotel = this.hotelDao.findOne(siteImg.getSiteId());
			hotel.setOriginalImg(siteImg.getOriginalImg());
			hotel.setThumbImg(siteImg.getLittleImg());
			this.hotelDao.save(hotel);
		}else if(siteImg.getSiteType().equals("HALL")){
			HotelPlace hotelPlace = this.hotelPlaceDao.findOne(siteImg.getSiteId());
			hotelPlace.setOriginalImg(siteImg.getOriginalImg());
			hotelPlace.setThumbImg(siteImg.getLittleImg());
			this.hotelPlaceDao.save(hotelPlace);
		}else if(siteImg.getSiteType().equals("ROOM")){
			HotelPlace hotelPlace = this.hotelPlaceDao.findOne(siteImg.getSiteId());
			hotelPlace.setOriginalImg(siteImg.getOriginalImg());
			hotelPlace.setThumbImg(siteImg.getLittleImg());
			this.hotelPlaceDao.save(hotelPlace);
		}else{
		}
		siteImg.setPicType("COVER");
		this.siteImgDao.save(siteImg);
	}
	
	public void batchUpdateSiteType(long siteId,String siteType,String pictype,String npictype){
		String nnq="update hui_site_img set pic_type=? where site_id=? and site_type=? and pic_type=?";
		List<Object> params = Lists.newArrayList();
		params.add(npictype);
		params.add(siteId);
		params.add(siteType);
		params.add(pictype);
		this.siteImgDao.executeNativeSQL(nnq, params);
	}

	public List<SiteImg> findBySiteIdAndSiteTypeAndNum(Long siteId, String siteType, int size) {
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_siteId", siteId);
		filterParams.put("EQ_siteType", siteType);
		return this.getEntities(filterParams, 0, size, new Sort(Direction.ASC, "sortOrder")).getContent();
		//return null;
	}
	
	
	public List<SiteImgModel> getPageSiteImgList(PageBean<SiteImgModel> pageBean) {
		String columstr =DynamicSqlHelper.getMappingColumnStr("s.", SiteImgModel.class);
		columstr = columstr.replace("s.ptypes", "t.ptypes");
		columstr = columstr.replace("s.timgs", "t.timgs");
		columstr = columstr.replace("s.utime", "t.utime");
		columstr = columstr.replace("s.imgnum", "t.imgnum");
		String fromWhere = " FROM hzg_saas.hui_site_view s left join hui_imgs_view t on t.site_type = s.type and t.site_id = s.id"
				+ " where 1=1 ";
		pageBean.setSort("t.site_type_id,s.id");
		pageBean.setOrder("asc,asc");
		return cusQueryService.page(pageBean, columstr+fromWhere, SiteImgModel.class,null);
	}

	public List<SiteImg> findBySiteIdAndSiteTypeAndPicType(Long id, String type, String pictype) {
		// TODO Auto-generated method stub
		if(type.equals("")){
			
		}
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_siteId", id);
		if("BASEPIC".equals(pictype)){
			filterParams.put("OR_EQ;picType", "BASEPIC,COVER");
		}else{
			filterParams.put("EQ_picType", pictype);
		}
		filterParams.put("EQ_siteType", type);
		return this.getEntities(filterParams, new Sort(Direction.ASC, "sortOrder"));
	}
	
	public List<SiteImg> findByHotelIdAndPicType(Long id,String pictype) {
		// TODO Auto-generated method stub
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_hotelId", id);
		if("BASEPIC".equals(pictype)){
			filterParams.put("OR_EQ;picType", "BASEPIC,COVER");
		}else{
			filterParams.put("EQ_picType", pictype);
		}
		return this.getEntities(filterParams, new Sort(Direction.ASC, "sortOrder"));
	}

	@Transactional(readOnly=false)
	public void sortSave(HttpServletRequest request, String imgid) {
		if(StringUtils.isNotBlank(imgid)){
			String imgids[]= imgid.split(",");
			for(String id : imgids) {
				SiteImg siteImg = siteImgDao.findOne(Long.valueOf(id));
				siteImg.setSortOrder(Integer.valueOf(request.getParameter("sortOrder"+id)));
				this.saveSiteImg(siteImg);
			}
		}
		
	}
	
	@Transactional(readOnly=false)
	public void deleteBySiteid(Long siteid,String siteType) {
		List<SiteImg> siteImgs = this.findBySiteIdAndSiteType(siteid, siteType);
		for (SiteImg siteImg : siteImgs) {
			String ofileName =System.getProperty(Constant.WORKDIR)+ siteImg.getOriginalImg().substring(siteImg.getOriginalImg().indexOf("static"));
			String lfileName =System.getProperty(Constant.WORKDIR)+ siteImg.getLittleImg().substring(siteImg.getLittleImg().indexOf("static"));
			String otfileName =System.getProperty(Constant.WORKDIR)+ siteImg.getThumbImg().substring(siteImg.getThumbImg().indexOf("static"));
			FileUtils.deleteFile(ofileName);
			FileUtils.deleteFile(lfileName);
			FileUtils.deleteFile(otfileName);
		}
		String hql =" delete from SiteImg s where s.siteType = '"+siteType+"' and s.siteId='"+siteid+"'";
		this.siteImgDao.querydelete(hql);
	}
}
