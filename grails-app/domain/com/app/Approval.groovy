package com.app

class Approval implements Serializable {

    String description
    String department
    String approvalFeature
    String status
    String position

    static constraints = {
        description (blank: false)
        department (blank: false, nullable: false, inList : ["Administration", "Finance", "HR", "Sales"])
        approvalFeature (inList : ["VOUCHER", "LEAVE"])
        position (blank: false, nullable : false)
        status(inList : ["Enabled", "Disabled"])
    }
}
