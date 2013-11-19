package com.app

class Geo {
    String geoName
    String geoCode
    String abbreviation

    static mapping = {
        id column : "geo_id"
    }

    static belongsTo = [geoType : GeoType]
    static constraints = {
        geoName (blank : false)
        geoCode (blank : true, nullable : true)
        abbreviation (blank : true, nullable : true)
    }
}
