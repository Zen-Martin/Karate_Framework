package ui.mobile.android;

import com.intuit.karate.junit5.Karate;

public class MobileRunner {

    @Karate.Test
    Karate testWebUiTest() {
        System.setProperty("karate.env", "test");
        return new Karate()
                .feature("zenityIntranetAndroid").relativeTo(getClass());
    }
}
