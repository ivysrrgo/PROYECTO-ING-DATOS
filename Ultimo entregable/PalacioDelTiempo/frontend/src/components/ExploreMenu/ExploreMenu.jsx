import React from 'react';
import './ExploreMenu.css';
import { menu_list } from '../../assets/assets';

const ExploreMenu = ({ category = "All", setCategory = () => {} }) => {
  return (
    <div className='explore-menu' id='explore-menu'>
      <h1>Explore nuestro catálogo</h1>
      <p className='explore-menu-text'>
        Descubre una variedad de productos que se adaptan a tus necesidades y gustos.
      </p>
      <div className="explore-menu-list">
        {menu_list.map((item, index) => (
          <div
            key={index}
            onClick={() =>
              setCategory(prev => (prev === item.menu_name ? "All" : item.menu_name))
            }
            className='explore-menu-list-item'
          >
            <img className={category===item.menu_name?"active":""} src={item.menu_image} alt={item.menu_name} />
            <p>{item.menu_name}</p>
          </div>
        ))}
      </div>
      <hr />
    </div>
  );
};

export default ExploreMenu;

