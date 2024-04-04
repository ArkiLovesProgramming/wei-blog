package pojo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class Page {
    private int currentPage = 0;
    private int pageSize=4;
    private int totalPages;

    public void nextPage(){
        this.currentPage++;
    }
    public void lastPage(){
        this.currentPage--;
    }
}
