package me.where_r_u.whereru;



import android.location.Location;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.google.android.gms.location.LocationClient;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.LatLng;


/**
 * A simple {@link Fragment} subclass.
 *
 */
public class mapFragment extends Fragment {


    public mapFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {


        GoogleMap map = ((MapFragment) getFragmentManager().findFragmentById(R.id.map1))
                .getMap();
        map.setMyLocationEnabled(true);

        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_map, container, false);

    }


}
