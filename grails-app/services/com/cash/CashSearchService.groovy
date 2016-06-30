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
        sqlString = sqlString + " AND a.organization_id = " + params.organization

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }

        if (params.status != '' && params.status != null) {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.date != '' && params.date != null) {
            sqlString = sqlString + " AND a.date_created BETWEEN '" + params.date + " 00:00:00' \
                 AND '" + params.date + " 23:59:59'"
        }

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        def result = db.rows(sqlString)
        return result;

    }

    def retrieveDisbursableTransactions(def organization) {

        def db = new Sql(dataSource) 

        def sqlString = "SELECT a.id as id, \
            a.cash_voucher_number as cashVoucherNumber, \
            a.approval_status as approvalStatus, \
            a.status as status, \
            a.date_created as dateCreated, \
            (SELECT party.name FROM party where party.party_id = a.preparedBy) as preparedBy, \
            (SELECT party.name FROM party where party.party_id = a.requestedBy) as requestedBy, \
            (SELECT party.name FROM party where party.party_id = a.payee_id) as payee, \
            a.total as total, \
            a.trans_type as transType \
            FROM cash_voucher a \
            WHERE a.approval_status = 'Approved' \
            AND a.status = 'Submitted' \
            AND a.organization_id = " + organization

        def result = db.rows(sqlString)

        return result

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
        sqlString = sqlString + " AND a.organization_id = " + params.organization

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }

        if (params.status != '' && params.status != null) {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.date != '' && params.date != null) {
            sqlString = sqlString + " AND a.date_created BETWEEN '" + params.date + " 00:00:00' \
                 AND '" + params.date + " 23:59:59'"
        }

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        def result = db.rows(sqlString)

        return result;

    }

    def liquidationSearchService(def params) {

        def db = new Sql(dataSource)

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'liquidation_number'
        
        def sqlString = "SELECT a.id as id, \
            a.liquidation_number as liquidationNumber, \
            (SELECT cash_voucher.cash_voucher_number FROM cash_voucher where cash_voucher.id = a.cash_voucher_id) as cashVoucher, \
            a.approval_status as approvalStatus, \
            a.status as status, \
            a.date_created as dateCreated, \
            (SELECT party.name FROM party where party.party_id = a.preparedBy) as preparedBy \
            FROM liquidation a"

        params.liquidationNumber = (params.liquidationNumber) ? params.liquidationNumber : ''
        sqlString = sqlString + " WHERE a.liquidation_number LIKE '%" + params.liquidationNumber + "%'"
        sqlString = sqlString + " AND a.organization_id = " + params.organization

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }

        if (params.status != '' && params.status != null) {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.date != '' && params.date != null) {
            sqlString = sqlString + " AND a.date_created BETWEEN '" + params.date + " 00:00:00' \
                 AND '" + params.date + " 23:59:59'"
        }

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        
        def result = db.rows(sqlString)

        return result;

    }

    def retrieveReplenishableTransactions(def organization) {

        def db = new Sql(dataSource) 

        def sqlString = "SELECT a.trans_id as id, \
            a.trans_number as transactionNo, \
            a.amount as amount, \
            a.change as change, \
            a.date_created as dateCreated, \
            a.type as type \
            FROM replenishment_trans_view a \
            WHERE a.organization_id = " + organization

        sqlString = sqlString + " ORDER BY a.date_created"

        def result = db.rows(sqlString)

        return result

    }

    def replenishmentSearchService(def params) {

        def db = new Sql(dataSource)

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'replenishment_number'
        
        def sqlString = "SELECT a.id as id, \
            a.replenishment_number as replenishmentNumber, \
            a.approval_status as approvalStatus, \
            a.status as status, \
            a.date_created as dateCreated, \
            (SELECT party.name FROM party where party.party_id = a.preparedBy) as preparedBy \
            FROM replenishment a"

        params.replenishmentNumber = (params.replenishmentNumber) ? params.replenishmentNumber : ''
        sqlString = sqlString + " WHERE a.replenishment_number LIKE '%" + params.replenishmentNumber + "%'"
        sqlString = sqlString + " AND a.organization_id = " + params.organization

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }

        if (params.status != '' && params.status != null) {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.date != '' && params.date != null) {
            sqlString = sqlString + " AND a.date_created BETWEEN '" + params.date + " 00:00:00' \
                 AND '" + params.date + " 23:59:59'"
        }

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        
        def result = db.rows(sqlString)

        return result;

    }


}

