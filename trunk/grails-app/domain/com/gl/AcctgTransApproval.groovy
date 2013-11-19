package com.gl
import com.app.*

class AcctgTransApproval {
    String remarks
    
    static belongsTo = [user : AppUser,
                    acctgTrans : GlAccountingTransaction,
                    approvalSeq : ApprovalSeq]
   static constraints = {
       remarks (blank: true, nullable: true)
       user (blank: true, nullable: true)
   }
}
