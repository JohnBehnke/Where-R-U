package me.where_r_u.whereru;

import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by kelleb3 on 11/21/14.
 */
public class RidesAdapter extends RecyclerView.Adapter<RidesAdapter.ViewHolder> {

    private static final String TAG = "CustomAdapter";

    private ArrayList<Ride> mDataSet;

    // BEGIN_INCLUDE(recyclerViewSampleViewHolder)
    /**
     * Provide a reference to the type of views that you are using (custom viewholder)
     */

    public static class ViewHolder extends RecyclerView.ViewHolder {
        private final TextView rideTitle;
        private final TextView driverName;
        private final TextView destination;

        public ViewHolder(View v) {
            super(v);
            rideTitle = (TextView) v.findViewById(R.id.rideTitle);
            driverName = (TextView) v.findViewById(R.id.driverName);
            destination = (TextView) v.findViewById(R.id.destination);
        }

        public TextView getRideTitle() {
            return rideTitle;
        }

        public TextView getDriverName() {
            return driverName;
        }

        public TextView getDestination() {
            return destination;
        }
    }

    // END_INCLUDE(recyclerViewSampleViewHolder)
    /**
     * Initialize the dataset of the Adapter.
     *
     * @param dataSet String[] containing the data to populate views to be used by RecyclerView.
     */
    public RidesAdapter(ArrayList<Ride> dataSet) {
        mDataSet = dataSet;
    }



    // BEGIN_INCLUDE(recyclerViewOnCreateViewHolder)
    // Create new views (invoked by the layout manager)
    public ViewHolder onCreateViewHolder(ViewGroup viewGroup, int position) {
        // Create a new view.
        View v = LayoutInflater.from(viewGroup.getContext())
                .inflate(R.layout.row, viewGroup, false);

        ViewHolder vh = new ViewHolder(v);
        return vh;
    }
    // END_INCLUDE(recyclerViewOnCreateViewHolder)

    // BEGIN_INCLUDE(recyclerViewOnBindViewHolder)
    // Replace the contents of a view (invoked by the layout manager)
    public void onBindViewHolder(ViewHolder viewHolder, int position) {
        // Get element from your dataset at this position and replace the contents of the view
        // with that element
        viewHolder.getRideTitle().setText(mDataSet.get(position).getTitle());
        viewHolder.getDriverName().setText("Driver: " + mDataSet.get(position).getDriver().getName());
        viewHolder.getDestination().setText("Destination: " + mDataSet.get(position).getHumanReadableDestination());
    }
    // END_INCLUDE(recyclerViewOnBindViewHolder)

    // Return the size of your dataset (invoked by the layout manager)
    public int getItemCount() {
        if (mDataSet != null) {
            return mDataSet.size();
        } else {
            return 0;
        }
    }
}
