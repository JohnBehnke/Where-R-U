package me.where_r_u.whereru;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;


public class NewRideActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setTitle("Create a New Ride");
        setContentView(R.layout.activity_new_ride);
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

    public void createRide(View v) {
        String name = ((EditText) findViewById(R.id.driverName)).getText().toString();
        String title = ((EditText) findViewById(R.id.rideTitle)).getText().toString();
        String destination = ((EditText) findViewById(R.id.destination)).getText().toString();

        Context context = getApplicationContext();

        int duration = Toast.LENGTH_SHORT;

        if (name.trim().length() > 0) {
            if (title.trim().length() > 0) {


                if (destination.trim().length() > 0) {

                    Intent resultData = new Intent();
                    resultData.putExtra("name", name);
                    resultData.putExtra("title", title);
                    resultData.putExtra("destination", destination);
                    setResult(Activity.RESULT_OK, resultData);

                    finish();
                } else {
                    CharSequence text = "Enter a destination!";
                    Toast toast = Toast.makeText(context, text, duration);
                    toast.show();
                }

            } else {
                CharSequence text = "Enter the driver's name!";
                Toast toast = Toast.makeText(context, text, duration);
                toast.show();
            }

        } else {
            CharSequence text = "Enter a title for the ride!";
            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }


    }

}