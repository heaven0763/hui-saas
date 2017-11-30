package com.chuangbang.base.service.hotel;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.HotelModel;
import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.hotel.HotelDynamicDao;
import com.chuangbang.base.dao.hotel.SiteImgDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelDynamic;
import com.chuangbang.base.entity.hotel.SiteImg;
import com.chuangbang.base.entity.user.Message;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.img.DrawImageUtil;
import com.chuangbang.framework.util.page.PageBean;

/**
 * 酒店动态Service
 * @author heaven
 * @version 2016-12-07
 */
@Component
@Transactional(readOnly = true)
public class HotelDynamicService extends BaseService<HotelDynamic,HotelDynamicDao> {

	@Autowired
	private HotelDynamicDao hotelDynamicDao;
	@Autowired
	private HotelDao hotelDao;
	@Autowired
	private SiteImgDao siteImgDao;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private CusQueryService cusQueryService;
	
	public HotelDynamic getEntity(Long id) {
		return hotelDynamicDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelDynamic(HotelDynamic hotelDynamic) {
		
		if(hotelDynamic.getId()==null){
			HotelModel hotel = this.hotelService.getHotel(hotelDynamic.getHotelId());
			hotelDynamic.setCreateDate(new Date());
			hotelDynamic.setCreateUserId(AccountUtils.getCurrentUserId());
			hotelDynamic.setForward(0);
			hotelDynamic.setShare(0);
			hotelDynamic.setComments(0);
			hotelDynamic.setHoteLogo(hotel.getThumbImg());
			hotelDynamic.setArea(hotel.getCityText());
			hotelDynamic.setSite(hotel.getHotelName());
		}
		
		String thmimgs = "";
		if(StringUtils.isNotBlank(hotelDynamic.getImgs())){
			String [] dimgs = hotelDynamic.getImgs().split(",");
			for (String img : dimgs) {
				if(StringUtils.isNotBlank(img)){
					try {
						String imageFileName = System.getProperty(Constant.WORKDIR)+img.substring(img.indexOf("static"));
						File file = new File(imageFileName);
						String newPath = file.getParent()+"/dthumb_"+file.getName();
						newPath = newPath.replace("\\", "/");
						System.out.println("newPath>>>>>>"+newPath);
						DrawImageUtil.zoomImage(file, newPath, 200,0);
						String dthumbImg = Constant.DOMAIN+newPath.substring(newPath.indexOf("/static"));
						if(StringUtils.isBlank(thmimgs)){
							thmimgs = dthumbImg;
						}else{
							thmimgs += ","+dthumbImg;
						}
						if("1".equals(hotelDynamic.getIscase())){
							String thumbImg = Constant.DOMAIN+DrawImageUtil.zoomImage(imageFileName, "medium", 0.5).substring(img.indexOf("/static")-1).replace("\\", "/");
							String littleImg = Constant.DOMAIN+DrawImageUtil.zoomImage(imageFileName, "small", 0.2).substring(img.indexOf("/static")-1).replace("\\", "/");
							SiteImg siteImg = new SiteImg(hotelDynamic.getHotelId(), "HOTEL", hotelDynamic.getHotelId(), "EXTPIC", img, thumbImg, littleImg, 999, new Date(), "HUIZHANGGUI");
							this.siteImgDao.save(siteImg);
						}
					} catch (IOException e) {
					}
				}
			}
		}
		hotelDynamic.setThmimgs(thmimgs);
		hotelDynamicDao.save(hotelDynamic);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		HotelDynamic hotelDynamic = hotelDynamicDao.findOne(id);
		if(StringUtils.isNotBlank(hotelDynamic.getImgs())){
			String [] dimgs = hotelDynamic.getImgs().split(",");
			for (String img : dimgs) {
				if(StringUtils.isNotBlank(img)){
					String imageFileName = System.getProperty(Constant.WORKDIR)+img.substring(img.indexOf("/static"));
					FileUtils.deleteFile(imageFileName);
					if("1".equals(hotelDynamic.getIscase())){
						List<SiteImg> siteImgs = this.siteImgDao.findByOriginalImg(img);
						for (SiteImg siteImg : siteImgs) {
							String mediumFileName = System.getProperty(Constant.WORKDIR)+siteImg.getThumbImg().substring(siteImg.getThumbImg().indexOf("/static"));
							FileUtils.deleteFile(mediumFileName);
							String smallFileName = System.getProperty(Constant.WORKDIR)+siteImg.getLittleImg().substring(siteImg.getLittleImg().indexOf("/static"));
							FileUtils.deleteFile(smallFileName);
							this.siteImgDao.delete(siteImg);
						}
					}
				}
			}
		}
		if(StringUtils.isNotBlank(hotelDynamic.getThmimgs())){
			String [] thmimgs = hotelDynamic.getThmimgs().split(",");
			for (String img : thmimgs) {
				if(StringUtils.isNotBlank(img)){
					String imageFileName = System.getProperty(Constant.WORKDIR)+img.substring(img.indexOf("/static"));
					FileUtils.deleteFile(imageFileName);
				}
			}
		}
		hotelDynamicDao.delete(id);
	}
	
	
	public List<HotelDynamic> getPageHotelDynamicList(PageBean<HotelDynamic> pageBean) {
		String columstr =DynamicSqlHelper.getMappingColumnStr("m.", HotelDynamic.class);
		columstr = columstr.replace("m.hotel_name hotelName", "h.hotel_name hotelName");
		columstr = columstr.replace("m.hote_logo hoteLogo", "h.original_img hoteLogo");
		String fromWhere = " from hui_hotel_dynamic m left join hui_hotel h on h.id=m.hotel_id"
				+ " where 1=1 ";
		pageBean.setSort("m.create_date");
		pageBean.setOrder("desc");
		return cusQueryService.page(pageBean, columstr+fromWhere, HotelDynamic.class,null);
	} 
	
	
}
