import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import net.masterthought.cucumber.Reportable;
import net.masterthought.cucumber.json.support.Status;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class RunAllTest {

    @Test
    public void testAll() {
        System.setProperty("karate.env", "test");
        Results results = Runner.parallel(getClass(), 5, "target/surefire-reports");
        Assertions.assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @AfterAll
    public static void makeCucumberReport() {
        File reportOutputDirectory = new File("target");
        List<String> jsonFiles = new ArrayList<>();
        jsonFiles.add("C:\\Karate\\Projet\\karatedemo\\target\\surefire-reports\\ui.web.zenityIntranet.json");
        jsonFiles.add("C:\\Karate\\Projet\\karatedemo\\target\\surefire-reports\\ui.mobile.android.zenityIntranetAndroid.json");
        jsonFiles.add("C:\\Karate\\Projet\\karatedemo\\target\\surefire-reports\\api.users.json");
        jsonFiles.add("C:\\Karate\\Projet\\karatedemo\\target\\surefire-reports\\api.usersFail.json");

        String projectName = "Karate demo";
        Configuration configuration = new Configuration(reportOutputDirectory, projectName);
        configuration.setNotFailingStatuses(Collections.singleton(Status.SKIPPED));
        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        Reportable result = reportBuilder.generateReports();
    }

}
