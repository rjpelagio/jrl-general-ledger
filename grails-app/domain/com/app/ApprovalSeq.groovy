package com.app

class ApprovalSeq {

    Integer sequence
    String position
    String remarks

    static belongsTo = [approval : Approval]
    
    static constraints = {
    	remarks sqlType : "varchar", length : 255
        position (blank: false, nullable: false)
    }
}
