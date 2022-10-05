package bit.data.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class QnaAnswerDto {
	private int answer_num;
	private int user_num;
	private String message;
	private Timestamp writeday;
	private int qna_num;
}
