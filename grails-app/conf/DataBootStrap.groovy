import grails.util.GrailsUtil
import com.app.*
import com.gl.*

class DataBootStrap {

	def init =	{ servletContext ->

		def usr = new AppRole(roleCode : "USR",
            roleName:"User",
            dateCreated:new Date('01/01/2011'))
		if(!AppRole.find(usr)){
            usr.save()
            if(usr.hasErrors()){
                println usr.errors
            }
        }   

        def basicUser = new AppRole(roleCode : "BUSR",
            roleName:"Basic User",
            dateCreated:new Date('01/01/2011'))
		if(!AppRole.find(basicUser)){
            basicUser.save()
            if(basicUser.hasErrors()){
                println basicUser.errors
            }
        }

        def groupRole = new AppRole(roleCode : "GRP",
            roleName:"Group",
            dateCreated:new Date('01/01/2011'))
		if(!AppRole.find(groupRole)){
            groupRole.save()
            if(groupRole.hasErrors()){
                println groupRole.errors
            }
        }

        // Updating parentId's of ADM and SUSER roles

        def admUser = AppRole.get(1)
        admUser.parent = usr
        admUser.save()

        def superUser = AppRole.get(2)
        superUser.parent = usr
        superUser.save()

        def employeeRole = new AppRole(roleCode : "EMP",
            roleName:"Employee",
            dateCreated:new Date('01/01/2011'),
            parent: groupRole)
		if(!AppRole.find(employeeRole)){
            employeeRole.save()
            if(employeeRole.hasErrors()){
                println employeeRole.errors
            }
        }

        def customerRole = new AppRole(roleCode : "CUST",
            roleName:"Customer",
            dateCreated:new Date('01/01/2011'),
            parent: groupRole)
		if(!AppRole.find(customerRole)){
            customerRole.save()
            if(customerRole.hasErrors()){
                println customerRole.errors
            }
        }

        def supplierRole = new AppRole(roleCode : "SUPP",
            roleName:"Supplier",
            dateCreated:new Date('01/01/2011'),
            parent: groupRole)
		if(!AppRole.find(supplierRole)){
            supplierRole.save()
            if(supplierRole.hasErrors()){
                println supplierRole.errors
            }
        }

        def organizationRole = new AppRole(roleCode : "ORG",
            roleName:"Organization",
            dateCreated:new Date('01/01/2011'),
            parent: groupRole)
		if(!AppRole.find(organizationRole)){
            organizationRole.save()
            if(organizationRole.hasErrors()){
                println organizationRole.errors
            }
        }

        def salesmanRole = new AppRole(roleCode : "SLM",
            roleName:"Salesman",
            dateCreated:new Date('01/01/2011'),
            parent: groupRole)
		if(!AppRole.find(salesmanRole)){
            salesmanRole.save()
            if(salesmanRole.hasErrors()){
                println salesmanRole.errors
            }
        }

        /** APPROVAL DEFINITIONS **/

    	def managerVoucherApproval = new Approval(description : "Manager's Voucher Approval Feature",
            department:"Finance",
            approvalFeature:"VOUCHER",
            status:"Enabled",
            position:"Manager")
        if(!Approval.find(managerVoucherApproval)){
            managerVoucherApproval.save()
            if(managerVoucherApproval.hasErrors()){
                println managerVoucherApproval.errors
            }
        }

        def managerApprovalSeq = new ApprovalSeq(approval : managerVoucherApproval, 
            position:"Manager",
            sequence:1)
        managerApprovalSeq.save()


        def supervisorVoucherApproval = new Approval(description : "Supervisor's Voucher Approval Feature",
            department:"Finance",
            approvalFeature:"VOUCHER",
            status:"Enabled",
            position:"Supervisor")
        if(!Approval.find(supervisorVoucherApproval)){
            supervisorVoucherApproval.save()
            if(supervisorVoucherApproval.hasErrors()){
                println supervisorVoucherApproval.errors
            }
        }

        def supervisorApprovalSeq1 = new ApprovalSeq(approval : supervisorVoucherApproval, 
            position:"Manager",
            sequence:1)
        supervisorApprovalSeq1.save()
            

        def supervisorApprovalSeq2 = new ApprovalSeq(approval : supervisorVoucherApproval, 
            position:"Supervisor",
            sequence:2)
        supervisorApprovalSeq2.save()



        def clerkVoucherApproval = new Approval(description : "Clerk's Voucher Approval Feature",
            department:"Finance",
            approvalFeature:"VOUCHER",
            status:"Enabled",
            position:"Clerk")
        if(!Approval.find(clerkVoucherApproval)){
            clerkVoucherApproval.save()
            if(clerkVoucherApproval.hasErrors()){
                println clerkVoucherApproval.errors
            }
        }

        def clerkApprovalSeq1 = new ApprovalSeq(approval : clerkVoucherApproval, 
            position:"Manager",
            sequence:1)
        clerkApprovalSeq1.save()


        def clerkApprovalSeq2 = new ApprovalSeq(approval : clerkVoucherApproval, 
            position:"Supervisor",
            sequence:2)
        clerkApprovalSeq2.save()


        def clerkApprovalSeq3 = new ApprovalSeq(approval : clerkVoucherApproval, 
            position:"Clerk",
            sequence:3)
        clerkApprovalSeq3.save()

	}

	def destroy = {

	}

}