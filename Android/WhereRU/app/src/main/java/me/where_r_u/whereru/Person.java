package me.where_r_u.whereru;

import com.google.android.gms.maps.model.LatLng;

/**
 * Created by Brian Kelley on 9/29/14.
 */
public class Person {
    private String firstName;
    private String lastName;
    private LatLng currentLocation;
    private LatLng pickupLocation;

    public Person(String first, String last) {
        // Constructor with first and last name
        this.firstName = first;
        this.lastName = last;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
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
