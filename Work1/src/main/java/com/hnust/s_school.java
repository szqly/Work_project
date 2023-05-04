package com.hnust;

public class s_school {
    private int id;
    private String schoolname;

    @Override
    public String toString() {
        return "s_school{" +
                "id=" + id +
                ", schoolname='" + schoolname + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSchoolname() {
        return schoolname;
    }

    public void setSchoolname(String schoolname) {
        this.schoolname = schoolname;
    }
}
