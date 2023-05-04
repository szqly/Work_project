package com.Class;

public class Headimg {
    private int ImgNo;
    private String StName;

    @Override
    public String toString() {
        return "Headimg{" +
                "ImgNo=" + ImgNo +
                ", StNo=" + StName +
                '}';
    }

    public int getImgNo() {
        return ImgNo;
    }

    public void setImgNo(int imgNo) {
        ImgNo = imgNo;
    }

    public String getStName() {
        return StName;
    }

    public void setStName(String stName) {
        StName = stName;
    }
}
