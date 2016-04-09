package com.cash

import groovy.sql.Sql
import java.text.SimpleDateFormat

class CashSearchService {

    static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def cashVoucherSearchService(def params) {

        def db = new Sql(dataSource)

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'cash_voucher_number'

        def fields = [:]
        
        def sqlString = "SELECT a.id as id, \
        	a.cash_voucher_number as cashVoucherNumber, \
        	a.approval_status as approvalStatus, \
        	a.status as status, \
        	a.date_created as dateCreated, \
        	(SELECT party.name FROM party where party.party_id = a.preparedBy) as preparedBy, \
        	(SELECT party.name FROM party where party.party_id = a.requestedBy) as requestedBy \
        	FROM cash_voucher a"

        params.cashVoucherNumber = (params.cashVoucherNumber) ? params.cashVoucherNumber : ''
        sqlString = sqlString + " WHERE a.cash_voucher_number LIKE '%" + params.cashVoucherNumber + "%'"
        sqlString = sqlString + " AND a.trans_type = 'CASH_ADVANCE'"

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }

        if (params.status != '' && params.status != null) {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.dateCreated != '' && params.dateCreated != null) {
            sqlString = sqlString + " AND a.date_created = '" + params.dateCreated + "'"
        }

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        def result = db.rows(sqlString)
        return result;

    }

    def reimbursmentSearchService(def params) {

        def db = new Sql(dataSource)

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'cash_voucher_number'
        
        def sqlString = "SELECT a.id as id, \
            a.cash_voucher_number as cashVoucherNumber, \
            a.approval_status as approvalStatus, \
            a.status as status, \
            a.date_created as dateCreated, \
            (SELECT party.name FROM party where party.party_id = a.preparedBy) as preparedBy, \
            (SELECT party.name FROM party where party.party_id = a.requestedBy) as requestedBy \
            FROM cash_voucher a"


        params.cashVoucherNumber = (params.cashVoucherNumber) ? params.cashVoucherNumber : ''
        sqlString = sqlString + " WHERE a.cash_voucher_number LIKE '%" + params.cashVoucherNumber + "%'"
        sqlString = sqlString + " AND a.trans_type = 'REIMBURSEMENT'"

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }

        if (params.status != '' && params.status != null) {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.dateCreated != '' && params.dateCreated != null) {
            sqlString = sqlString + " AND a.date_created = '" + params.dateCreated + "'"
        }

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        def result = db.rows(sqlString)

        return result;

    }

    def liquidationSearchService(def params) {

        String cashVoucherNo = "%%"
        if(params.cashVoucherNo){
            cashVoucherNo = "%" + params.cashVoucherNo + "%"
        }

        def db = new Sql(dataSource)

        params.order = (params.order) ? params.order : 'desc'
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
            (a.cash_voucher_number LIKE '" + cashVoucherNo + "' \
            AND a.approval_status = 'Approved' \
            AND a.status = 'Submitted' \
            OR a.date_created = " + params.dateCreated + ") \
            AND a.trans_type = 'CASH_ADVANCE' \
            ORDER BY " + params.sort + " " + params.order

        def result = db.rows(sqlString)

        return result;

    }

    def disbursementSearchService(def params) {


        

    }


}

