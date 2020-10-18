package com.example.myproject;


import org.glassfish.jersey.client.ClientProperties;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.Response;
import java.time.Duration;
import java.time.Instant;

public class App {

  public static final Client HTTP = createHttpClient();

  private static Client createHttpClient() {
    return ClientBuilder.newBuilder().property(ClientProperties.READ_TIMEOUT,600000).build();
  }

  public static void main(String args[]){
      Instant start = Instant.now();
      System.out.println("Start");
   try{
      Response response = HTTP.target("http://35.226.98.122:8080/myip/120").request().get();
      System.out.println(response.readEntity(String.class));
      response.close();
    }
    catch (Throwable e){
      e.printStackTrace();
    }

    System.out.println("Total time taken : "+ Duration.between(start, Instant.now()).toMillis() + " millis");

  }
}
