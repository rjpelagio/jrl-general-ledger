package com.app

import groovy.sql.Sql

class LookupService {

	static transactional = true

    def dataSource

    def serviceMethod() {

    }

    def lookupGlAccounts(params, organization){

      def db = new Sql(dataSource)  

      def glAccountList = [] // to add each company details

      def nwquery = "SELECT glAcct.id as id, glAcct.gl_account as glAccount, glAcct.description as description " +
        "FROM gl_account glAcct " +
        "INNER JOIN gl_account_organization org " +
        "ON org.gl_account_id = glAcct.id " + 
        "WHERE org.organization_id = " + organization + " " +
        "AND (glAcct.gl_account LIKE '%" + params.term + "%' " +
        "OR glAcct.description LIKE '%" + params.term + "%')" +
        "ORDER BY glAcct.id ASC"

      def result = db.rows(nwquery);

      for (int i = 0; i < result.size() ; i++) {
        def glAccountMap = [:]

        glAccountMap.put("id", result.get(i).getProperty('id'))
        glAccountMap.put("label", result.get(i).getProperty('glAccount') + " : " + result.get(i).getProperty('description'))
        //glAccountMap.put("value", result.get(i).getProperty('glAccount') + " : " + result.get(i).getProperty('description'))
        glAccountMap.put("value", result.get(i).getProperty('description'))


        glAccountList.add(glAccountMap) // add to the arraylist
      }

      return glAccountList
      
    }

    def lookupPayeeAndTin(params){

    	def payeeList = []

        def db = new Sql(dataSource)

        def newTerm
        if(params.term) {
        	newTerm = '%' + params.term + '%'
        }

        def result = db.rows("SELECT party.party_id as id, party.name, \
            party.tin as tin, \
            party_role.role_id as role, \
            party_role.status as status \
            FROM party \
            JOIN party_role ON party_role.party_id = party.party_id \
            WHERE party.name LIKE ? \
            AND party_role.status = 'Active'", [newTerm]
        )

        for (int i = 0; i < result.size(); i++){
        	def payeeMap = [:]

        	payeeMap.put("id", result.get(i).getProperty('id'));
        	payeeMap.put("label", result.get(i).getProperty('name'));
        	payeeMap.put("value", result.get(i).getProperty('name'));
        	payeeMap.put("tin", result.get(i).getProperty('tin'));

        	payeeList.add(payeeMap)
        }

        return payeeList

    }  


}