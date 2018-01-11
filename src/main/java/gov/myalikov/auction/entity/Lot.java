package gov.myalikov.auction.entity;

import java.sql.Date;

public class Lot {
    private Integer id;
    private Integer ownerId;
    private String name;
    private String description;
    private Date startTime;
    private Integer step;
    private Integer startPrice;

    public Lot(Integer id, Integer ownerId, String name, String description, Date startTime, Integer step, Integer startPrice) {
        this.id = id;
        this.ownerId = ownerId;
        this.name = name;
        this.description = description;
        this.startTime = startTime;
        this.step = step;
        this.startPrice = startPrice;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }

    public Integer getStartPrice() {
        return startPrice;
    }

    public void setStartPrice(Integer startPrice) {
        this.startPrice = startPrice;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Lot lot = (Lot) o;

        if (id != null ? !id.equals(lot.id) : lot.id != null) return false;
        if (ownerId != null ? !ownerId.equals(lot.ownerId) : lot.ownerId != null) return false;
        if (name != null ? !name.equals(lot.name) : lot.name != null) return false;
        if (description != null ? !description.equals(lot.description) : lot.description != null) return false;
        if (startTime != null ? !startTime.equals(lot.startTime) : lot.startTime != null) return false;
        if (step != null ? !step.equals(lot.step) : lot.step != null) return false;
        return startPrice != null ? startPrice.equals(lot.startPrice) : lot.startPrice == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (ownerId != null ? ownerId.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (startTime != null ? startTime.hashCode() : 0);
        result = 31 * result + (step != null ? step.hashCode() : 0);
        result = 31 * result + (startPrice != null ? startPrice.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Lot{" +
                "id=" + id +
                ", ownerId=" + ownerId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", startTime=" + startTime +
                ", step=" + step +
                ", startPrice=" + startPrice +
                '}';
    }
}
