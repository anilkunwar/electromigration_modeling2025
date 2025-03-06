import streamlit as st
import netCDF4 as nc
import numpy as np
import plotly.express as px
import tempfile
import os
import pandas as pd  # Import pandas for data manipulation

def read_exodus_file(file_path):
    """Reads an Exodus II (.e) file using netCDF4 and extracts key information."""
    dataset = nc.Dataset(file_path, mode='r')

    # Extract time steps
    time_steps = dataset.variables['time_whole'][:] if 'time_whole' in dataset.variables else np.array([0])

    # Extract coordinates
    x = dataset.variables['coordx'][:]
    y = dataset.variables['coordy'][:]
    z = dataset.variables['coordz'][:] if 'coordz' in dataset.variables else np.zeros_like(x)

    # Determine the number of node variables dynamically
    num_nod_var = dataset.dimensions["num_nod_var"].size

    # Read node variable names (handling bytes and masked values)
    nod_var_names = []
    for i in range(num_nod_var):
        name_bytes = dataset["name_nod_var"][i, :].compressed() if np.ma.is_masked(dataset["name_nod_var"][i, :]) else dataset["name_nod_var"][i, :]
        name_str = "".join(c.tobytes().decode("utf-8") if isinstance(c, np.bytes_) else str(c) for c in name_bytes).strip()
        nod_var_names.append(name_str)

    # Read all node variables into a dictionary
    node_data = {}
    for i, name in enumerate(nod_var_names):
        var_name = f"vals_nod_var{i+1}"
        if var_name in dataset.variables:
            node_data[name] = dataset.variables[var_name][:]
        else:
            print(f"Warning: Variable '{var_name}' not found in dataset.")

    # Extract mesh shape
    num_nodes = len(x)
    num_elements = dataset.dimensions['num_elem'].size if 'num_elem' in dataset.dimensions else None

    dataset.close()

    return {
        "time_steps": time_steps,
        "coordinates": (x, y, z),
        "nodal_data": node_data,
        "nodal_vars": nod_var_names,
        "mesh_shape": (num_nodes, num_elements)
    }

def visualize_data(data, selected_var, selected_time_idx, color_scale):
    """Visualizes the nodal data in 2D using Plotly."""
    x, y, z = data["coordinates"]
    var_values = data["nodal_data"][selected_var][selected_time_idx]

    # Convert data to DataFrame for Plotly
    df = pd.DataFrame({
        'x': x,
        'y': y,
        selected_var: var_values
    })

    # Plot data using Plotly (2D scatter)
    fig = px.scatter(df, x='x', y='y', color=selected_var, labels={"color": selected_var},
                     title=f"Variable: {selected_var} at Time Step {selected_time_idx}",
                     color_continuous_scale=color_scale, opacity=0.7)

    # Set the plot size manually to avoid shrinking the figure
    fig.update_layout(
        width=800,  # Adjust width as needed
        height=800,  # Adjust height as needed
        xaxis=dict(scaleanchor="y"),
        yaxis=dict(scaleanchor="x"),
        showlegend=False  # Optional: hide the legend if you don't need it
    )

    return fig

# Streamlit UI
st.title("Exodus II (.e-s002) File Reader & Visualizer")

uploaded_file = st.file_uploader("Upload an Exodus II (.e-s002) file", type=None)  # Allow any file type

if uploaded_file:
    # Save the uploaded file temporarily
    with tempfile.NamedTemporaryFile(delete=False) as temp_file:
        temp_file.write(uploaded_file.read())
        temp_filename = temp_file.name

    # Read file data
    try:
        data = read_exodus_file(temp_filename)
        os.remove(temp_filename)  # Clean up the temp file

        # Display file information
        st.subheader("File Information")
        st.write(f"**Time Steps:** {len(data['time_steps'])}")
        st.write(f"**Mesh Shape:** {data['mesh_shape'][0]} nodes, {data['mesh_shape'][1]} elements")
        st.write(f"**Available Variables:** {', '.join(data['nodal_vars'])}")

        # Let user choose a variable
        selected_var = st.selectbox("Select a nodal variable", data['nodal_vars'])

        # Let user select a color scale
        color_scales = ['Viridis', 'Cividis', 'Plasma', 'Inferno', 'Magma', 'Turbo', 'RdBu', 'Jet', 'Blues']
        selected_color_scale = st.selectbox("Select a color scale", color_scales)

        # Handle cases where only 1 time step exists
        if len(data['time_steps']) > 1:
            selected_time_idx = st.slider("Select time step", 0, len(data['time_steps']) - 1, 0)
        else:
            selected_time_idx = 0  # If only one time step, set default value

        # Visualize the selected data
        st.subheader("Visualization")
        fig = visualize_data(data, selected_var, selected_time_idx, selected_color_scale)
        st.plotly_chart(fig)

    except Exception as e:
        st.error(f"Error reading file: {e}")

