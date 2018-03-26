package com.zhimu.dao.entity.system;

/**
 * 类名称：用户
 */
public class User {
	private String USER_ID; // 用户id
	private String USERNAME; // 系统用户名
	private String PASSWORD; // 密码
	private String NAME; // 姓名
	private String SEX; // 性别
	private String CS_DATE;// 出生日期
	private String IDCARD;// 身份证号
	private String ZZMM;// 政治面貌
	private String XL;// 学历
	private String ZW;// 职务
	private String SBCARD;// 社保卡号
	private String ROLE_ID; // 角色id
	private String ROLENAME;// 角色名称

	private String LAST_LOGIN; // 最后登录时间
	private String IP; // 用户登录ip地址
	private String STATUS; // 状态
	private String SKIN; // 皮肤
	private String IS_ONLINE;// 是否在线
	private String IS_PARTY;
	private String MZ;
	private String JG;
	private String CG_DATE;
	private String RD_DATE;
	private String RD_ZZ_DATE;
	private String PICTURES_PATH;
	private String RIGHTS; // 权限
	private Role role; // 角色对象
	private Page page; // 分页对象
	private String pId;
	private String TYPE;// 用户类型（1：系统用户2：外部单位用户）
	private String userLevel;// 用户所属层级
	private String schoolId;// 学校ID
	private String schoolName;// 学校名称

	public String getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getTYPE() {
		return TYPE;
	}

	public void setTYPE(String TYPE) {
		this.TYPE = TYPE;
	}

	public String getSKIN() {
		return SKIN;
	}

	public void setSKIN(String sKIN) {
		SKIN = sKIN;
	}

	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}

	public String getUSERNAME() {
		return USERNAME;
	}

	public void setUSERNAME(String uSERNAME) {
		USERNAME = uSERNAME;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String nAME) {
		NAME = nAME;
	}

	public String getRIGHTS() {
		return RIGHTS;
	}

	public void setRIGHTS(String rIGHTS) {
		RIGHTS = rIGHTS;
	}

	public String getROLE_ID() {
		return ROLE_ID;
	}

	public void setROLE_ID(String rOLE_ID) {
		ROLE_ID = rOLE_ID;
	}

	public String getLAST_LOGIN() {
		return LAST_LOGIN;
	}

	public void setLAST_LOGIN(String lAST_LOGIN) {
		LAST_LOGIN = lAST_LOGIN;
	}

	public String getIP() {
		return IP;
	}

	public void setIP(String iP) {
		IP = iP;
	}

	public String getSTATUS() {
		return STATUS;
	}

	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Page getPage() {
		if (page == null)
			page = new Page();
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getIS_ONLINE() {
		return IS_ONLINE;
	}

	public void setIS_ONLINE(String iS_ONLINE) {
		IS_ONLINE = iS_ONLINE;
	}

	public String getROLENAME() {
		return ROLENAME;
	}

	public void setROLENAME(String rOLENAME) {
		ROLENAME = rOLENAME;
	}

	public String getIS_PARTY() {
		return IS_PARTY;
	}

	public void setIS_PARTY(String iS_PARTY) {
		IS_PARTY = iS_PARTY;
	}

	public String getSEX() {
		return SEX;
	}

	public void setSEX(String sEX) {
		SEX = sEX;
	}

	public String getMZ() {
		return MZ;
	}

	public void setMZ(String mZ) {
		MZ = mZ;
	}

	public String getJG() {
		return JG;
	}

	public void setJG(String jG) {
		JG = jG;
	}

	public String getCS_DATE() {
		return CS_DATE;
	}

	public void setCS_DATE(String cS_DATE) {
		CS_DATE = cS_DATE;
	}

	public String getCG_DATE() {
		return CG_DATE;
	}

	public void setCG_DATE(String cG_DATE) {
		CG_DATE = cG_DATE;
	}

	public String getRD_DATE() {
		return RD_DATE;
	}

	public void setRD_DATE(String rD_DATE) {
		RD_DATE = rD_DATE;
	}

	public String getRD_ZZ_DATE() {
		return RD_ZZ_DATE;
	}

	public void setRD_ZZ_DATE(String rD_ZZ_DATE) {
		RD_ZZ_DATE = rD_ZZ_DATE;
	}

	public String getPICTURES_PATH() {
		return PICTURES_PATH;
	}

	public void setPICTURES_PATH(String pICTURES_PATH) {
		PICTURES_PATH = pICTURES_PATH;
	}

	public String getIDCARD() {
		return IDCARD;
	}

	public void setIDCARD(String IDCARD) {
		this.IDCARD = IDCARD;
	}

	public String getZZMM() {
		return ZZMM;
	}

	public void setZZMM(String ZZMM) {
		this.ZZMM = ZZMM;
	}

	public String getXL() {
		return XL;
	}

	public void setXL(String XL) {
		this.XL = XL;
	}

	public String getZW() {
		return ZW;
	}

	public void setZW(String ZW) {
		this.ZW = ZW;
	}

	public String getSBCARD() {
		return SBCARD;
	}

	public void setSBCARD(String SBCARD) {
		this.SBCARD = SBCARD;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}

}
