package com.ar

class SalesmanArea {

    static constraints = {
    	dateCreated()
    }

    static belongsTo = [area:Area, salesman:Salesman]

    Date dateCreated
    
}
