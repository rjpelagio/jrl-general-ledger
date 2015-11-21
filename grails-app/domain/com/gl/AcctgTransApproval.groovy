package com.gl
import com.app.*

class AcctgTransApproval {
	static auditable = true
    String remarks
    
    static belongsTo = [user : AppUser,
                    acctgTrans : GlAccountingTransaction,
                    approvalSeq : ApprovalSeq]
   static constraints = {
       remarks (blank: true, nullable: true)
       user (blank: true, nullable: true)
   }
}
