package Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Gyurin
 */
@Controller
public class controller {


    @RequestMapping("/")
    public String home(){
        return "home";
    }

    /*
    @RequestMapping(value = "/")
    public String test(){
        return "index";
    }*/

}