package jrl

import com.app.*
import com.gl.*
import groovy.sql.Sql

class DashboardTagLib {
    def dataSource
    def dashboardSummary = {
        def sql = new Sql(dataSource)
        def vouchers = sql.rows("SELECT COUNT(id) as recSize, status\
                FROM gl_accounting_transaction\
                WHERE (transaction_date between DATE_SUB(?, INTERVAL 1 MONTH) AND ?)\
                GROUP BY status", [new Date(), new Date()])
        if(request.getSession(false) && session.user){
            if(vouchers){
                out << "<ul>"
                for (int i = 0; i < vouchers.size(); i++) {
                    out << "<li>"
                    out << """${link(action:"list",
                        controller:"glAccountingTransaction"){"${vouchers[i].status} - ${vouchers[i].recSize}"}}"""
                    out << "</li>"
                }
                out << "</ul>"
            }
            else{
                out << "<span class='nodata'>No records for your approval. </span>"
            }
        }
    }
    def approvalSummary = {
        def sql = new Sql(dataSource)
        def vouchers = sql.rows("SELECT count(*) as recSize, approval_seq.remarks as remarks, role_id\
            FROM acctg_trans_approval INNER JOIN\
                approval_seq\
            ON approval_seq_id=approval_seq.id\
            WHERE user_id is null\
                AND role_id=?\
                AND acctg_trans_id IN\
                    (SELECT  id FROM gl_accounting_transaction WHERE status!='Active'\
                    AND status!='Cancelled' AND status!='Approved')\
            GROUP BY role_id", [session.user.role.id])
        if(request.getSession(false) && session.user){
            if(vouchers){
                out << "<ul>"
                for (int i = 0; i < vouchers.size(); i++) {
                    out << "<li>"
                    out << """${link(action:"list",
                        controller:"glAccountingTransaction"){"${vouchers[i].remarks} - ${vouchers[i].recSize}"}}"""
                    out << "</li>"
                }
                out << "</ul>"
            }
            else{
                out << "<span class='nodata'>No records for your approval. </span>"
            }
        }
    }
}
