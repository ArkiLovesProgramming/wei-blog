package config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
//import utility.AWSUtility;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Properties;

@Configuration
public class DatasourceConfig {

    private String url;
    private String driver;
    private String secretID;
    private String password;

    public DatasourceConfig() throws IOException {
        Properties properties = new Properties();
        // 使用ClassLoader加载properties配置文件生成对应的输入流
        InputStream in = DatasourceConfig.class.getClassLoader().getResourceAsStream("database.properties");
        // 使用properties对象加载输入流
        properties.load(in);
        this.url = properties.getProperty("jdbc.url");
        this.driver = properties.getProperty("jdbc.driver");
        this.secretID = properties.getProperty("jdbc.secretID");
        this.password = properties.getProperty("jdbc.password");
    }

    @Bean
    @Primary
    public DataSource dataSource() throws PropertyVetoException {
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        dataSource.setJdbcUrl(url);
        dataSource.setUser(secretID);
        dataSource.setDriverClass(driver);
        dataSource.setPassword(password);
        return dataSource;
    }
}
