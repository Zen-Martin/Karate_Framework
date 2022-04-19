package api;

import com.intuit.karate.junit5.Karate;

class ApiRunner {

    @Karate.Test
    Karate testUsers() {
        return new Karate()
                .feature("users").relativeTo(getClass())
                .feature("usersFail").relativeTo(getClass());
    }

}
