import React, { useContext } from 'react';
import './FoodDisplay.css';
import { StoreContext } from '../../context/StoreContext';
import FoodItem from '../FoodItem/FoodItem'; // <-- Importación necesaria

const FoodDisplay = ({ category }) => {
  const { food_list } = useContext(StoreContext);

  return (
    <div className="food-display" id="food-display">
      <h2>Los mejores productos cerca de ti</h2>
      <div className="food-display-list">
        {food_list
          .filter(item => category === "All" || item.category === category)
          .map((item, index) => {
            
            if(category === "All" || category===item.category) {
                return <FoodItem
              key={index}
              id={item._id}
              name={item.name}
              price={item.price}
              description={item.description}
              image={item.image}
            />
            }

})}
      </div>
    </div>
  );
};

export default FoodDisplay;
