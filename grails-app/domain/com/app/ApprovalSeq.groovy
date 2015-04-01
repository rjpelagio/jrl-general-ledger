package com.app

class ApprovalSeq {

    Integer sequence
    String position

    static belongsTo = [approval : Approval]
    
    static constraints = {
    	remarks sqlType : "varchar", length : 255
        position (inList : ['Clerk', 'Supervisor', 'Manager'])
    }
}
