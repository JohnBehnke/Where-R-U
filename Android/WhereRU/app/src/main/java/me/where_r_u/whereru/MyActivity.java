package me.where_r_u.whereru;

import java.util.ArrayList;
import java.util.Locale;

import android.annotation.TargetApi;
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
import android.content.Intent;
import android.graphics.Outline;
import android.graphics.drawable.Drawable;
import android.location.Location;
import android.os.Build;
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
import android.view.ViewOutlineProvider;
import android.widget.Button;
import android.widget.TextView;
import com.parse.Parse;
import com.parse.ParseAnalytics;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;
import com.parse.ui.ParseLoginBuilder;


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


    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Parse.initialize(this, "xvMUWOgtfsYb6hYIhog61pAyjmIsBYAmBkwcw1ih", "jttPcBwMtBnWbwGtDlcv5RaBIyFQy872e0XGExyE");

//        while(ParseUser.getCurrentUser() == null) {
//            login(); // Comment out when testing so you don't get annoyed by needing to log in.
//        }
        setContentView(R.layout.activity_my);

        // Set up the action bar.
        final ActionBar actionBar = getActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);

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


        Integer[] icons = {R.drawable.ic_my_rides, R.drawable.ic_map};

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

        mSectionsPagerAdapter.mDataset = new ArrayList<Ride>();

    }


    public void onClickSettings(MenuItem item) {
        // Open the settings menu
        Intent intent = new Intent(this, SettingsActivity.class);
        startActivity(intent);

    }


    private void login() {
        // Will be used for user authentication later
        // First, check to see if there is currently a user logged in.
        // If so, just go to the normal app
        // Else, redirect to the login screen.
        // Users can log in with Facebook or a Parse account they make with us.

        ParseUser currentUser = ParseUser.getCurrentUser();

        if(currentUser == null) {
            // Log the user in
            ParseLoginBuilder builder = new ParseLoginBuilder(MyActivity.this);
            startActivityForResult(builder.build(), 0);
        }
        // Else, continue

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.my, menu);
        return true;
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

        public ArrayList<Ride> mDataset;

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }



        @Override
        public Fragment getItem(int position) {
            // getItem is called to instantiate the fragment for the given page.
            // Return a PlaceholderFragment (defined as a static inner class below).
            if(position == 0) {
                RidesFragment fragment = new RidesFragment();
                Log.d("whereru", "Rides fragment being created");
                fragment.fill(mDataset);
                return fragment;
            } else {
                return mapFragment.newInstance();
            }

        }

        @Override
        public int getCount() {
            // Show 2 total pages.
            return 2;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            Locale l = Locale.getDefault();
            switch (position) {
                case 0:
                    return getString(R.string.title_section1);
                case 1:
                    return getString(R.string.title_section2);
            }
            return null;
        }
    }

}
