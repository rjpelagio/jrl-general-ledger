package com.cash

import groovy.sql.Sql
import com.gl.*
import com.app.*
import org.springframework.context.*


class CashVoucherService  {

	static transactional = true

  def dataSource

  def serviceMethod() {

  }

  //ApplicationContext applicationContext

	//def approvalService = applicationContext.getBean("approvalService")

  def approvalService

	def validateVoucherApproval (CashVoucher trans, def session, def remarks, def transType, def formAction) {

        //Initializing remarks for new approval records, coz remarks is only available when updating
        remarks = (remarks!=null && remarks.length()>0) ? remarks : ''

        def result = CashVoucherApproval.findByTransaction(trans)
        //Check existing approval records
        if (result) {

          def approvalCriteria = CashVoucherApproval.createCriteria()

          def criteriaResult = approvalCriteria {
            and {
              eq ("position", session.employee.position)
              eq ("transaction", trans)
              eq ("status", 'Active')
            }
          }

          if (criteriaResult) {
            def approvalMap = criteriaResult.get(0)

            approvalMap.remarks = remarks
            if (remarks == '' && formAction != 'updateSubmitted') {
              approvalMap.remarks = 'Approved by ' + session.party
            }
            
            approvalMap.lastUpdated = new Date()
            approvalMap.updatedBy = session.party

            if (formAction == 'updateSubmitted') {
              approvalMap.status = 'Active'
            } else {
              approvalMap.status = 'Submitted'
            }

            approvalMap.save(flush:true)

            if (approvalMap.sequence == 1) {
              approvalService.approveTransaction(trans, transType, formAction)
            }
          }

      } else {
        //Generate approval entries if status is set to submitted and approval records does not exist
        approvalService.createApprovalEntries(transType, session, trans)
      }

    }

    def validateReimbursementItems (def params) {

        ArrayList<String> msgs = new ArrayList<String>();

        if (params.payeeIds.size() < 1) {
          msgs.add('No Payee found.')
        }

        if (params.glAccountIds.size() < 1) {
          msgs.add('No GL Account found.')
        }

        if (params.rowIndex.toInteger() > 1) {
          for (int i = 0; i < params.rowIndex.toInteger(); i++) {
            try {
              if (params.payeeIds[i].isInteger()) { 
                  if(!Party.get(params.payeeIds[i].toInteger())) {
                      msgs.add('Invalid Payee on row ' + (i+1))
                  }
              } else {
                msgs.add('Invalid Payee on row ' + (i+1))
              }
            } catch (all) {
              msgs.add('Invalid Payee on row ' + (i+1))
            }
          }

          if (params.department == 'Finance') {
            for (int i = 0; i < params.rowIndex.toInteger(); i++) {
              try {
                if (params.glAccountIds[i].toInteger()) {
                  if(!GlAccount.get(params.glAccountIds[i].toInteger())) {
                    msgs.add('Invalid GL Account on row ' + (i+1))
                  }
                } 
              } catch (all) {
                msgs.add('Invalid GL Account on row ' + (i+1))
              } 
            } 
          }
        } else {
          try {
            if(!Party.get(params.payeeIds.toInteger())) {
                msgs.add('Invalid Payee on row 1')
            }
          } catch (all) {
            msgs.add('Invalid Payee on row 1')
          }

          try {
            if (params.department == 'Finance') {
              if(!GlAccount.get(params.glAccountIds.toInteger())) {
                msgs.add('Invalid GL Account on row 1')
              }
            }
          } catch (all) {
            msgs.add('Invalid GL Account on row 1')
          }
        }

        return msgs;
    }


