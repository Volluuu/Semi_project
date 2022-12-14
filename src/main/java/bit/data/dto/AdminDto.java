package bit.data.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class AdminDto {
    private int user_num;
    private int cafe_num;
    private int food_num;
    private int trip_num;
    private int qna_num;
    private String subject;
    private String content;
    private String answer;
    private Timestamp writeday;
    private int acount;
}
