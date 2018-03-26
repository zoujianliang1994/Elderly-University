package com.zhimu.dao.entity.cms;

import java.util.ArrayList;
import java.util.List;

public class Navigation {
  private String ID;
  private String ENAME;
  private String NAME;
  private String PARENT_ID;
  private String PATH;
  private String SORT;
  private String STATUS;
  private List<Navigation> sonList = new ArrayList<Navigation>();


  public String getID() {
    return ID;
  }

  public void setID(String ID) {
    this.ID = ID;
  }

  public String getENAME() {
    return ENAME;
  }

  public void setENAME(String ENAME) {
    this.ENAME = ENAME;
  }

  public String getNAME() {
    return NAME;
  }

  public void setNAME(String NAME) {
    this.NAME = NAME;
  }

  public String getPARENT_ID() {
    return PARENT_ID;
  }

  public void setPARENT_ID(String PARENT_ID) {
    this.PARENT_ID = PARENT_ID;
  }

  public String getPATH() {
    return PATH;
  }

  public void setPATH(String PATH) {
    this.PATH = PATH;
  }

  public String getSORT() {
    return SORT;
  }

  public void setSORT(String SORT) {
    this.SORT = SORT;
  }

  public String getSTATUS() {
    return STATUS;
  }

  public void setSTATUS(String STATUS) {
    this.STATUS = STATUS;
  }

  public List<Navigation> getSonList() {
    return sonList;
  }

  public void setSonList(List<Navigation> sonList) {
    this.sonList = sonList;
  }
}
