package com.saisiot.userinfo;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import java.awt.print.PrinterException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.saisiot.userinfo.biz.UserinfoBiz;
import com.saisiot.userinfo.dto.UserinfoDto;
import com.saisiot.userinfo.recapthca.*;

@Controller
public class HomeController {

	@Autowired
	private UserinfoBiz biz;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model, HttpSession session) {

		model.addAttribute("list", biz.selectList());
		session.getAttribute("dto");

		return "list";
	}

	@RequestMapping("/insertform.do")
	public String insertForm() {

		return "insert";
	}

	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	public String insert(@ModelAttribute UserinfoDto dto) {

		int res = biz.insert(dto);

		if (res > 0) {
			return "redirect:list.do";
		} else {
			return "redirect:insertform.do";
		}

	}

	@RequestMapping(value = "/select.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String select(Model model, String email) {

		model.addAttribute("dto", biz.selectOne(email));

		return "select";
	}
	@RequestMapping(value="/updateform.do")
	public String updateform(Model model, String email) {
		
		model.addAttribute("dto",biz.selectOne(email));	
		
		return "updateform";
	}
	
	@RequestMapping(value="/update.do", method = RequestMethod.POST)
	public String update(@ModelAttribute UserinfoDto dto) {
		
		int res = biz.update(dto);
		
		if(res > 0) {
			return "redirect:list.do";
		} else {
			return "redirect:updateform.do";
		}
		
	}
	
	
	@RequestMapping("/delete.do")
	public String delete(String email) {
		
		int res = biz.delete(email);
		
		if(res>0) {
			return "redirect:list.do";
		}else {
			return "redirect:list.do";
		}

	}
	
	@RequestMapping("/selectOne.do")
	public String selectOne(Model model, String email) {
		
		UserinfoDto dto = biz.selectOne(email);
		
		model.addAttribute("dto", dto);
		
		return "selectOne";
		
	}
	
	@RequestMapping("/login.do")
	public String loginForm() {
		return "login";
	}
	
	
	@RequestMapping(value= "/logingo.do", method = {RequestMethod.POST})
	public String login(String email, @RequestParam("pw") String password, HttpSession session) {
		
		String returnURL = "";
		
		System.out.println("+++++++++++++++++++");
		System.out.println(email);
		System.out.println(password);
		
		UserinfoDto dto = biz.login(email, password);
		
		if(session.getAttribute("login")!=null) {
			session.removeAttribute("login");
		}
		
		try {
			if(dto.getEmail().equals(email) && dto.getPassword().equals(password)) {
				System.out.println("------------로그인 성공-------------");	
				
				
					
				int res = biz.lastloginupdate(dto);
					
				System.out.println(res);
				if(res>0) {
					System.out.println("마지막 로그인 시간 변경");
					System.out.println("휴면계정 상태 (1 : 휴면 X , 2: 휴면 O) : " + dto.getUsercondition());
					if(dto.getUsercondition()==1) {
						session.setAttribute("login", dto);
						System.out.println("휴면계정이 아닙니다.");
						returnURL = "redirect:homepage.do";
					}else if(dto.getUsercondition()==2) {
						System.out.println("휴면계정입니다.");
						session.setAttribute("login", dto);
						returnURL = "condition";
					}
						
					
				}else {
					System.out.println("마지막 로그인 변경 실패");
					returnURL = "login";
				}
				
			}else{
				System.out.println("----------로그인 실패1-----------");
				returnURL = "login";
			}
		}catch(Exception e) {
			System.out.println("----------로그인 실패2-----------");
			returnURL = "login";
		}
			return returnURL;
	}
	

	@RequestMapping(value = "/homepage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String homepage(Model model, HttpSession session) {
		
		session.getAttribute("login");
		
		
		return "homepage";
	}
	
	
	@RequestMapping("/logout.do")
	public String logout(String email, String password, HttpSession session) {
		

			session.invalidate();
			//session.removeAttribute("login");
			return "login";
	}
		

	
	@RequestMapping(value = "/userinsert.do", method = {RequestMethod.POST})
	public String insertuser(@ModelAttribute UserinfoDto dto){
		
		System.out.println(dto.getBirthdate());
		
		try {
			int res = biz.insert(dto);
			System.out.println(res);
			if(res>0) {
				System.out.println("회원가입 성공");
				return "redirect:login.do";
			}else {
				System.out.println("회원가입 실패");
				return "redirect:login.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 실패");		
			return "redirect:login.do";
		}
		
		
			
	}
	
	@RequestMapping(value = "/kakaologinajax.do", method = {RequestMethod.POST})
	@ResponseBody
	public String kakaologin(String email, String password, String name, HttpSession session) {
		
		String returnURL = "";
		
		try {
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			
			
			if(session.getAttribute("login")!=null) {
				session.removeAttribute("login");
			}
				
		
			try {
				
				UserinfoDto dto = new UserinfoDto(email,password,null,null,null,name,null,null,null,0,1);
				int res = biz.kakaoinsert(dto);
				if(res>0) {
					System.out.println("카카오 회원가입 성공");
			
				}else {
					System.out.println("카카오 회원가입 실패");
				}
				UserinfoDto kakao = biz.kakaologin(email, password, name);
				System.out.println("-------카카오 로그인 성공1--------");
				int res2 = biz.lastloginupdate(kakao);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", kakao);
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}

				
			} catch (Exception e) {
				e.printStackTrace();
				UserinfoDto kakao = biz.kakaologin(email, password, name);
				System.out.println("--------카카오 로그인 성공1-1----------");
				int res2 = biz.lastloginupdate(kakao);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", kakao);
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}
			}	

		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			UserinfoDto kakao = biz.kakaologin(email, password, name);
			System.out.println("-------카카오 로그인 성공2-------");
			int res2 = biz.lastloginupdate(kakao);
			
			System.out.println(res2);
			if(res2>0) {
				System.out.println("-------마지막 로그인 시간 변경--------");
				session.setAttribute("login", kakao);
				returnURL = "redirect:homepage.do";
			}else {
				System.out.println("-------마지막 로그인 변경 실패--------");
				returnURL = "login";
			}
		}	

		return returnURL;
	}
	
	
	@RequestMapping(value = "/naverloginajax.do", method = {RequestMethod.POST})
	@ResponseBody
	public String naverlogin(String email, String password, String name, HttpSession session) {
		
		String returnURL = "";
		
		try {
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			
			if(session.getAttribute("login")!=null) {
				session.removeAttribute("login");
			}
		
			try {
				
				UserinfoDto dto = new UserinfoDto(email,password,null,null,null,name,null,null,null,0,1);
				int res = biz.kakaoinsert(dto);
				if(res>0) {
					System.out.println("네이버 회원가입 성공");
			
				}else {
					System.out.println("네이버 회원가입 실패");
				}
				UserinfoDto naver = biz.kakaologin(email, password, name);
				System.out.println("-------네이버 로그인 성공1--------");
				int res2 = biz.lastloginupdate(naver);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", naver);
					System.out.println(naver + "왜 안돼는거야");
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}

				
			} catch (Exception e) {
				e.printStackTrace();
				UserinfoDto naver = biz.kakaologin(email, password, name);
				System.out.println("--------네이버 로그인 성공1-1----------");
				int res2 = biz.lastloginupdate(naver);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", naver);
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}
			}	

		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			UserinfoDto naver = biz.kakaologin(email, password, name);
			System.out.println("-------네이버 로그인 성공2-------");
			int res2 = biz.lastloginupdate(naver);
			
			System.out.println(res2);
			if(res2>0) {
				System.out.println("-------마지막 로그아웃 시간 변경--------");
				session.setAttribute("login", naver);
				returnURL = "redirect:homepage.do";
			}else {
				System.out.println("-------마지막 로그아웃 변경 실패--------");
				returnURL = "login";
			}
		}	

		return returnURL;
	}
	
	
	@RequestMapping("/mailgo.do")
	public String mailgo() {
		
		return "mailsend";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailsend.do" , method = {RequestMethod.POST})
	public String mailSending(HttpServletRequest request, Model model, String email, String randomcode ) {
		
			String setfrom = "cjscjstmddjs@gamil.com";         
		    String tomail  = email;     // 받는 사람 이메일
		    String title   = "사이시옷 인증메일 입니다.";      // 제목
		    String content = randomcode;    // 내용
		    
		    System.out.println("메인인증 코드 컨트롤러 : "+ tomail);
		    System.out.println("메일인증 번호 : " + content);
		    
		    
		    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     // 받는사람 이메일
		      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
		      messageHelper.setText(content);  // 메일 내용
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		    
		    return content;
		  }

	
	@RequestMapping(value = "/callback.do")
	public String navLogin(HttpServletRequest request) throws Exception {  
		return "callback";
	}
	
	@ResponseBody
	@RequestMapping(value = "VerifyRecaptcha.do", method = RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		VerifyRecaptcha.setSecretKey("6LfiDJcUAAAAACHgKUqYeKcg8Otw7qgkc-JVSFPT");
	    String gRecaptchaResponse = request.getParameter("recaptcha");
        System.out.println("리캡쳐!!!!!!" + gRecaptchaResponse);
	        //0 = 성공, 1 = 실패, -1 = 오류
	        try {
	            if(VerifyRecaptcha.verify(gRecaptchaResponse))
	                return 0;
	            else return 1;
	        } catch (IOException e) {
	            e.printStackTrace();
	            return -1;
	        }
	 }

	@ResponseBody
	@RequestMapping(value = "/emailcheck.do", method = RequestMethod.POST)
	public String emailCheck(String email, Model model) {
		
		String returnURL = "";
		
		System.out.println("----------------------");
		System.out.println(email);
		
		try {
			UserinfoDto dto = biz.emailcheck(email);
			
			if(dto.getEmail().equals(email)) {
				System.out.println("중복된 이메일입니다.");
				returnURL = "0";
			}else if(!dto.getEmail().equals(email)) {
				System.out.println("사용가능한 이메일입니다-1.");
				returnURL = "1";
			}
		} catch (Exception e) {
			System.out.println("사용가능한 이메일입니다-2.");
			returnURL = "1";
		}
		
		System.out.println(returnURL);
		return returnURL;
	}
	
	@RequestMapping("/jusoPopup.do")
	public String jusoPopup() {
		
		
		return "jusoPopup";
	}
	
	@RequestMapping("/emailpwFind.do")
	public String idpwFind() {
		
		return "emailpwFind";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/emailpwFindgo.do", method = RequestMethod.POST)
	public String idpwFindgo(String mail) throws ParseException {
		
		String returnURL = "";
		System.out.println(mail);
			
		
		try {
			
			UserinfoDto dto = biz.emailpwfind(mail);
			
			if(dto.getEmail().equals(mail)) {
				
				int res = biz.passupdate(dto);
				
				if(res>0) {
				
				String setfrom = "cjscjstmddjs@gamil.com";         
			    String tomail  = mail;     // 받는 사람 이메일
			    String title   = "안녕하세요?^^ 사이시옷입니다..";      // 제목
			    String content = "사이시옷의 비밀번호가 초기화 되었습니다 : 123456789";    // 내용
			    
			    System.out.println("비밀번호 초기화 코드 컨트롤러 : "+ tomail);
			    System.out.println("비밀번호 초기화 : " + content);
			    
			    
			    try {
			      MimeMessage message = mailSender.createMimeMessage();
			      MimeMessageHelper messageHelper 
			                        = new MimeMessageHelper(message, true, "UTF-8");
			 
			      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
			      messageHelper.setTo(tomail);     // 받는사람 이메일
			      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			      messageHelper.setText(content);  // 메일 내용
			     
			      mailSender.send(message);
			    } catch(Exception e){
			      System.out.println(e);
			    }
			    
			    return content;
				
				}else {
					
					returnURL = "0";
				}
			    
			    
			}else {
				
				returnURL = "1";
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
			returnURL = "1";
		}
		
		
		return returnURL;
	}
	
	
	
} 

