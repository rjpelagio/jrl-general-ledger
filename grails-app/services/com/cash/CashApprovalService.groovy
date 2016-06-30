package com.cash

import groovy.sql.Sql
import com.gl.*
import com.app.*
import org.springframework.context.*


class CashApprovalService  {

		static transactional = true

  		def dataSource

		def serviceMethod() {

  		}

		
		def processLiquidationChange (Liquidation trans) {

        	def historyCriteria = CashHistory.createCriteria()
    		def history = historyCriteria.list () {
        		maxResults(1)
        		order("id", "desc")
    		}

	        def cashHistory = new CashHistory()
	        cashHistory.amount = history.get(0).amount + trans.change
	        cashHistory.method = 'Liquidation Change'
	        cashHistory.preparedBy = Party.get(trans.preparedBy.id)
	        cashHistory.lastUpdated = new Date()
	        cashHistory.save(flush:true)
	        if (cashHistory.hasErrors()) {
	            println cashHistory.hasErrors()
	        }

    	}


		def closeReplenishedTransactions(Replenishment trans) {

      		def items = ReplenishmentItems.findAllByReplenishment(trans)

      		def amountForCashHistory = 0.00
      		for (int i = 0; i < items.size(); i++) {

        		if (items[i].liquidation != null) {
          			def liquidation = Liquidation.get(items[i].liquidation.id)
          			liquidation.status = 'Closed'
          			liquidation.save(flush:true)
          			amountForCashHistory += liquidation.total
          			//Posting
          			postLiquidationRequest(liquidation)
        		}


        		if (items[i].cashVoucher != null) {

          			def cashVoucher = CashVoucher.get(items[i].cashVoucher.id)
          			cashVoucher.status = 'Closed'
          			cashVoucher.save(flush:true)
          			amountForCashHistory += cashVoucher.total
          			postReimbursementRequest(cashVoucher)
        		}
      		}		

      		def historyCriteria = CashHistory.createCriteria()
      		def history = historyCriteria.list () {
          		maxResults(1)
          		order("id", "desc")
      		}

      		def cashHistory = new CashHistory()
      		cashHistory.amount = history.get(0).amount + amountForCashHistory
      		cashHistory.lastUpdated = new Date()
      		cashHistory.method = 'Replenishment'
      		cashHistory.preparedBy = trans.preparedBy
      		cashHistory.save(flush:true)


		}

		def postLiquidationRequest (Liquidation trans) {

			def glEntry = new GlAccountingTransaction()
			glEntry.description = 'Liquidation ' + trans.liquidationNumber + ' Cash Voucher'
			glEntry.organization = trans.organization
			glEntry.transactionDate = trans.dateCreated
			glEntry.postedDate = new Date()
			glEntry.entryDate = new Date()
			glEntry.voucherNo = 'CV - ' + trans.liquidationNumber
			glEntry.status = 'Closed'
			glEntry.approvalStatus = 'Approved'
			glEntry.printed = 'No'	
			glEntry.preparedBy = trans.preparedBy
			glEntry.acctgTransType = AcctgTransType.findByAcctgTransCode('CV')
			glEntry.party = trans.preparedBy
			if (glEntry.hasErrors()) {
            	println glEntry.errors
        	}
			if(glEntry.validate()) {
				glEntry.save(flush:true)
				// Generate Journal items

				def headerGlEntry = new GlAccountingTransactionDetails()
				headerGlEntry.glAccountingTransaction = glEntry
				headerGlEntry.glAccount = trans.cashVoucher.glAccount
				headerGlEntry.sequenceId = 1
				headerGlEntry.amount = trans.cashVoucher.total
				headerGlEntry.debitCreditFlag = 'Credit'
				headerGlEntry.save(flush:true)

				int j = 2
				def list = LiquidationItems.findAllByLiquidation(trans)
				for (int i = 0; i < list.size(); i++) {
					def item = new GlAccountingTransactionDetails()
					item.glAccount = list[i].glAccount
					item.glAccountingTransaction = glEntry
					item.sequenceId = j
					item.debitCreditFlag = 'Debit'
					item.amount = list[i].amount
					item.save(flush:true)
					j++;
				}

				if (trans.change > 0) {
					def changeGLEntry = new GlAccountingTransactionDetails()
					changeGLEntry.glAccountingTransaction = glEntry
					changeGLEntry.glAccount = GlAccount.get(30)
					changeGLEntry.sequenceId = j
					changeGLEntry.amount = trans.change
					changeGLEntry.debitCreditFlag = 'Debit'
					changeGLEntry.save(flush:true)
				}
			}
			
		}

