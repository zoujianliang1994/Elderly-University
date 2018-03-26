package com.zhimu.commons.constant;

/**
 * 班级常量枚举类
 */
public enum ClassConstant {
    /**
     * 班主任
     */
    HEAD_TEACHER(1,"班主任"),
    /**
     * 任课老师
     */
    OTHER_TEACHER(2,"任课老师"),
    /**
     * 学生
     */
    STUDENT(3,"学生");

    private ClassConstant(Integer value, String name){
        this.value = value;
        this.name = name;
    }
    private final Integer value;
    private final String name;

    public Integer getValue() {
        return value;
    }

    public String getName() {
        return name;
    }
}
