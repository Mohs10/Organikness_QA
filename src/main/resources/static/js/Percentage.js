const demoData = [
    { name: 'Barley', percentage: 20 },
    { name: 'Maize', percentage: 80 },
    { name: 'Fruit', percentage: 10 },
    { name: 'Rice', percentage: 45 },
    { name: 'Wheat', percentage: 80 },
    { name: 'Rice', percentage: 45 },
    { name: 'Wheat', percentage: 80 }
  ];
  
  const cropPercentageGroup = document.getElementById('cropPercentageGroup');
  
  demoData.forEach(crop => {
    const cropPercentageItem = document.createElement('div');
    cropPercentageItem.classList.add('crop-percentage-item');
  
    cropPercentageItem.innerHTML = `
      <div class="crop-name">${crop.name}</div>
      <div class="percentage">
        <div class="progress-bars" style="width: ${crop.percentage}%;">
          ${crop.percentage}%
        </div>
      </div>
    `;
  
    cropPercentageGroup.appendChild(cropPercentageItem);
  });
  