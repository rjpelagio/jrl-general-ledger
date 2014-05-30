package com.app

class ApprovalSeq {

    Integer sequence
    String remarks
    String position

    static belongsTo = [approval : Approval]
    
    static constraints = {
        remarks (inList: ['Noted By', 'Approved By', 'Reviewed By'])
        position (inList : ['Clerk', 'Supervisor', 'Manager'])
    }
}
