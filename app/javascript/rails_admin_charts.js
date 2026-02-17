// RailsAdmin Charts Helper
// Инициализация и управление графиками ApexCharts

(function() {
  'use strict';
  
  // Глобальные переменные для хранения экземпляров графиков
  window.railsAdminCharts = {
    charts: {},
    
    // Инициализация всех графиков на странице
    init: function() {
      this.initUserRegistrationsChart();
      this.initProjectsChart();
      this.initRevenueChart();
      this.initActivityChart();
      this.initConversionFunnel();
      this.initTokenPackagesChart();
      this.initStylesChart();
    },
    
    // Загрузка данных через AJAX
    loadData: function(endpoint, params, callback) {
      const url = new URL(endpoint, window.location.origin);
      Object.keys(params || {}).forEach(key => {
        url.searchParams.append(key, params[key]);
      });
      
      fetch(url, {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
        credentials: 'same-origin'
      })
      .then(response => response.json())
      .then(data => {
        if (callback) callback(data);
      })
      .catch(error => {
        console.error('Error loading chart data:', error);
      });
    },
    
    // График регистраций пользователей
    initUserRegistrationsChart: function() {
      const container = document.getElementById('user-registrations-chart');
      if (!container) return;
      
      const period = container.dataset.period || 'week';
      
      this.loadData('/rails_admin/statistics/user_registrations', { period: period }, (data) => {
        const options = {
          series: [{
            name: 'Регистрации',
            data: data.values
          }],
          chart: {
            type: 'line',
            height: 300,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          colors: ['#00e0ff'],
          stroke: {
            width: 3,
            curve: 'smooth'
          },
          xaxis: {
            categories: data.labels,
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          yaxis: {
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          grid: {
            borderColor: '#1e2632',
            strokeDashArray: 4
          },
          tooltip: {
            theme: 'dark'
          }
        };
        
        this.charts.userRegistrations = new ApexCharts(container, options);
        this.charts.userRegistrations.render();
      });
    },
    
    // График создания проектов
    initProjectsChart: function() {
      const container = document.getElementById('projects-chart');
      if (!container) return;
      
      const period = container.dataset.period || 'week';
      
      this.loadData('/rails_admin/statistics/projects', { period: period }, (data) => {
        const options = {
          series: [{
            name: 'Проекты',
            data: data.values
          }],
          chart: {
            type: 'line',
            height: 300,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          colors: ['#2f6cff'],
          stroke: {
            width: 3,
            curve: 'smooth'
          },
          xaxis: {
            categories: data.labels,
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          yaxis: {
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          grid: {
            borderColor: '#1e2632',
            strokeDashArray: 4
          },
          tooltip: {
            theme: 'dark'
          }
        };
        
        this.charts.projects = new ApexCharts(container, options);
        this.charts.projects.render();
      });
    },
    
    // График доходов
    initRevenueChart: function() {
      const container = document.getElementById('revenue-chart');
      if (!container) return;
      
      const period = container.dataset.period || 'week';
      
      this.loadData('/rails_admin/statistics/revenue', { period: period }, (data) => {
        const options = {
          series: [{
            name: 'Доход (₽)',
            data: data.values
          }],
          chart: {
            type: 'area',
            height: 300,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          colors: ['#28a745'],
          fill: {
            type: 'gradient',
            gradient: {
              shadeIntensity: 1,
              opacityFrom: 0.7,
              opacityTo: 0.3,
              stops: [0, 90, 100]
            }
          },
          stroke: {
            width: 3,
            curve: 'smooth'
          },
          xaxis: {
            categories: data.labels,
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          yaxis: {
            labels: {
              style: {
                colors: '#62748c'
              },
              formatter: function(val) {
                return val.toLocaleString('ru-RU') + ' ₽';
              }
            }
          },
          grid: {
            borderColor: '#1e2632',
            strokeDashArray: 4
          },
          tooltip: {
            theme: 'dark',
            y: {
              formatter: function(val) {
                return val.toLocaleString('ru-RU') + ' ₽';
              }
            }
          }
        };
        
        this.charts.revenue = new ApexCharts(container, options);
        this.charts.revenue.render();
      });
    },
    
    // График активности по дням
    initActivityChart: function() {
      const container = document.getElementById('activity-chart');
      if (!container) return;
      
      const period = container.dataset.period || 'week';
      
      this.loadData('/rails_admin/statistics/activity', { period: period }, (data) => {
        const options = {
          series: [{
            name: 'Активность',
            data: data.values
          }],
          chart: {
            type: 'bar',
            height: 300,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          colors: ['#ffc107'],
          plotOptions: {
            bar: {
              borderRadius: 4,
              horizontal: false
            }
          },
          xaxis: {
            categories: data.labels,
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          yaxis: {
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          grid: {
            borderColor: '#1e2632',
            strokeDashArray: 4
          },
          tooltip: {
            theme: 'dark'
          }
        };
        
        this.charts.activity = new ApexCharts(container, options);
        this.charts.activity.render();
      });
    },
    
    // Воронка конверсии
    initConversionFunnel: function() {
      const container = document.getElementById('conversion-funnel-chart');
      if (!container) return;
      
      this.loadData('/rails_admin/statistics/conversion', {}, (data) => {
        const options = {
          series: data.values,
          chart: {
            type: 'bar',
            height: 400,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          colors: ['#00e0ff', '#2f6cff', '#28a745', '#ffc107'],
          plotOptions: {
            bar: {
              borderRadius: 0,
              horizontal: true,
              barHeight: '70%',
              isFunnel: true
            }
          },
          dataLabels: {
            enabled: true,
            formatter: function(val, opt) {
              return opt.w.globals.labels[opt.dataPointIndex] + ': ' + val + ' (' + data.percentages[opt.dataPointIndex] + '%)';
            },
            dropShadow: {
              enabled: true
            }
          },
          xaxis: {
            categories: data.labels,
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          yaxis: {
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          grid: {
            borderColor: '#1e2632',
            strokeDashArray: 4
          },
          tooltip: {
            theme: 'dark'
          }
        };
        
        this.charts.conversionFunnel = new ApexCharts(container, options);
        this.charts.conversionFunnel.render();
      });
    },
    
    // График популярности пакетов токенов
    initTokenPackagesChart: function() {
      const container = document.getElementById('token-packages-chart');
      if (!container) return;
      
      this.loadData('/rails_admin/statistics/token_packages', {}, (data) => {
        const options = {
          series: data.values,
          chart: {
            type: 'pie',
            height: 350,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          labels: data.labels,
          colors: ['#00e0ff', '#2f6cff', '#28a745', '#ffc107', '#17a2b8', '#dc3545'],
          legend: {
            position: 'bottom',
            labels: {
              colors: '#a0b3d9'
            }
          },
          tooltip: {
            theme: 'dark',
            y: {
              formatter: function(val) {
                return val + ' покупок';
              }
            }
          }
        };
        
        this.charts.tokenPackages = new ApexCharts(container, options);
        this.charts.tokenPackages.render();
      });
    },
    
    // График использования стилей
    initStylesChart: function() {
      const container = document.getElementById('styles-chart');
      if (!container) return;
      
      this.loadData('/rails_admin/statistics/styles', {}, (data) => {
        const options = {
          series: [{
            name: 'Использований',
            data: data.values
          }],
          chart: {
            type: 'bar',
            height: 300,
            toolbar: { show: false },
            background: 'transparent',
            foreColor: '#a0b3d9'
          },
          colors: ['#00e0ff'],
          plotOptions: {
            bar: {
              borderRadius: 4,
              horizontal: true
            }
          },
          xaxis: {
            categories: data.labels,
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          yaxis: {
            labels: {
              style: {
                colors: '#62748c'
              }
            }
          },
          grid: {
            borderColor: '#1e2632',
            strokeDashArray: 4
          },
          tooltip: {
            theme: 'dark'
          }
        };
        
        this.charts.styles = new ApexCharts(container, options);
        this.charts.styles.render();
      });
    },
    
    // Обновление периода для графиков
    updatePeriod: function(period) {
      // Обновляем все графики с новым периодом
      Object.keys(this.charts).forEach(key => {
        const chart = this.charts[key];
        if (chart && chart.updateOptions) {
          // Перезагружаем данные с новым периодом
          // Это будет реализовано в зависимости от конкретного графика
        }
      });
    }
  };
  
  // Инициализация при загрузке DOM
  document.addEventListener('DOMContentLoaded', function() {
    if (typeof ApexCharts !== 'undefined') {
      window.railsAdminCharts.init();
    }
  });
  
  // Инициализация при Turbo навигации
  if (typeof Turbo !== 'undefined') {
    document.addEventListener('turbo:load', function() {
      if (typeof ApexCharts !== 'undefined') {
        window.railsAdminCharts.init();
      }
    });
  }
})();
