package gov.myalikov.auction.entity;

public class Bid {
    private Integer id;
    private Integer lotId;
    private Integer userId;
    private Integer price;

    public Bid(Integer id, Integer lotId, Integer userId, Integer price) {
        this.id = id;
        this.lotId = lotId;
        this.userId = userId;
        this.price = price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getLotId() {
        return lotId;
    }

    public void setLotId(Integer lotId) {
        this.lotId = lotId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Bid bid = (Bid) o;

        if (id != null ? !id.equals(bid.id) : bid.id != null) return false;
        if (lotId != null ? !lotId.equals(bid.lotId) : bid.lotId != null) return false;
        if (userId != null ? !userId.equals(bid.userId) : bid.userId != null) return false;
        return price != null ? price.equals(bid.price) : bid.price == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (lotId != null ? lotId.hashCode() : 0);
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (price != null ? price.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Bid{" +
                "id=" + id +
                ", lotId=" + lotId +
                ", userId=" + userId +
                ", price=" + price +
                '}';
    }
}
