DROP TABLE USERINFO PURGE;

CREATE TABLE USERINFO(	
	EMAIL VARCHAR2(100) PRIMARY KEY,
	PASSWORD VARCHAR2(100) NOT NULL,
	GENDER CHAR(2) CHECK(GENDER IN ('M','W')),
	JOINDATE DATE,
	BIRTHDATE DATE,
	USERNAME VARCHAR2(100),
	VISITDATE DATE,
	PWDATE DATE,
	ADDR VARCHAR2(4000),
	COINNO NUMBER(38),
	USERCONDITION NUMBER(2) CHECK(USERCONDITION IN (1,2))
);

INSERT INTO USERINFO VALUES('admin', '1234', 'M', SYSDATE, '1994-05-02','관리자', SYSDATE, SYSDATE, '경기도 수원시', 10000, 1);
INSERT INTO USERINFO VALUES('admin2', '1234', 'M', SYSDATE, '1994-05-02','관리자2', SYSDATE, SYSDATE, '경기도 수원시', 10000, 2);

SELECT * FROM USERINFO;