import streamlit as st
import netCDF4 as nc
import numpy as np

def inspect_exodus_file(file_path):
    """Reads an Exodus II (.e) file and lists variables with user-friendly names."""
    dataset = nc.Dataset(file_path, mode='r')

    variables_info = {}
    user_friendly_names = {}  # Stores mapped names

    # Extracting user-defined names (if available)
    if "name_glo_var" in dataset.variables:
        user_friendly_names["Global Variables"] = dataset.variables["name_glo_var"][:]
    if "name_nod_var" in dataset.variables:
        user_friendly_names["Nodal Variables"] = dataset.variables["name_nod_var"][:]
    if "name_elem_var" in dataset.variables:
        user_friendly_names["Elemental Variables"] = dataset.variables["name_elem_var"][:]

    # Decode user-friendly names
    for category, var_array in user_friendly_names.items():
        decoded_names = []
        for i in range(var_array.shape[0]):
            name_bytes = var_array[i, :]
            if np.ma.is_masked(name_bytes):
                name_bytes = name_bytes.compressed()
            try:
                name_str = "".join(
                    c.tobytes().decode("utf-8", errors="ignore") if isinstance(c, np.bytes_) else str(c)
                    for c in name_bytes
                ).strip()
            except Exception:
                name_str = f"Var_{i+1}"  # Fallback
            decoded_names.append(name_str)
        user_friendly_names[category] = decoded_names

    # Extract all variable data
    for var_name in dataset.variables.keys():
        try:
            var_data = dataset.variables[var_name][:]
            if var_data.ndim == 1 and var_data.dtype.kind in {'S', 'U'}:
                variables_info[var_name] = [str(v) for v in var_data]
            else:
                variables_info[var_name] = f"Shape: {var_data.shape}, Type: {var_data.dtype}"
        except Exception as e:
            variables_info[var_name] = f"Error reading: {e}"

    dataset.close()
    return variables_info, user_friendly_names

# Streamlit App
st.title("Exodus II File Inspector")

uploaded_file = st.file_uploader("Upload an Exodus II file", type=["e", "exo", "nc"])

if uploaded_file is not None:
    temp_file_path = "temp_exodus_file.e"
    with open(temp_file_path, "wb") as f:
        f.write(uploaded_file.getbuffer())

    # Inspect the file
    file_info, user_names = inspect_exodus_file(temp_file_path)

    # Display results
    st.subheader("📌 Mapped User-Friendly Variables")
    for category, names in user_names.items():
        st.write(f"### {category}")
        st.text_area(f"🔹 {category} Variables", "\n".join(names), height=150)

    st.subheader("📌 Raw Variables in the Exodus II File")
    for var_name, var_value in file_info.items():
        st.text_area(f"🔹 {var_name}", str(var_value), height=150)