    def insertReimbursementItems (CashVoucher trans, def payeeIds, def amounts, 
        def descriptions, def refDocs, def glAccountIds, def department) {

        //remove previously recorded reimbursement items
        CashVoucherItems.executeUpdate("delete \
            CashVoucherItems items \
            WHERE items.cashVoucher = ?", [trans]);

          for (int i = 0; i < payeeIds.size(); i++) { 
              def item = new CashVoucherItems();
              item.payee = Party.get(payeeIds[i]);
              item.description = descriptions[i];
              item.amount = Float.parseFloat(amounts[i]);
              item.referenceDoc = refDocs[i];
              if (department == 'Finance') {
                item.glAccount = GlAccount.get(glAccountIds[i]);
              }
              item.cashVoucher = trans;

              item.save(flush:true);
              if (item.hasErrors()) {
                  println item.errors
              }
          }
        
    }

    def disburseVouchers (def params, def list) {

        def map = new CashVoucher()
        BigDecimal totalDisbursed = 0.00;
        for (int i = 0; i < params.flags.size(); i++) {
            if (params.flags[i] == '1') {
                map = CashVoucher.get(list.get(i).id)
                if (map) {
                    map.status = 'Disbursed'
                    map.save(flush:true)
                    totalDisbursed = totalDisbursed + map.total
                }
            }
        }

        
        def historyCriteria = CashHistory.createCriteria()
        def history = historyCriteria.list () {
            order("id", "desc")
        }

        def cashHistory = new CashHistory()
        cashHistory.amount = history.get(0).amount - totalDisbursed
        cashHistory.method = 'Disbursement'
        cashHistory.preparedBy = Party.get(params.preparedBy)
        cashHistory.lastUpdated = new Date()
        cashHistory.save(flush:true)
        if (cashHistory.hasErrors()) {
            println cashHistory.hasErrors()
        }


  }                 

   def insertLiquidationItems (Liquidation trans, def payeeIds, def amounts, 
        def descriptions, def glAccountIds, def refDocs) {

        //remove previously recorded reimbursement items
        LiquidationItems.executeUpdate("delete \
            LiquidationItems items \
            WHERE items.liquidation = ?", [trans]);
        
        

          for (int i = 0; i < payeeIds.size(); i++) { 
              def item = new LiquidationItems();
              item.payee = Party.get(payeeIds[i]);
              item.description = descriptions[i];
              item.amount = Float.parseFloat(amounts[i]);
              item.glAccount = GlAccount.get(glAccountIds[i]);
              item.refDoc = refDocs[i];
              item.liquidation = trans;

              item.save(flush:true);
              if (item.hasErrors()) {
                  println item.errors
              }
          }

    }     

    def validateLiquidationApproval (Liquidation trans, def session, def remarks, def transType, def formAction) {

        //Initializing remarks for new approval records, coz remarks is only available when updating
        remarks = (remarks!=null && remarks.length()>0) ? remarks : ''

        def result = LiquidationApproval.findByTransaction(trans)
        //Check existing approval records
        if (result) {

          def approvalCriteria = LiquidationApproval.createCriteria()

          def criteriaResult = approvalCriteria {
            and {
              eq ("position", session.employee.position)
              eq ("transaction", trans)
              eq ("status", 'Active')
            }
          }

          if (criteriaResult) {
            def approvalMap = criteriaResult.get(0)

            approvalMap.remarks = remarks
            if (remarks == '' && formAction != 'updateSubmitted') {
              approvalMap.remarks = 'Approved by ' + session.party
            }
            
            approvalMap.lastUpdated = new Date()
            approvalMap.updatedBy = session.party

            if (formAction == 'updateSubmitted') {
              approvalMap.status = 'Active'
            } else {
              approvalMap.status = 'Submitted'
            }

            approvalMap.save(flush:true)

            if (approvalMap.sequence == 1) {
              approvalService.approveTransaction(trans, transType, formAction)
            }
          }

      } else {
        //Generate approval entries if status is set to submitted and approval records does not exist
        approvalService.createApprovalEntries(transType, session, trans)
      }

    }

