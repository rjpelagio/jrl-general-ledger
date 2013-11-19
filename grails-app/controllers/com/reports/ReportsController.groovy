package com.reports
import grails.converters.JSON
import com.gl.AcctgPeriod

class ReportsController {

    def wtBalance = {
        
    }
    def glHistory = {
        
    }
    def balSheet = {

    }

    def incomeSheet = {
        
    }
    def showjson = {
        def acctgPeriod = AcctgPeriod.get(params.id)
        render acctgPeriod as JSON
    }
}
