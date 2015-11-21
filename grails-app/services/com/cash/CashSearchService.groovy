package com.cash

import groovy.sql.Sql
import java.text.SimpleDateFormat

class CashSearchService {

    static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def cashVoucherSearchService(def params) {

        String cashVoucherNo = "%%"
        if(params.cashVoucherNo){
            cashVoucherNo = "%" + params.cashVoucherNo + "%"
        }

        String approvalStatus = "%%"
        if(params.approvalStatus){
            approvalStatus = "%" + params.approvalStatus + "%"
        }

        String status = "%%"
        if(params.status){
            status = "%" + params.status + "%"
        }

        def db = new Sql(dataSource)

        params.order = (params.order) ? params.order : 'asc'
        params.sort = (params.sort) ? params.sort : 'cash_voucher_number'

        def fields = [:]
        
        def sqlString = "SELECT a.id as id, \
        	a.cash_voucher_number as cashVoucherNumber, \
        	a.approval_status as approvalStatus, \
        	a.status as status, \
        	a.date_created as dateCreated, \
        	(SELECT party.name FROM party where party.party_id = a.preparedBy) as preparedBy, \
        	(SELECT party.name FROM party where party.party_id = a.requestedBy) as requestedBy \
        	FROM cash_voucher a WHERE \
        	a.cash_voucher_number LIKE '" + cashVoucherNo + "' \
        	OR a.approval_status LIKE '" + approvalStatus + "' \
        	OR a.status LIKE '" + status + "' \
        	OR a.date_created = " + params.dateCreated + " \
        	ORDER BY " + params.sort + " " + params.order

        println sqlString

        def result = db.rows(sqlString)

        println 'Result : ' + result

        return result;

    }


}

