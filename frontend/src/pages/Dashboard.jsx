import React, { useEffect, useState } from 'react'
import "../styles/Dashboard.css";
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import axios from 'axios';

const Dashboard = () => {
  const [token, setToken] = useState(JSON.parse(localStorage.getItem("auth")) || "");
  const [data, setData] = useState({});
  const navigate = useNavigate();

  const fetchLuckyNumber = async () => {

    let axiosConfig = {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    };

    try {
      const response = await axios.get("http://localhost:3000/api/v1/dashboard", axiosConfig);
      setData({ msg: response.data.msg, luckyNumber: response.data.secret });
    } catch (error) {
      toast.error(error.message);
    }
  }



  useEffect(() => {
    fetchLuckyNumber();
    if (token === "") {
      navigate("/login");
      toast.warn("Please login first to access dashboard");
    }
  }, [token]);

  return (
    <div className='dashboard-main'>
      <h1>Here's Your Lucky Number</h1>
      <p className="text-xl font-semibold text-gray-700 bg-gradient-to-r from-purple-200 via-pink-200 to-yellow-200 px-4 py-2 rounded-lg shadow-md inline-block">
        Hi <span className="text-purple-600">{data.msg}</span>!  
        <span className="ml-2 text-2xl font-extrabold text-orange-600">{ data.luckyNumber}</span>
      </p>
    

      <Link to="/logout" className="logout-button">Logout</Link>
    </div>
  )
}

export default Dashboard