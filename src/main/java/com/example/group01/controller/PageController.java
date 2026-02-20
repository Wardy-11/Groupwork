package com.example.group01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/courses")
    public String coursesPage() {
        return "courses";
    }
}