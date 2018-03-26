package com.zhimu.service.manager.edu.teacherLesson;

import com.zhimu.commons.utils.PageData;

import java.util.Map;

public interface TeacherLessonManager {

  void insertTeacherZcSk(PageData pd) throws Exception;

  Map<String, Object> teacherLessonList(PageData pd) throws Exception;

}
