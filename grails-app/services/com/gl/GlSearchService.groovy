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

    def getAcctgTrans(AppOrganization organization, def particulars, def voucherno, def status, def voucherType, def transactionDate, def entryDate) {
        String newParticulars = "%%"
        String newVoucherNo = "%%"
        if(particulars){
            newParticulars = "%" + particulars + "%"
        }

        if(voucherno){
            newVoucherNo = "%" + voucherno + "%"
        }

        def result = GlAccountingTransaction.executeQuery("\
            FROM GlAccountingTransaction acctgTrans\
            WHERE (acctgTrans.organization = ?\
            AND acctgTrans.voucherNo LIKE ?\
            AND acctgTrans.description LIKE ?)", [organization, newVoucherNo, newParticulars])
        
        if(status!=null || voucherType!=null || transactionDate!=null || entryDate!=null){
            if(status!='null' && voucherType=='null'){
                result = GlAccountingTransaction.executeQuery("\
                    FROM GlAccountingTransaction acctgTrans\
                    WHERE (acctgTrans.organization = ?\
                    AND acctgTrans.voucherNo LIKE ?\
                    AND acctgTrans.description LIKE ?)\
                    AND acctgTrans.status = ?", [organization, newVoucherNo, newParticulars, status])
            }
            if(status!='null' && voucherType!='null'){
                result = GlAccountingTransaction.executeQuery("\
                    FROM GlAccountingTransaction acctgTrans\
                    WHERE (acctgTrans.organization = ?\
                    AND acctgTrans.voucherNo LIKE ?\
                    AND acctgTrans.description LIKE ?)\
                    AND acctgTrans.status = ?", [organization, newVoucherNo, newParticulars, status])
            }
            if(status!='null' && voucherType!='null' && transactionDate!='null'){
                result = GlAccountingTransaction.executeQuery("\
                    FROM GlAccountingTransaction acctgTrans\
                    WHERE (acctgTrans.organization = ?\
                    AND acctgTrans.voucherNo LIKE ?\
                    AND acctgTrans.description LIKE ?)\
                    AND acctgTrans.status = ?", [organization, newVoucherNo, newParticulars, status])
            }
            
        }
        return result
    }
}
