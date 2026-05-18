package Utils;

import Security.Security;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import model.GooglePojo;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

public class GoogleUtils {

    public static String getToken(final String code) throws IOException, InterruptedException {
        String body = "client_id=" + URLEncoder.encode(Security.ClientID, StandardCharsets.UTF_8)
                + "&client_secret=" + URLEncoder.encode(Security.ClientSecret, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(Security.GOOGLE_REDIRECT_URI, StandardCharsets.UTF_8)
                + "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8)
                + "&grant_type=" + URLEncoder.encode(Security.GOOGLE_GRANT_TYPE, StandardCharsets.UTF_8);

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(Security.GOOGLE_LINK_GET_TOKEN))
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        ObjectMapper mapper = new ObjectMapper();
        JsonNode node = mapper.readTree(response.body());
        if (node.has("access_token")) {
            return node.get("access_token").asText();
        }
        return null;
    }

    public static GooglePojo getUserInfo(final String accessToken) throws IOException, InterruptedException {
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(Security.GOOGLE_LINK_GET_USER_INFO))
                .header("Authorization", "Bearer " + accessToken)
                .GET()
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(response.body(), GooglePojo.class);
    }
}