		def postReimbursementRequest (CashVoucher trans) {

			def setup = CashSetup.get(1)

			def glEntry = new GlAccountingTransaction()
			glEntry.description = 'Reimbursement ' + trans.cashVoucherNumber + ' Cash Voucher'
			glEntry.organization = trans.organization
			glEntry.transactionDate = trans.dateCreated
			glEntry.postedDate = new Date()
			glEntry.entryDate = new Date()
			glEntry.voucherNo = 'CV - ' + trans.cashVoucherNumber
			glEntry.status = 'Closed'
			glEntry.approvalStatus = 'Approved'
			glEntry.printed = 'No'	
			glEntry.preparedBy = trans.preparedBy
			glEntry.acctgTransType = AcctgTransType.findByAcctgTransCode('CV')
			glEntry.party = trans.preparedBy
			if (glEntry.hasErrors()) {
            	println glEntry.errors
        	}
			if(glEntry.validate()) {
				glEntry.save(flush:true)
				// Generate Journal items

				def headerGlEntry = new GlAccountingTransactionDetails()
				headerGlEntry.glAccountingTransaction = glEntry
				headerGlEntry.glAccount = trans.glAccount
				headerGlEntry.sequenceId = 1
				headerGlEntry.amount = trans.total
				headerGlEntry.debitCreditFlag = 'Credit'
				headerGlEntry.save(flush:true)

				int j = 2
				def list = CashVoucherItems.findAllByCashVoucher(trans)
				for (int i = 0; i < list.size(); i++) {
					def item = new GlAccountingTransactionDetails()
					item.glAccount = list[i].glAccount
					item.glAccountingTransaction = glEntry
					item.sequenceId = j
					if (setup.reimbursementCreditAccount == item.glAccount) {
						item.debitCreditFlag = 'Credit'
					} else if (setup.reimbursementDebitAccount == item.glAccount) {
						item.debitCreditFlag = 'Debit'
					} else {
						item.debitCreditFlag = 'Debit'
					}
					item.amount = list[i].amount
					item.save(flush:true)
					j++;
				}
				
			}
			
		}

		def postReplenishmentRequest (Replenishment trans) {

			def setup = CashSetup.get(1)

			def glEntry = new GlAccountingTransaction()
			glEntry.description = 'Replenishment ' + trans.replenishmentNumber + ' Transaction'
			glEntry.organization = trans.organization
			glEntry.transactionDate = trans.dateCreated
			glEntry.postedDate = new Date()
			glEntry.entryDate = new Date()
			glEntry.voucherNo = 'CV - ' + trans.replenishmentNumber
			glEntry.status = 'Closed'
			glEntry.approvalStatus = 'Approved'
			glEntry.printed = 'No'	
			glEntry.preparedBy = trans.preparedBy
			glEntry.acctgTransType = AcctgTransType.findByAcctgTransCode('CV')
			glEntry.party = trans.preparedBy
			if (glEntry.hasErrors()) {
            	println glEntry.errors
        	}

        	if(glEntry.validate()) {
				glEntry.save(flush:true)
				// Generate Journal items

				def varianceGlEntry = new GlAccountingTransactionDetails()

				varianceGlEntry.glAccountingTransaction = glEntry
				varianceGlEntry.sequenceId = 1
				def transCash = ReplenishmentCashItems.findByReplenishment(trans)
				varianceGlEntry.amount = transCash.variance
				def cashSetup = CashSetup.get(1)
				if (transCash.variance > 0) {
					varianceGlEntry.glAccount = cashSetup.replenishmentNegVariance
					varianceGlEntry.debitCreditFlag = 'Debit'
				} else if (transCash.variance < 0) {
					varianceGlEntry.glAccount = cashSetup.replenishmentPosVariance
					varianceGlEntry.debitCreditFlag = 'Credit'
				} else if (transCash.variance == 0) {
					varianceGlEntry.glAccount = cashSetup.replenishmentNegVariance
					varianceGlEntry.debitCreditFlag = 'Debit'
				}
				varianceGlEntry.save(flush:true)

			}
		}


}