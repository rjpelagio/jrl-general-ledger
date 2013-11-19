package com.app

class ApprovalSeq {

    Integer sequence
    String remarks

    static belongsTo = [approval : Approval,
                    role : AppRole]
    
    static constraints = {
        remarks (inList: ['Noted By', 'Approved By', 'Reviewed By'])
    }
}
