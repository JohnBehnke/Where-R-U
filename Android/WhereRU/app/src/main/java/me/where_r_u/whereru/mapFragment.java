package me.where_r_u.whereru;



import android.content.Context;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.LatLng;


/**
 * A simple {@link Fragment} subclass.
 *
 */
public class mapFragment extends Fragment implements
        GooglePlayServicesClient.ConnectionCallbacks,
        GooglePlayServicesClient.OnConnectionFailedListener,
        LocationListener {

    public GoogleMap map;
    private LocationRequest lr;
    private LocationClient lc;

    public mapFragment() {
        // Log.w("whereru", "empty constructor, should be called");
        // Required empty public constructor
        // For whatever reason, when I make a tab the map, it only calls this. Not onCreateView.
        // That confused me for too long.

    }

    @Override
    public void onLocationChanged(Location l2) {
        Log.w("whereru", "Location changed!");
        CameraUpdate cameraUpdate = CameraUpdateFactory.newLatLngZoom(
                new LatLng(l2.getLatitude(), l2.getLongitude()), 15);
        map.animateCamera(cameraUpdate);
    }


    @Override
    public void onConnectionFailed(ConnectionResult arg0) {

    }

    @Override
    public void onConnected(Bundle connectionHint) {
        Log.w("whereru", "Connected!");
        lc.requestLocationUpdates(lr, this);

    }

    @Override
    public void onDisconnected() {

    }


    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_map, container, false);

    }


}
