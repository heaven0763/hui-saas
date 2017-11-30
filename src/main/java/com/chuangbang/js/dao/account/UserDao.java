package com.chuangbang.js.dao.account;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.js.entity.account.User;

/**
 * 用户对象的Dao interface.
 * 
 * @author Heaven
 */
public interface UserDao extends PagingAndSortingRepository<User, String>, BaseRepository<User, String> {

	List<User> findByRname(String rName);

	User findByMobile(String mobile);

	User findByUsername(String username);

	User findByHotelIdAndGroupIdAndPosition(String hotelId, Long groupId, String position);

	List<User> findByCompanyId(Long companyId);

	List<User> findByHotelIdAndGroupId(String hotelId, Long groupId);

	List<User> findByPhtlidAndGroupId(Long pid, Long groupId);

	List<User> findByState(String string);

	List<User> findByStateAndHotelId(String string, String hid);

	User findByEmail(String email);

}
