package com.oceanviewresort.dashboard.service;

import com.oceanviewresort.dashboard.dao.DashboardDAO;

import java.util.Map;

public class DashboardService {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    public Map<String,Object> getDashboardStats(){
        return dashboardDAO.getDashboardStats();
    }
}