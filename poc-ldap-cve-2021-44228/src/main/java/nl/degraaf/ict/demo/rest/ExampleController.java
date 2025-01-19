package nl.degraaf.ict.demo.rest;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
public class ExampleController {

    @GetMapping("/example")
    public String getExample(@RequestParam(value = "name") String name) {

        log.info("ExampleController.getExample(), name {}", name);

        return "Hello World! " + name;
    }
}
