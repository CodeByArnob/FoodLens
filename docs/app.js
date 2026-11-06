document.addEventListener('DOMContentLoaded', () => {
  // Dish database with baseline values for 1 serving
  const dishDatabase = {
    avocado: {
      title: 'Sourdough Avocado Toast',
      portion: '1 Serving (180g)',
      healthGrade: 'Grade A (92/100)',
      baseCalories: 340,
      baseProtein: 12,
      baseCarbs: 38,
      baseFats: 18,
      ingredients: ['Artisan Sourdough', 'Hass Avocado', 'Extra Virgin Olive Oil', 'Chili Flakes', 'Flaky Sea Salt', 'Hemp Hearts']
    },
    salmon: {
      title: 'Wild Salmon Quinoa Bowl',
      portion: '1 Bowl (320g)',
      healthGrade: 'Grade A+ (96/100)',
      baseCalories: 520,
      baseProtein: 42,
      baseCarbs: 46,
      baseFats: 16,
      ingredients: ['Pan-Seared Salmon', 'Tri-Color Quinoa', 'Steamed Broccoli', 'Edamame', 'Sesame Ginger Dressing', 'Avocado Slices']
    },
    greek: {
      title: 'Mediterranean Greek Salad',
      portion: '1 Plate (240g)',
      healthGrade: 'Grade A (89/100)',
      baseCalories: 260,
      baseProtein: 9,
      baseCarbs: 14,
      baseFats: 20,
      ingredients: ['Persian Cucumbers', 'Vine Tomatoes', 'Kalamata Olives', 'Authentic Greek Feta', 'Red Onion', 'Oregano Vinaigrette']
    },
    lentil: {
      title: 'Red Lentil Dal with Basmati Rice',
      portion: '1 Bowl (350g)',
      healthGrade: 'Grade A (91/100)',
      baseCalories: 410,
      baseProtein: 18,
      baseCarbs: 68,
      baseFats: 6,
      ingredients: ['Organic Red Lentils', 'Turmeric', 'Cumin Seeds', 'Garlic Ginger Paste', 'Aromatic Basmati Rice', 'Fresh Cilantro']
    }
  };

  let currentDishKey = 'avocado';
  let currentMultiplier = 1.0;

  // DOM Elements for Dish Simulator
  const dishOptions = document.querySelectorAll('.dish-option');
  const simTitle = document.getElementById('sim-dish-title');
  const simPortion = document.getElementById('sim-portion-label');
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
  const servingButtons = document.querySelectorAll('.serving-btn');

  function updateSimulator() {
    const data = dishDatabase[currentDishKey];
    if (!data) return;

    const cal = Math.round(data.baseCalories * currentMultiplier);
    const pro = Math.round(data.baseProtein * currentMultiplier);
    const carb = Math.round(data.baseCarbs * currentMultiplier);
    const fat = Math.round(data.baseFats * currentMultiplier);

    simTitle.textContent = data.title;
    if (simPortion) {
      simPortion.textContent = `Estimated Portion: ${data.portion} (${currentMultiplier}x)`;
    }
    simHealth.textContent = data.healthGrade;

    valCal.textContent = `${cal} kcal`;
    valPro.textContent = `${pro}g`;
    valCarb.textContent = `${carb}g`;
    valFat.textContent = `${fat}g`;

    // Maximum references for daily limits
    fillCal.style.width = `${Math.min(100, Math.round((cal / 600) * 100))}%`;
    fillPro.style.width = `${Math.min(100, Math.round((pro / 50) * 100))}%`;
    fillCarb.style.width = `${Math.min(100, Math.round((carb / 80) * 100))}%`;
    fillFat.style.width = `${Math.min(100, Math.round((fat / 40) * 100))}%`;

    tagsContainer.innerHTML = '';
    data.ingredients.forEach(item => {
      const span = document.createElement('span');
      span.className = 'tag';
      span.textContent = item;
      tagsContainer.appendChild(span);
    });
  }

  dishOptions.forEach(opt => {
    opt.addEventListener('click', () => {
      dishOptions.forEach(d => d.classList.remove('active'));
      opt.classList.add('active');
      currentDishKey = opt.getAttribute('data-dish');
      updateSimulator();
    });
  });

  servingButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      servingButtons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentMultiplier = parseFloat(btn.getAttribute('data-mult')) || 1.0;
      updateSimulator();
    });
  });

  // Currency Converter Calculator
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
  const presetButtons = document.querySelectorAll('.price-preset-btn');
  let currentBaseUSD = 14.50;

  function calculateCurrency() {
    if (!currencySelect || !convertedDisplay) return;
    const code = currencySelect.value;
    const cur = rates[code];
    if (cur) {
      const converted = (currentBaseUSD * cur.rate).toLocaleString(undefined, {
        minimumFractionDigits: cur.decimals,
        maximumFractionDigits: cur.decimals
      });
      if (code === 'USD') {
        convertedDisplay.textContent = `$${converted}`;
      } else {
        convertedDisplay.textContent = `${cur.symbol} ${converted} ($${currentBaseUSD.toFixed(2)})`;
      }
    }
  }

  if (currencySelect) {
    currencySelect.addEventListener('change', calculateCurrency);
  }

  presetButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      presetButtons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentBaseUSD = parseFloat(btn.getAttribute('data-price')) || 14.50;
      calculateCurrency();
    });
  });

  // Screenshot Gallery Filtering
  const filterButtons = document.querySelectorAll('.filter-btn');
  const galleryCards = document.querySelectorAll('.gallery-card');

  filterButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      filterButtons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      const category = btn.getAttribute('data-filter');

      galleryCards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');
        if (category === 'all' || cardCategory === category) {
          card.style.display = 'block';
        } else {
          card.style.display = 'none';
        }
      });
    });
  });

  // Screenshot Lightbox Modal
  const lightboxModal = document.getElementById('lightbox-modal');
  const lightboxImg = document.getElementById('lightbox-img');
  const lightboxTitle = document.getElementById('lightbox-title');
  const lightboxClose = document.getElementById('lightbox-close');

  galleryCards.forEach(card => {
    card.addEventListener('click', () => {
      const img = card.querySelector('img');
      const title = card.querySelector('h4');
      if (lightboxModal && lightboxImg && img) {
        lightboxImg.src = img.src;
        lightboxImg.alt = img.alt;
        if (lightboxTitle && title) {
          lightboxTitle.textContent = title.textContent;
        }
        lightboxModal.classList.add('active');
        document.body.style.overflow = 'hidden';
      }
    });
  });

  function closeLightbox() {
    if (lightboxModal) {
      lightboxModal.classList.remove('active');
      document.body.style.overflow = '';
    }
  }

  if (lightboxClose) {
    lightboxClose.addEventListener('click', closeLightbox);
  }

  if (lightboxModal) {
    lightboxModal.addEventListener('click', (e) => {
      if (e.target === lightboxModal) {
        closeLightbox();
      }
    });
  }

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeLightbox();
    }
  });

  // Mobile Navigation Drawer
  const mobileBtn = document.querySelector('.mobile-menu-btn');
  const mobileDrawer = document.getElementById('mobile-drawer');

  if (mobileBtn && mobileDrawer) {
    mobileBtn.addEventListener('click', () => {
      const isOpen = mobileDrawer.classList.contains('open');
      if (isOpen) {
        mobileDrawer.classList.remove('open');
        mobileBtn.textContent = '☰';
      } else {
        mobileDrawer.classList.add('open');
        mobileBtn.textContent = '✕';
      }
    });

    // Close drawer when clicking any link inside it
    const drawerLinks = mobileDrawer.querySelectorAll('a');
    drawerLinks.forEach(link => {
      link.addEventListener('click', () => {
        mobileDrawer.classList.remove('open');
        mobileBtn.textContent = '☰';
      } );
    });
  }

  // Back to Top Button
  const backToTop = document.getElementById('back-to-top');
  window.addEventListener('scroll', () => {
    if (backToTop) {
      if (window.scrollY > 400) {
        backToTop.classList.add('visible');
      } else {
        backToTop.classList.remove('visible');
      }
    }
  });

  if (backToTop) {
    backToTop.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }
});
