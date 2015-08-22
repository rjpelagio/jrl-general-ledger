package com.app

class ApprovalSeq {

    Integer sequence
    String position

    static belongsTo = [approval : Approval]
    
    static constraints = {
        position (blank: false, nullable: false)
    }
}
