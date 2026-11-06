document.addEventListener('DOMContentLoaded', () => {
  // Dish database for interactive scanner preview
  const dishDatabase = {
    avocado: {
      title: 'Sourdough Avocado Toast',
      healthGrade: 'Grade A (92/100)',
      calories: '340 kcal',
      calPercent: '68%',
      protein: '12g',
      proPercent: '24%',
      carbs: '38g',
      carbPercent: '42%',
      fats: '18g',
      fatPercent: '36%',
      ingredients: ['Artisan Sourdough', 'Hass Avocado', 'Extra Virgin Olive Oil', 'Chili Flakes', 'Flaky Sea Salt', 'Hemp Hearts']
    },
    salmon: {
      title: 'Wild Salmon Quinoa Bowl',
      healthGrade: 'Grade A+ (96/100)',
      calories: '520 kcal',
      calPercent: '82%',
      protein: '42g',
      proPercent: '84%',
      carbs: '46g',
      carbPercent: '50%',
      fats: '16g',
      fatPercent: '32%',
      ingredients: ['Pan-Seared Salmon', 'Tri-Color Quinoa', 'Steamed Broccoli', 'Edamame', 'Sesame Ginger Dressing', 'Avocado Slices']
    },
    greek: {
      title: 'Classic Mediterranean Greek Salad',
      healthGrade: 'Grade A (89/100)',
      calories: '260 kcal',
      calPercent: '52%',
      protein: '9g',
      proPercent: '18%',
      carbs: '14g',
      carbPercent: '16%',
      fats: '20g',
      fatPercent: '40%',
      ingredients: ['Persian Cucumbers', 'Vine Tomatoes', 'Kalamata Olives', 'Authentic Greek Feta', 'Red Onion', 'Oregano Vinaigrette']
    },
    lentil: {
      title: 'Red Lentil Dal with Basmati Rice',
      healthGrade: 'Grade A (91/100)',
      calories: '410 kcal',
      calPercent: '74%',
      protein: '18g',
      proPercent: '36%',
      carbs: '68g',
      carbPercent: '72%',
      fats: '6g',
      fatPercent: '12%',
      ingredients: ['Organic Red Lentils', 'Turmeric', 'Cumin Seeds', 'Garlic Ginger Paste', 'Aromatic Basmati Rice', 'Fresh Cilantro']
    }
  };

  // Dish selection click handler
  const dishOptions = document.querySelectorAll('.dish-option');
  const simTitle = document.getElementById('sim-dish-title');
  const simHealth = document.getElementById('sim-health-score');
  const valCal = document.getElementById('val-cal');
  const valPro = document.getElementById('val-pro');
  const valCarb = document.getElementById('val-carb');
  const valFat = document.getElementById('val-fat');
  const fillCal = document.getElementById('fill-cal');
  const fillPro = document.getElementById('fill-pro');
  const fillCarb = document.getElementById('fill-carb');
  const fillFat = document.getElementById('fill-fat');
  const tagsContainer = document.getElementById('sim-tags');

  dishOptions.forEach(opt => {
    opt.addEventListener('click', () => {
      dishOptions.forEach(d => d.classList.remove('active'));
      opt.classList.add('active');

      const dishKey = opt.getAttribute('data-dish');
      const data = dishDatabase[dishKey];

      if (data) {
        simTitle.textContent = data.title;
        simHealth.textContent = data.healthGrade;
        valCal.textContent = data.calories;
        valPro.textContent = data.protein;
        valCarb.textContent = data.carbs;
        valFat.textContent = data.fats;

        fillCal.style.width = data.calPercent;
        fillPro.style.width = data.proPercent;
        fillCarb.style.width = data.carbPercent;
        fillFat.style.width = data.fatPercent;

        tagsContainer.innerHTML = '';
        data.ingredients.forEach(item => {
          const span = document.createElement('span');
          span.className = 'tag';
          span.textContent = item;
          tagsContainer.appendChild(span);
        });
      }
    });
  });

  // Currency converter interactive demo
  const rates = {
    USD: { symbol: '$', rate: 1.0, decimals: 2 },
    BDT: { symbol: '৳', rate: 122.50, decimals: 2 },
    EUR: { symbol: '€', rate: 0.92, decimals: 2 },
    GBP: { symbol: '£', rate: 0.79, decimals: 2 },
    INR: { symbol: '₹', rate: 83.00, decimals: 2 },
    SAR: { symbol: 'ر.س', rate: 3.75, decimals: 2 },
    AED: { symbol: 'د.إ', rate: 3.67, decimals: 2 },
    JPY: { symbol: '¥', rate: 153.00, decimals: 0 }
  };

  const currencySelect = document.getElementById('currency-select');
  const convertedDisplay = document.getElementById('converted-price-display');

  if (currencySelect && convertedDisplay) {
    currencySelect.addEventListener('change', () => {
      const code = currencySelect.value;
      const baseUSD = 14.50;
      const cur = rates[code];
      if (cur) {
        const converted = (baseUSD * cur.rate).toLocaleString(undefined, {
          minimumFractionDigits: cur.decimals,
          maximumFractionDigits: cur.decimals
        });
        if (code === 'USD') {
          convertedDisplay.textContent = `$${converted}`;
        } else {
          convertedDisplay.textContent = `${cur.symbol} ${converted} ($${baseUSD.toFixed(2)})`;
        }
      }
    });
  }

  // Mobile menu toggle
  const mobileBtn = document.querySelector('.mobile-menu-btn');
  const navLinks = document.querySelector('.nav-links');

  if (mobileBtn && navLinks) {
    mobileBtn.addEventListener('click', () => {
      const isVisible = navLinks.style.display === 'flex';
      navLinks.style.display = isVisible ? 'none' : 'flex';
      if (!isVisible) {
        navLinks.style.flexDirection = 'column';
        navLinks.style.position = 'absolute';
        navLinks.style.top = '100%';
        navLinks.style.left = '0';
        navLinks.style.right = '0';
        navLinks.style.background = '#090d16';
        navLinks.style.padding = '1.5rem';
        navLinks.style.borderBottom = '1px solid var(--border-color)';
      }
    });
  }
});
