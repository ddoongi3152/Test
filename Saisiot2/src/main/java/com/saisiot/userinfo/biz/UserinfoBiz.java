package com.saisiot.userinfo.biz;

import java.util.Date;
import java.util.List;

import com.saisiot.userinfo.dto.UserinfoDto;

public interface UserinfoBiz {
	public List<UserinfoDto> selectList();
	public UserinfoDto selectOne(String email);
	public int insert(UserinfoDto dto);
	public int update(UserinfoDto dto);
	public int delete(String email);
	public UserinfoDto login(String email, String password);
	public UserinfoDto kakaologin(String email, String password, String name);
	public int kakaoinsert(UserinfoDto dto);
	public int lastloginupdate(UserinfoDto dto);
	public UserinfoDto emailcheck(String email);
	public UserinfoDto emailpwfind(String email);
	public int passupdate(UserinfoDto dto);
	public int longupdate(UserinfoDto dto);
	public UserinfoDto longuser();
	
	
}
