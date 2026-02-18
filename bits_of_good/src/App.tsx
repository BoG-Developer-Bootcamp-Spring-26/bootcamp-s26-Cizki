import React from 'react';
import logo from './logo.svg';
import './App.css';
import ProfileCard from './components/ProfileCard/ProfileCard';

function App() {
  const profiles = [
    {
      name: "Francisco",
      year: "first",
      homeState: "Georgia"
    },

    {
      name: "Frank",
      year: "second",
      homeState: "California",
    }
  ];

  return (
    <div className="container">
      {profiles.map((profile) => (
        <ProfileCard {...profile} />
      ))}
    </div>
  );
}

export default App;
