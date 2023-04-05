package net.softsociety.exam.domain;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 회원 정보 (시큐리티를 사용한 회원 인증에 사용)
 * UserDetails 인터페이스를 implements
 * 
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member implements UserDetails {
	private static final long serialVersionUID = 3222388532456457383L;

	String mem_id;
	String mem_password;
	String mem_nickname;
	String mem_email;
	String mem_phone;
	String mem_gender;
	String mem_address;
	String mem_role;
	String mem_joindate;
	boolean mem_state;
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public String getPassword() {
		return this.mem_password;
	}
	
	@Override
	public String getUsername() {
		return this.mem_id;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return this.mem_state;
	
	}







}
