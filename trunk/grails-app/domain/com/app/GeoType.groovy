package com.app

class GeoType {
    String geoType
    String description

    static constraints = {
        geoType (blank : false)
        description (blank : false)
    }
}
