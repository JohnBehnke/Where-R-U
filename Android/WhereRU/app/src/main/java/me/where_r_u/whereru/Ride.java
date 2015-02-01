package me.where_r_u.whereru;

import com.google.android.gms.maps.model.LatLng;

import java.util.ArrayList;

/**
 * Created by brian on 2/1/15.
 */
public class Ride {
    // Member variables
    public String title;

    private Person driver;

    private ArrayList<Person> passengers;
    private ArrayList<Person> pickedUp;
    private ArrayList<Person> toPickUp;
    private String humanReadableDestination;

    private LatLng startLocation;
    private LatLng currentLocation;
    private LatLng destination;
    private ArrayList<LatLng> waypoints;

    // Constructors
    public Ride(String t, Person d) {
        this.title = t;
        this.driver = d;
    }

    public Ride() {}

    public Ride(String t, Person d, ArrayList<Person> pass) {
        this.title = t;
        this.driver = d;
        this.passengers = pass;
        this.toPickUp = pass;
        this.pickedUp = new ArrayList<Person>();
    }

    public Ride(String t, Person d, LatLng dest) {
        this.title = t;
        this.driver = d;
        this.destination = dest;
    }

    // Getters and setters
    public void setPassengers(ArrayList<Person> passengers) {
        this.passengers = passengers;
    }

    public ArrayList<Person> getPickedUp() {
        return pickedUp;
    }

    public String getHumanReadableDestination() {
        return humanReadableDestination;
    }
    public void setHumanReadableDestination(String dest) {humanReadableDestination = dest;}

    public void setPickedUp(ArrayList<Person> pickedUp) {
        this.pickedUp = pickedUp;
    }

    public ArrayList<Person> getToPickUp() {
        return toPickUp;
    }

    public void setToPickUp(ArrayList<Person> toPickUp) {
        this.toPickUp = toPickUp;
    }

    public LatLng getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(LatLng startLocation) {
        this.startLocation = startLocation;
    }

    public LatLng getCurrentLocation() {
        return currentLocation;
    }

    public void setCurrentLocation(LatLng currentLocation) {
        this.currentLocation = currentLocation;
    }

    public LatLng getDestination() {
        return destination;
    }

    public void setDestination(LatLng destination) {
        this.destination = destination;
    }

    public ArrayList<LatLng> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(ArrayList<LatLng> waypoints) {
        this.waypoints = waypoints;
    }

    public void setDriver(Person driver) {

        this.driver = driver;
    }

    public void setTitle(String title) {

        this.title = title;
    }

    public ArrayList<Person> getPassengers() {

        return passengers;
    }

    public Person getDriver() {

        return driver;
    }

    public String getTitle() {

        return title;
    }
}
