package com.app

class Approval implements Serializable {

    String description
    String department
    String approvalFeature
    String active = 'Yes'
    String submitByPosition

    static constraints = {
        description (blank: false)
        department (blank: false, nullable: false, inList : ["Administration", "Finance", "HR", "Sales"])
        approvalFeature (inList : ["Voucher Approval", "Leave"])
        submitByPosition (inList : ["Clerk, Supervisor, Manager"])
        active(inList : ["Yes", "No"])
    }
}
