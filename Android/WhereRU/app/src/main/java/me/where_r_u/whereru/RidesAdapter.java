package me.where_r_u.whereru;

import android.app.Activity;
import android.app.ActivityOptions;
import android.content.Context;
import android.content.Intent;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.ActivityOptionsCompat;
import android.support.v4.util.Pair;
import android.support.v4.view.ViewCompat;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.util.SparseBooleanArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.TableLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

import static android.view.View.OnLongClickListener;

public class RidesAdapter extends RecyclerView.Adapter<RidesAdapter.ViewHolder> {

    private static final String TAG = "RidesAdapter";
    public List<Ride> mDataSet;
    private static int numSelected = 0;


    // BEGIN_INCLUDE(recyclerViewSampleViewHolder)
    /**
     * Provide a reference to the type of views that you are using (custom viewholder)
     */

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final TextView rideTitle;
        private final TextView driverName;
        private final TextView destination;
        private final TableLayout row;
        public Boolean isSelected;
        private Ride mRide;
        private Context context;
        private View v;

        private View.OnClickListener mOnItemClickListener;


        public ViewHolder(View v) {
            super(v);
            context = v.getContext();
            rideTitle = (TextView) v.findViewById(R.id.rideTitle);
            driverName = (TextView) v.findViewById(R.id.driverName);
            destination = (TextView) v.findViewById(R.id.destination);
            row = (TableLayout) v.findViewById(R.id.layout);
            this.v = v;
            isSelected = false;

            row.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    //Log.d("whereru", "3=================D " + rideTitle.getText().toString());

                    if (OneOrMoreSelected()) {
                        toggleHighlight();
                    } else {
                        final Intent intent;
                        intent = new Intent(context, ShowRide.class);
                        Bundle b = new Bundle();
                        b.putString("title", mRide.getTitle());
                        b.putString("driver", mRide.getDriver().getName());
                        b.putString("dest", mRide.getHumanReadableDestination());
                        b.putString("rideID", mRide.getRideId());
                        intent.putExtras(b);

                        Pair pair1 = new Pair<View, String>(v.findViewById(R.id.rideTitle), ShowRide.VIEW_NAME_HEADER_TITLE);
                        Pair pair2 = new Pair<View, String>(v.findViewById(R.id.driverName), ShowRide.VIEW_NAME_HEADER_DRIVER);
                        Pair pair3 = new Pair<View, String>(v.findViewById(R.id.destination), ShowRide.VIEW_NAME_HEADER_DESTINATION);

//                        ActivityOptions.makeSceneTransitionAnimation(this).toBundle()
                        if (android.os.Build.VERSION.SDK_INT >= 16) {
                            context.startActivity(intent,
                                    ActivityOptionsCompat.makeSceneTransitionAnimation(
                                            (MainActivity) context, pair1, pair2, pair3).toBundle());
                        }
                    }
                }});

            row.setOnLongClickListener(new OnLongClickListener() {
                @Override
                public boolean onLongClick(View v) {
                    toggleHighlight();
                    //RidesAdapter.this.notifyDataSetChanged();
                    if (numSelected == 0) {
                        // make menu the usual
                        ((MainActivity) context).itemsSelected = false;
                        ((MainActivity) context).invalidateOptionsMenu();
                    } else {
                        // make menu contextual
                        ((MainActivity) context).itemsSelected = true;
                        ((MainActivity) context).invalidateOptionsMenu();
                    }
                    return true;
                }
            });

        }

        public void bind(Ride ride){
            mRide = ride;
            rideTitle.setText(ride.getTitle());
            driverName.setText(ride.getDriver().getName());
            destination.setText(ride.getHumanReadableDestination());

        }

        public void toggleHighlight() {
            if (isSelected) {
                v.setBackgroundColor(Color.parseColor("#eeeeee"));
                numSelected--;
                isSelected = false;
            } else {
                v.setBackgroundColor(Color.BLUE);
                numSelected++;
                isSelected = true;
            }
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

        public void setRideTitle(String newText) {
            rideTitle.setText(newText);
        }

        public void setDriverName(String newText) {
            driverName.setText(newText);
        }

        public void setDestination(String newText) {
            driverName.setText(newText);
        }
    }

    private static boolean OneOrMoreSelected() {
        return numSelected > 0;
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
    public ViewHolder onCreateViewHolder(ViewGroup viewGroup, int position)  {
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
        viewHolder.bind(mDataSet.get(position));
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

    public void addEntity(int i, Ride ride) {
        mDataSet.add(i, ride);
        notifyItemInserted(i);
    }

    public void deleteEntity(int i) {
        mDataSet.remove(i);
        notifyItemRemoved(i);
    }

    public void moveEntity(int i, int loc) {
        move(mDataSet, i, loc);
        notifyItemMoved(i, loc);
    }

    private void move(List<Ride> data, int a, int b) {
        Ride temp = data.remove(a);
        data.add(b, temp);
    }

    public void setData(final List<Ride> data) {
        // Remove all deleted items.
        for (int i = mDataSet.size() - 1; i >= 0; --i) {
            if (getLocation(data, mDataSet.get(i)) < 0) {
                deleteEntity(i);
            }
        }

        // Add and move items.
        for (int i = 0; i < data.size(); ++i) {
            Ride ride = data.get(i);
            int loc = getLocation(mDataSet, ride);
            if (loc < 0) {
                addEntity(i, ride);
            } else if (loc != i) {
                moveEntity(i, loc);

            }
        }
    }
    private int getLocation(List<Ride> data, Ride ride) {
        for (int j = 0; j < data.size(); ++j) {
            Ride newRide = data.get(j);
            if (ride.equals(newRide)) {
                return j;
            }
        }

        return -1;
    }
}
