package me.where_r_u.whereru;

import android.support.v4.view.ViewCompat;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;


public class ShowRide extends ActionBarActivity {
    public static final String VIEW_NAME_HEADER_TITLE = "show:header:title";
    public static final String VIEW_NAME_HEADER_DRIVER = "show:header:driver";
    public static final String VIEW_NAME_HEADER_DESTINATION = "show:header:dest";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_ride);

        Bundle b = getIntent().getExtras();
        String title = b.getString("title");
        String driver = b.getString("driver");
        String hrdest = b.getString("dest");
        String rideID = b.getString("rideID");

        TextView titleTV = (TextView) findViewById(R.id.title);
        titleTV.setText(title);

        TextView driverTV = (TextView) findViewById(R.id.driver);
        driverTV.setText(driver);

        TextView hrDestTV = (TextView) findViewById(R.id.hrdest);
        hrDestTV.setText(hrdest);

        TextView rideIDTV = (TextView) findViewById(R.id.rideid);
        rideIDTV.setText(rideID);

        ViewCompat.setTransitionName(titleTV, VIEW_NAME_HEADER_TITLE);
        ViewCompat.setTransitionName(driverTV, VIEW_NAME_HEADER_DRIVER);
        ViewCompat.setTransitionName(hrDestTV, VIEW_NAME_HEADER_DESTINATION);

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_show_ride, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