    def validateReplenishmentApproval (Replenishment trans, def session, def remarks, def transType, def formAction) {

        //Initializing remarks for new approval records, coz remarks is only available when updating
        remarks = (remarks!=null && remarks.length()>0) ? remarks : ''

        def result = ReplenishmentApproval.findByTransaction(trans)
        //Check existing approval records
        if (result) {

          def approvalCriteria = ReplenishmentApproval.createCriteria()

          def criteriaResult = approvalCriteria {
            and {
              eq ("position", session.employee.position)
              eq ("transaction", trans)
              eq ("status", 'Active')
            }
          }

          if (criteriaResult) {
            def approvalMap = criteriaResult.get(0)

            approvalMap.remarks = remarks
            if (remarks == '' && formAction != 'updateSubmitted') {
              approvalMap.remarks = 'Approved by ' + session.party
            }
            
            approvalMap.lastUpdated = new Date()
            approvalMap.updatedBy = session.party

            if (formAction == 'updateSubmitted') {
              approvalMap.status = 'Active'
            } else {
              approvalMap.status = 'Submitted'
            }

            approvalMap.save(flush:true)

            if (approvalMap.sequence == 1) {
              approvalService.approveTransaction(trans, transType, formAction)
            }
          }

      } else {
        //Generate approval entries if status is set to submitted and approval records does not exist
        approvalService.createApprovalEntries(transType, session, trans)
      }

    }

    def validateLiquidationItems (def params) {

        ArrayList<String> msgs = new ArrayList<String>();

        if (params.payeeIds.size() < 1) {
          msgs.add('No Payee found.')
        }

        if (params.glAccountIds.size() < 1) {
          msgs.add('No GL Account found.')
        }

        for (int i = 0; i < params.payeeIds.size(); i++) {
          try {
            if (params.payeeIds[i].isInteger()) { 
                if(!Party.get(params.payeeIds[i].toInteger())) {
                    msgs.add('Invalid Payee on row ' + (i+1))
                }
            } else {
              msgs.add('Invalid Payee on row ' + (i+1))
            }
          } catch (all) {
            msgs.add ('Invalid Payee on row ' + (i+1))
          }
        }

        for (int i = 0; i < params.glAccountIds.size(); i++) {
          try {
            if (params.glAccountIds[i].toInteger()) {
              if(!GlAccount.get(params.glAccountIds[i].toInteger())) {
                msgs.add('Invalid GL Account on row ' + (i+1))
              }
            } 
          } catch (all) {
            msgs.add('Invalid GL Account on row ' + (i+1))
          } 
        } 
  

        return msgs;
    }

    boolean checkCashVoucherForLiquidation (CashVoucher trans) {

        def cashVoucherCriteria = Liquidation.createCriteria()

        def criteriaResult = cashVoucherCriteria {
          and {
            eq ("cashVoucher", trans)
            eq ("status", 'Active')
          }
        }

        if (criteriaResult.size() > 1) {
          return false;
        }
  
        return true;
    }

    

    def saveAllReplenishableTransactions (Replenishment trans, def result) {

      for (int i = 0; i < result.size(); i++) {

        def item = new ReplenishmentItems()
        item.replenishment = trans
        if (result[i].type == 'Reimbursement') {
          def cashVoucher = CashVoucher.get(result[i].id)
          item.cashVoucher = cashVoucher
        } else if (result[i].type == 'Liquidation') {
          def liquidation = Liquidation.get(result[i].id)
          item.liquidation = liquidation
        }
        item.save(flush:true)
        if (item.hasErrors()) {
            println item.errors
        }
      }
    }

    boolean checkForOpenReplenishments(def organization) {

      def searchCriteria = Replenishment.createCriteria()

      def criteriaResult = searchCriteria.list() {
        eq ("organization", AppOrganization.get(organization))
        eq ("approvalStatus", 'Pending Approval')
      }

      if (criteriaResult.size() > 0) {
          return false;
      } else {
          return true;
      }

    }

    
  


}