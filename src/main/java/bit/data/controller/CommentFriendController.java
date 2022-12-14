package bit.data.controller;

import bit.data.dto.CommentFriendDto;
import bit.data.service.CommentFriendServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CommentFriendController {

    @Autowired
    CommentFriendServiceInter commentFriendService;

    @GetMapping("/commentfriend/list")
    @ResponseBody
    public List<CommentFriendDto> commentfriendlist(int find_num){
        return commentFriendService.selectAllComments(find_num);
    }
    @GetMapping("/commentfriend/insert")
    @ResponseBody
    public void insertcommentfriend(CommentFriendDto dto,
                                    @RequestParam(defaultValue = "0") int regroup,
                                    @RequestParam(defaultValue = "0") int relevel,
                                    @RequestParam(defaultValue = "0") int restep,
                                    @RequestParam(defaultValue = "0") int diff
    ) {

        if(regroup==0){
            regroup=commentFriendService.selectMaxNum(dto.getFind_num())+1;
            restep=1000;
            relevel=0;
            dto.setDiff(0);
        }else if(diff==0){
            diff=commentFriendService.selectMaxDiff(dto.getFind_num());
            relevel++;
            dto.setDiff(diff+1);
        }else {
            commentFriendService.updateRestepDiff(regroup, diff, restep);

//            restep=commentFriendService.selectMaxRestep(dto.getFind_num(), regroup, diff)+1;
            restep++;
            relevel++;
            dto.setDiff(diff);

        }

//        }else{
//            restep--;
//            commentFriendService.updateRestepRelevel(regroup, relevel, restep);
//            commentFriendService.updateRestepMinus(regroup, restep);
//            relevel++;
//            dto.setDiff(1);
//        }
        dto.setRegroup(regroup);
        dto.setRestep(restep);
        dto.setRelevel(relevel);
        commentFriendService.insertComment(dto);
    }

    @GetMapping("/commentfriend/delete")
    @ResponseBody
    public void deletecommentfriend(int friend_num) {
//        String path=request.getSession().getServletContext().getRealPath("/resources/upload");
//        System.out.println(path);

        //????????? ?????? ?????? ?????? ?????????
        //???????????? ??????
//        String photo=answerService.getAnswer(idx).getPhoto();
        //File ?????? ??????
//        File file=new File(path+"/"+photo);
//        if(file.exists()) {//????????? ???????????? true, ????????? false
//            System.out.println("????????? ??????????????? ???????????????");
//            file.delete();
//        }

        commentFriendService.deleteByNum(friend_num);
    }

    @GetMapping("/commentfriend/update")
    @ResponseBody
    public void updatecommentfriend(CommentFriendDto dto){
        commentFriendService.updateCommentFriend(dto);
    }

    //    ?????? ?????? ?????? ????????? ??? dto ????????????
    @GetMapping("/commentfriend/updateform")
    @ResponseBody
    public CommentFriendDto updateform(int friend_num){
        CommentFriendDto dto=commentFriendService.selectCommentByNum(friend_num);
        return dto;

    }

    @GetMapping("/commentfriend/updateok")
    @ResponseBody
    public void updateok(CommentFriendDto dto){
        commentFriendService.updateCommentFriend(dto);
    }
}
