package Utils;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Validator {
    public static boolean patternMachees(String input, String regexPattern) {
        Pattern pattern = Pattern.compile(regexPattern);
        return pattern.matcher(input).matches();
    }

    public static boolean validateEmail(String email) {
        String regexPattern = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
                + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
        return patternMachees(email, regexPattern);
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        String regex = "^(\\+\\d{1,2})?\\d{10,}$";

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phoneNumber);

        return matcher.matches();
    }
}