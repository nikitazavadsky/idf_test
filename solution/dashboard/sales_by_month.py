"""
This modile implements web server - based dashboard with streamlit, pandas and plotly as a replacement of Metabase BI tool
"""
import streamlit as st
import pandas as pd
import plotly.express as px
import mysql.connector
import os

DATA_COLUMNS = ["product_code", "month", "sales", "percentage_diff"]

# DB connection params
DB_PARAMS = {
    "host": "host.docker.internal",
    "user": os.getenv("MYSQL_USER"),
    "password": os.getenv("MYSQL_PASSWORD"),
    "database": os.getenv("MYSQL_DATABASE"),
}

DEFAULT_TEST_PRODUCTS = ["Prod024", "Prod040"]


def get_data():
    """Fetch data from DB to build dashboard"""
    try:
        mysql_db = mysql.connector.connect(**DB_PARAMS)
        
        with mysql_db.cursor() as cursor:
            with open('./request.sql', 'r') as query_source:
                query = query_source.read()

            cursor.execute(query)

            df = pd.DataFrame(cursor.fetchall(), columns=DATA_COLUMNS)
            df['month'] = pd.to_datetime(df['month']).dt.strftime('%Y-%m')

            return df
        
    except Exception as e:
        st.error(f"An error occurred: {e}")
        return

# Streamlit configuration
st.set_page_config(
    page_title="Sales by Product and Month",
    layout="wide"
)
st.title("Sales by Month and Product")

df = get_data()

if df is not None:
    # Allow multiple product selections
    product_filters = st.multiselect("Select product codes", df["product_code"].unique(), default=DEFAULT_TEST_PRODUCTS)

    if len(product_filters) > 0:
        df_by_products = df[df["product_code"].isin(product_filters)] 
        
        # Create a line chart to visualize sales by month
        fig = px.line(df_by_products, x='month', y='sales', color='product_code')
        fig.update_xaxes(title='Month')
        fig.update_yaxes(title='Sales')

        line_chart, table_view = st.columns(2)

        with line_chart:
            st.header("Sales by Month chart")
            st.plotly_chart(fig)

        with table_view:
            st.header("Data for Selected Products")
            st.write(df_by_products)
