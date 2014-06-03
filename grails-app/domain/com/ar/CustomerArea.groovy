package com.ar

class CustomerArea {

    Date dateCreated 

    static belongsTo = [area:Area, customer:Customer]



    static constraints = {

     area(blank : false)
     customer(blank : false)
	 dateCreated(blank : false)

	 }

	 String toString(){
	 	return "${Area.find(area).area} -- ${Area.find(area).description}"

	}

}



