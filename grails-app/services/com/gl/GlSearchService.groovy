package com.gl
import groovy.sql.Sql
import com.app.*

class GlSearchService {

    static transactional = true

    def dataSource

    def serviceMethod() {

    }
    
    def getGlAccounts(String glAccount, String description, def type, GlAccount parent) {
        String newGlAccount = "%%"
        String newDescription = "%%"
        
        if(glAccount){
            newGlAccount = "%" + glAccount + "%"
        }
        if(description){
            newDescription = "%" + description + "%"
        }

        
        def result = GlAccount.executeQuery("\
            FROM GlAccount gl\
            WHERE (gl.glAccount LIKE ?\
            AND gl.description LIKE ?)", [newGlAccount, newDescription]
        )

        if(type!=null && parent!=null){
            result = GlAccount.executeQuery("\
                FROM GlAccount gl\
                WHERE (gl.glAccount LIKE ?\
                AND gl.description LIKE ?)\
                AND gl.glAccountType = ?\
                AND gl.parentGlAccount = ?", [newGlAccount, newDescription, type, parent]
            )
        }
        if(type!=null && parent==null){
            result = GlAccount.executeQuery("\
                FROM GlAccount gl\
                WHERE (gl.glAccount LIKE ?\
                AND gl.description LIKE ?)\
                AND gl.glAccountType = ?", [newGlAccount, newDescription, type]
            )
        }
        if(type==null && parent!=null){
            result = GlAccount.executeQuery("\
                FROM GlAccount gl\
                WHERE (gl.glAccount LIKE ?\
                AND gl.description LIKE ?)\
                AND gl.parentGlAccount = ?", [newGlAccount, newDescription, parent]
            )
        }

        return result
    }

     def getGlAccountTypes(String glAccountType, String description, String glAccountClass) {
        String newGlAccountType = "%%"
        String newDescription = "%%"

        if(glAccountType){
            newGlAccountType = "%" + glAccountType + "%"
        }
        if(description){
            newDescription = "%" + description + "%"
        }


        def result = GlAccountType.executeQuery("\
            FROM GlAccountType glType\
            WHERE (glType.glAccountType LIKE ?\
            AND glType.description LIKE ?)", [newGlAccountType, newDescription]
        )

        if(glAccountClass){
            result = GlAccountType.executeQuery("\
                FROM GlAccountType glType\
                WHERE (glType.glAccountType LIKE ?\
                AND glType.description LIKE ?\
                AND glAccountClass = ?)", [newGlAccountType, newDescription, glAccountClass])
        }

        return result
    }

    def getAcctgPeriod(AppOrganization organization, PeriodType periodType, Integer periodNum, String status, def year) {
        String newAcctgPeriod = "%%"
        
        def result = AcctgPeriod.executeQuery("\
            FROM AcctgPeriod acctgPeriod\
            WHERE (acctgPeriod.organization = ?)", [organization]
        )
        if(status!=null || year!=null){
            if(status=='null' && year!='null'){
                result = AcctgPeriod.executeQuery("\
                    FROM AcctgPeriod acctgPeriod\
                    WHERE (acctgPeriod.organization = ?)\
                    AND acctgPeriod.year = ?", [organization, year])
            } else if(status!='null' && year=='null'){
                result = AcctgPeriod.executeQuery("\
                    FROM AcctgPeriod acctgPeriod\
                    WHERE (acctgPeriod.organization = ?)\
                    AND acctgPeriod.status = ?", [organization, status])
            } else if(status!='null' && year!='null'){
                result = AcctgPeriod.executeQuery("\
                    FROM AcctgPeriod acctgPeriod\
                    WHERE (acctgPeriod.organization = ?)\
                    AND acctgPeriod.status = ?\
                    AND acctgPeriod.year = ?", [organization, status, year])
            }
        }
        return result
    }

    def getAcctgTrans(AppOrganization organization, def params) {

        
        def db = new Sql(dataSource)

        def sqlString = "SELECT a.id AS id, \
            a.voucher_no AS voucherNo, \
            (SELECT acctg_trans_code FROM acctg_trans_type WHERE id = a.acctg_trans_type_id) AS voucherType, \
            a.status AS status, \
            a.approval_status AS approvalStatus, \
            a.date_created AS dateCreated, \
            a.transaction_date AS transactionDate, \
            a.entry_date AS entryDate, \
            a.posted_date AS postedDate \
            FROM gl_accounting_transaction a"
            
        params.voucherNo = (params.voucherNo) ? params.voucherNo : ''
        sqlString = sqlString + " WHERE a.voucher_no LIKE '%" + params.voucherNo + "%'"

        if (params.voucherType != '' && params.voucherType != null) {
            sqlString = sqlString + " AND a.acctg_trans_type_id = " + AcctgTransType.findByAcctgTransCode(params.voucherType)
        }

        if (params.status != '' && params.status != null && params.status != 'null') {
            sqlString = sqlString + " AND a.status = '" + params.status + "'"
        }

        if (params.approvalStatus != '' && params.approvalStatus != null) {
            sqlString = sqlString + " AND a.approval_status = '" + params.approvalStatus + "'"
        }
        
        if (params.dateCreated_value != '' && params.dateCreated_value != null) {
            sqlString = sqlString + " AND a.date_created = '" + params.dateCreated_value + "'"
        }

        //params.transactionDate = (params.transactionDate) ? params.transactionDate : null
        //params.dateCreated = (params.dateCreated) ? params.dateCreated : null
        //params.entryDate = (params.entryDate) ? params.entryDate : null
        //params.postedDate = (params.postedDate) ? params.postedDate : null

        params.order = (params.order) ? params.order : 'desc'
        params.sort = (params.sort) ? params.sort : 'a.date_created'
        sqlString = sqlString + " ORDER BY " + params.sort + " " + params.order

        //sqlString = sqlString + " OFFSET " + params.offset + "ROWS "
        //sqlString = sqlString + " FETCH NEXT " + params.max + "ROWS ONLY"

        def result = db.rows(sqlString)

        return result;
    }
}
