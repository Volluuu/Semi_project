package bit.data.dao;

import bit.data.dto.CafeDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CafeDao implements CafeDaoInter{
    @Autowired
    SqlSession session;

    String ns="bit.data.dao.CafeDao.";

    @Override
    public int selectTotalCount(Map<String, Object> map) {
        return session.selectOne(ns+"selectTotalCount", map);
    }

    @Override
    public void insertCafe(CafeDto dto) {
        session.insert(ns+"insertCafe",dto);
    }

    @Override
    public List<CafeDto> selectPagingList(Map<String, Object> map) {
        return session.selectList(ns+"selectPagingList", map);
    }

    @Override
    public CafeDto getCafeData(int cafe_num) {
        return session.selectOne(ns+"getCafeData",cafe_num);
    }

    @Override
    public void updateReadCount(int cafe_num) {
        session.update(ns+"updateReadCount", cafe_num);
    }

    @Override
    public void deleteCafe(int cafe_num) {
        session.delete(ns+"deleteCafe",cafe_num);
    }

    @Override
    public void updateCafe(CafeDto dto) {
        session.update(ns+"updateCafe",dto);
    }

    @Override
    public void likesInsert(int cafe_num) {
        session.insert(ns+"likesInsert",cafe_num);
    }

    @Override
    public void likesUpdate(int cafe_num) {
        session.update(ns+"likesUpdate",cafe_num);
    }

    @Override
    public CafeDto selectByNum(int cafe_num) {
        return session.selectOne(ns+"selectByNum",cafe_num);
    }

    @Override
    public List<CafeDto> selectTopList(int count) {
        return session.selectList(ns+"selectTopList", count);
    }
}
