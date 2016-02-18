hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            pooled = true
            driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
            username = "sa"
            password = "admin123"
            dbCreate = "update" // one of 'create', 'create-drop','update'
            //url = "jdbc:mysql://localhost:3306/jrlsystem_dev?autoreconnect=true"
            url = "jdbc:sqlserver://localhost:1433;instanceName=SQLEXPRESS;databaseName=jrlsystem_dev"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        dataSource {
            pooled = true
            driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
            //dialect = "org.hibernate.dialect.SQLServerDialect"
            username = "sa2"
            password = "admin"
            dbCreate = "create-drop"
            //url = "jdbc:sqlserver://locahost:3306;databaseName=jrlsystem_dev"
            url = "jdbc:sqlserver://localhost:1433;instanceName=SQLEXPRESS;databaseName=jrlsystem_dev"
        }
    }
}
