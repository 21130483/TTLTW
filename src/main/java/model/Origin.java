package model;

public class Origin {


    private int originID;
    private String name;

    public Origin() {
    }

    public int getOriginID() {
        return originID;
    }

    public void setOriginID(int originID) {
        this.originID = originID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Origin{" +
                "originID=" + originID +
                ", name='" + name + '\'' +
                '}';
    }
}
