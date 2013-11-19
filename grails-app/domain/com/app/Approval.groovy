package com.app

class Approval {

    String description
    String department
    String approvalFeature
    String active = 'Yes'

    static constraints = {
        description (blank: false)
        department (blank: false, nullable: false, inList : ['Administration', 'Finance', 'HR', 'Sales'])
        approvalFeature (inList : ['Voucher Approval', 'Leave'])
    }
}
