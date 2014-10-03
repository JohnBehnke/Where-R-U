package me.where_r_u.whereru;

import java.util.Locale;

import android.app.Activity;
import android.app.ActionBar;
import android.app.Fragment;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.model.*;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.graphics.drawable.Drawable;
import android.location.Location;
import android.support.v13.app.FragmentPagerAdapter;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.parse.Parse;
import com.parse.ParseAnalytics;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;


public class MyActivity extends Activity implements ActionBar.TabListener {

    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v13.app.FragmentStatePagerAdapter}.
     */
    SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    ViewPager mViewPager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Parse.initialize(this, "xvMUWOgtfsYb6hYIhog61pAyjmIsBYAmBkwcw1ih", "jttPcBwMtBnWbwGtDlcv5RaBIyFQy872e0XGExyE");

        login();

        setContentView(R.layout.activity_my);

        // Set up the action bar.
        final ActionBar actionBar = getActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);

        // Hide Actionbar Icon
        actionBar.setDisplayShowHomeEnabled(false);
        // Hide Actionbar Title
        actionBar.setDisplayShowTitleEnabled(false);

        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = (ViewPager) findViewById(R.id.pager);
        mViewPager.setAdapter(mSectionsPagerAdapter);

        // When swiping between different sections, select the corresponding
        // tab. We can also use ActionBar.Tab#select() to do this if we have
        // a reference to the Tab.
        mViewPager.setOnPageChangeListener(new ViewPager.SimpleOnPageChangeListener() {
            @Override
            public void onPageSelected(int position) {
                actionBar.setSelectedNavigationItem(position);
            }
        });

        Integer[] icons = {R.drawable.ic_map, R.drawable.ic_my_rides, R.drawable.ic_settings};

        // For each of the sections in the app, add a tab to the action bar.
        for (int i = 0; i < mSectionsPagerAdapter.getCount(); i++) {
            // Create a tab with text corresponding to the page title defined by
            // the adapter. Also specify this Activity object, which implements
            // the TabListener interface, as the callback (listener) for when
            // this tab is selected.
            actionBar.addTab(
                    actionBar.newTab()
                            .setText(mSectionsPagerAdapter.getPageTitle(i))
                            .setIcon(icons[i])
                            .setTabListener(this));
        }
    }

    private void login() {
        // Will be used for user authentication later
        // First, check to see if there is currently a user logged in.
        // If so, just go to the normal app
        // Else, redirect to the login screen.
        // Users can log in with Facebook or a Parse account they make with us.
//        ParseUser user = new ParseUser();
//        user.setUsername("myName");
//        user.setPassword("myPass");
//        user.setEmail("bkelley620@gmail.com");
//
//        // other fields can be set just like with ParseObject
//        user.put("phone", "650-555-0000");
//
//        user.signUpInBackground(new SignUpCallback() {
//            public void done(ParseException e) {
//                if(e == null) {
//                    // Hooray! Let them use the app now.
//                } else {
//                    // Sign up didn't succeed. Look at the ParseException
//                    // to figure out what went wrong
//                }
//            }
//        });
    }



    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if(id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onTabSelected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
        // When the given tab is selected, switch to the corresponding page in
        // the ViewPager.
        mViewPager.setCurrentItem(tab.getPosition());
    }

    @Override
    public void onTabUnselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    @Override
    public void onTabReselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            // getItem is called to instantiate the fragment for the given page.
            // Return a PlaceholderFragment (defined as a static inner class below).
            return PlaceholderFragment.newInstance(position + 1);
        }

        @Override
        public int getCount() {
            // Show 3 total pages.
            return 3;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            Locale l = Locale.getDefault();
            switch (position) {
                case 0:
                    return getString(R.string.title_section1);
                case 1:
                    return getString(R.string.title_section2);
                case 2:
                    return getString(R.string.title_section3);
            }
            return null;
        }
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment implements
            GooglePlayServicesClient.ConnectionCallbacks,
            GooglePlayServicesClient.OnConnectionFailedListener,
            LocationListener {
        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";

        int mNum;
        public GoogleMap map;
        private LocationRequest lr;
        private LocationClient lc;
        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(int sectionNumber) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        public PlaceholderFragment() {
        }

        @Override
        public void onDestroyView() {
            super.onDestroyView();
            MapFragment f = (MapFragment) getFragmentManager().findFragmentById(R.id.map1);
            if (f != null)
                getFragmentManager().beginTransaction().remove(f).commit();
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

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
            super.onActivityCreated(savedInstanceState);

            View rootView;

            mNum = getArguments() != null ? getArguments().getInt(ARG_SECTION_NUMBER) : 1;

            if(mNum == 1) {
                // Get a fragment manager and transaction to change the type of fragment we're gonna have.
                FragmentManager m = getFragmentManager();
                FragmentTransaction t = m.beginTransaction();

                t.replace(R.layout.fragment_my, new mapFragment());

                rootView = inflater.inflate(R.layout.fragment_map, container, false);

                map = ((MapFragment) getFragmentManager().findFragmentById(R.id.map1)).getMap();
                map.setMyLocationEnabled(true);
                map.getUiSettings().setMyLocationButtonEnabled(true);
                map.getUiSettings().setCompassEnabled(true);

                lr = LocationRequest.create();
                lr.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
                lc = new LocationClient(this.getActivity().getApplicationContext(), this, this);
                lc.connect();

          } else {
                // Get a fragment manager and transaction to change the type of fragment we're gonna have.
                FragmentManager m = getFragmentManager();
                FragmentTransaction t = m.beginTransaction();

                t.replace(R.layout.fragment_my, new PlaceholderFragment());

                rootView = inflater.inflate(R.layout.fragment_my, container, false);
                View tv = rootView.findViewById(R.id.mainText);
                ((TextView)tv).setText("Fragment #" + mNum);
            }

            return rootView;
        }
    }

}
