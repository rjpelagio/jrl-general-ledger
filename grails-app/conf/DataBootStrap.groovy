import grails.util.GrailsUtil
import com.app.*
import com.gl.*
import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.codehaus.groovy.grails.commons.ApplicationHolder

class DataBootStrap {

	def init =	{ servletContext ->

        def sql = Sql.newInstance(CH.config.dataSource.url, CH.config.dataSource.username,
        CH.config.dataSource.password, CH.config.dataSource.driverClassName)

        String sqlFilePath =  ApplicationHolder.application.parentContext.servletContext.getRealPath("/data/seed_approval_approle.sql")
        String sqlString = new File(sqlFilePath).text
        
        sql.execute(sqlString)

	}

	def destroy = {

	}

}