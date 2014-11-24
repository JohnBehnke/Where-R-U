package me.where_r_u.whereru;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Intent;
import android.graphics.Outline;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewOutlineProvider;
import android.widget.Button;

import java.util.ArrayList;

import me.where_r_u.whereru.R;



public class RidesFragment extends Fragment {
    private static final String TAG = "RecyclerViewFragment";

    protected RecyclerView mRecyclerView;
    protected RecyclerView.Adapter mAdapter;
    protected RecyclerView.LayoutManager mLayoutManager;
    public ArrayList<Ride> mDataset;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Initialize dataset, this data would usually come from a local content provider or
        // remote server.
        mDataset = new ArrayList<Ride>();
    }

    public void fill(ArrayList<Ride> r) {
        // Fill the recyclerview with rides
        mDataset = r;
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_rides, container, false);
        rootView.setTag(TAG);

        Button mButton = (Button) rootView.findViewById(R.id.fab);
        mButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                newRide(v);
            }
        });

        // BEGIN_INCLUDE(initializeRecyclerView)
        mRecyclerView = (RecyclerView) rootView.findViewById(R.id.recyclerView);

        // LinearLayoutManager is used here, this will layout the elements in a similar fashion
        // to the way ListView would layout elements. The RecyclerView.LayoutManager defines how
        // elements are laid out.
        mLayoutManager = new LinearLayoutManager(getActivity());
        mRecyclerView.setLayoutManager(mLayoutManager);

        mAdapter = new RidesAdapter(mDataset);
        // Set CustomAdapter as the adapter for RecyclerView.
        mRecyclerView.setAdapter(mAdapter);
        // END_INCLUDE(initializeRecyclerView)

        Button fab = (Button) rootView.findViewById(R.id.fab);

        int SDK_INT = android.os.Build.VERSION.SDK_INT;

        if(SDK_INT == 21) {

            ViewOutlineProvider viewOutlineProvider = new ViewOutlineProvider() {
                @Override
                public void getOutline(View view, Outline outline) {
                    // Or read size directly from the view's width/height
                    int size = getResources().getDimensionPixelSize(R.dimen.fab_size);
                    outline.setOval(0, 0, size, size);
                }
            };

            fab.setOutlineProvider(viewOutlineProvider);

        }

        return rootView;
    }

    public void newRide(View item) {
        Intent intent = new Intent(getActivity(), NewRideActivity.class);
        startActivityForResult(intent, 1);
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && requestCode == 1) {
            Log.d("whereru", "onActivityResult called!!!");
            Ride newRide = new Ride();
            newRide.setDriver(new Person(data.getStringExtra("name")));
            newRide.setTitle(data.getStringExtra("title"));
            newRide.setHumanReadableDestination(data.getStringExtra("destination"));
            mDataset.add(newRide);
            mAdapter.notifyDataSetChanged();
        }

    }

    /**
     * Generates Strings for RecyclerView's adapter. This data would usually come
     * from a local content provider or remote server.
     */
    private void initDataset() {
        mDataset = new ArrayList<Ride>();
        for (int i=0; i < 60; i++) {
            mDataset.add(new Ride("This is ride #" + i, new Person("Brian Kelley")));
        }
    }

    public void addRide(Ride r) {
        mDataset.add(r);
        mAdapter.notifyDataSetChanged();
    }




}
