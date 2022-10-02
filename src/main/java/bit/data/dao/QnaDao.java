package bit.data.dao;

import bit.data.dto.QnaDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class QnaDao implements QnaDaoInter {
	@Autowired
	SqlSession session;
	String ns = "bit.data.dao.QnaDao.";

	@Override
	public QnaDto getQna(int qna_num) {
		return session.selectOne(ns + "getQna");
	}

	@Override
	public int getMaxNum() {
		return session.selectOne(ns+"getMaxNum");
	}

	@Override
	public int getTotalCount(Map<String, String> map) {
		return session.selectOne(ns+"getTotalCount",map);
	}

	@Override
	public List<QnaDto> getPagingList(Map<String, Object> map) {
		return session.selectList(ns+"getPagingList",map);
	}

	@Override
	public void insertQna(QnaDto dto) {
		session.insert(ns+"insertQna",dto);
	}

/*	@Override
	public void updateRestep(Map<String, Integer> map) {
		session.update(ns+"updateRestep",map);
	}

	@Override
	public void updateReadCount(int num) {
		session.update(ns+"updateReadCount",num);
	}*/

	@Override
	public QnaDto getData(int num) {
		return session.selectOne(ns+"getData",num);
	}

	@Override
	public void updateQna(QnaDto dto) {
		session.update(ns+"updateQna",dto);
	}

	@Override
	public void deleteQna(int num) {
		session.delete(ns+"deleteQna",num);
	}
}
