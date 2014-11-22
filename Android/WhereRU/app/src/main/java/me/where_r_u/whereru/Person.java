package me.where_r_u.whereru;

import com.google.android.gms.maps.model.LatLng;

/**
 * Created by Brian Kelley on 9/29/14.
 */
public class Person {
    private String name;
    private LatLng currentLocation;
    private LatLng pickupLocation;

    public Person(String n) {
        // Constructor with first and last name
        this.name = n;
    }

    public String getName() {
        return name;
    }


    public LatLng getCurrentLocation() {
        return currentLocation;
    }

    public LatLng getPickupLocation() {
        return pickupLocation;
    }

    public void setCurrentLocation(LatLng location) {
        currentLocation = location;
    }

    public void setPickupLocation(LatLng location) {
        pickupLocation = location;
    }



}
