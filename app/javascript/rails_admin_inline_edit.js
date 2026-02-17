// Inline editing для RailsAdmin
// Позволяет редактировать поля прямо в таблице списка записей

(function() {
  'use strict';
  
  // Инициализация при загрузке DOM
  document.addEventListener('DOMContentLoaded', function() {
    initInlineEditing();
  });
  
  // Также инициализируем при Turbo навигации (если используется)
  if (typeof Turbo !== 'undefined') {
    document.addEventListener('turbo:load', function() {
      initInlineEditing();
    });
  }
  
  // Также инициализируем при обычной навигации (для случаев без Turbo)
  window.addEventListener('load', function() {
    setTimeout(function() {
      addNewButton();
      enhanceDeleteButtons();
    }, 500);
  });
  
  // Функция для добавления кнопки "Создать" в список (доступна глобально)
  window.addNewButton = function() {
    // Проверяем, не добавлена ли уже кнопка
    if (document.querySelector('a[data-new-button]')) {
      return;
    }
    
    // Получаем текущий URL для определения модели
    const currentPath = window.location.pathname;
    const modelMatch = currentPath.match(/\/admin\/([^\/]+)/);
    if (!modelMatch) return;
    
    const modelName = modelMatch[1];
    
    // Пропускаем AuditLog
    if (modelName.toLowerCase() === 'auditlog' || modelName.toLowerCase() === 'audit_log') {
      return;
    }
    
    // Ищем контейнер с кнопками (обычно рядом с EXPORT или REFRESH)
    const exportButton = document.querySelector('a[href*="/export"]');
    const refreshButton = Array.from(document.querySelectorAll('button')).find(btn => 
      btn.textContent.includes('REFRESH') || btn.textContent.includes('Refresh')
    );
    
    let targetContainer = null;
    if (exportButton && exportButton.parentElement) {
      targetContainer = exportButton.parentElement;
    } else if (refreshButton && refreshButton.parentElement) {
      targetContainer = refreshButton.parentElement;
    } else {
      // Ищем заголовок страницы
      const pageHeader = document.querySelector('.page-header, .content-header, h1');
      if (pageHeader && pageHeader.parentElement) {
        targetContainer = pageHeader.parentElement;
      }
    }
    
    if (targetContainer) {
      // Создаем кнопку "Создать"
      const newButton = document.createElement('a');
      newButton.href = `/admin/${modelName}/new`;
      newButton.className = 'btn btn-success';
      newButton.style.cssText = 'margin-left: 10px; background: #28a745; border-color: #28a745; color: white; padding: 8px 16px; text-decoration: none; display: inline-block; border-radius: 4px; font-weight: 600; cursor: pointer;';
      newButton.setAttribute('data-new-button', 'true');
      newButton.innerHTML = '➕ СОЗДАТЬ';
      
      // Добавляем кнопку
      if (exportButton) {
        exportButton.parentElement.insertBefore(newButton, exportButton.nextSibling);
      } else if (targetContainer) {
        targetContainer.appendChild(newButton);
      }
    }
  }
  
  // Функция для улучшения видимости кнопок Delete (доступна глобально)
  window.enhanceDeleteButtons = function() {
    // Находим все ссылки на удаление
    const deleteLinks = document.querySelectorAll('a[href*="/delete"]');
    deleteLinks.forEach(link => {
      // Улучшаем стиль кнопок удаления
      link.className = 'btn btn-danger btn-sm';
      link.style.cssText = 'background: #dc3545 !important; border-color: #dc3545 !important; color: white !important; padding: 6px 12px !important; margin: 0 4px !important; text-decoration: none !important; border-radius: 4px !important; display: inline-block !important; font-weight: 600 !important; cursor: pointer !important;';
      link.setAttribute('data-enhanced', 'true');
      // Улучшаем текст кнопки
      const currentText = link.textContent.trim();
      if (!currentText.includes('🗑️') && !currentText.includes('Удалить')) {
        link.textContent = '🗑️ Удалить';
      }
    });
  }

  function initInlineEditing() {
    // Добавляем кнопку "Создать" и улучшаем кнопки "Удалить"
    addNewButton();
    enhanceDeleteButtons();
    
    const table = document.querySelector('table.table.table-condensed.table-striped');
    if (!table) return;
    
    // Проверяем, что мы не на странице AuditLog
    const currentUrl = window.location.href;
    if (currentUrl.includes('/audit_log')) return;
    
    // Находим все редактируемые ячейки
    const editableCells = table.querySelectorAll('tbody td[class*="_field"]:not(.id_field):not(.links):not(.sticky)');
    
    editableCells.forEach(cell => {
      // Пропускаем ячейки с ссылками (actions) и системные поля
      if (cell.querySelector('a[href*="/edit"]') || 
          cell.querySelector('a[href*="/delete"]') ||
          cell.classList.contains('id_field') ||
          cell.classList.contains('links') ||
          cell.classList.contains('sticky')) {
        return;
      }
      
      // Пропускаем поля created_at, updated_at (системные)
      if (cell.classList.contains('created_at_field') || 
          cell.classList.contains('updated_at_field')) {
        return;
      }
      
      // Добавляем класс для стилизации
      cell.classList.add('inline-editable');
      
      // Добавляем обработчик двойного клика
      cell.addEventListener('dblclick', function(e) {
        e.stopPropagation();
        startEditing(cell);
      });
      
      // Добавляем визуальный индикатор (курсор при наведении)
      cell.style.cursor = 'pointer';
      cell.title = 'Двойной клик для редактирования';
    });
  }
  
  function startEditing(cell) {
    // Проверяем, не редактируется ли уже
    if (cell.classList.contains('editing')) return;
    
    const originalValue = cell.textContent.trim();
    const fieldClass = Array.from(cell.classList).find(cls => cls.includes('_field'));
    if (!fieldClass) return;
    
    // Извлекаем имя поля из класса (например, "email_field" -> "email")
    const fieldName = fieldClass.replace('_field', '').replace('_type', '');
    
    // Определяем тип поля
    const fieldType = getFieldType(cell);
    
    // Получаем ID записи
    const recordId = getRecordId(cell);
    if (!recordId) return;
    
    // Получаем имя модели из URL
    const modelName = getModelName();
    if (!modelName) return;
    
    // Сохраняем оригинальное содержимое
    const originalHTML = cell.innerHTML;
    cell.classList.add('editing');
    
    // Создаем input элемент в зависимости от типа поля
    const input = createInputElement(fieldType, originalValue, fieldName, cell);
    
    // Заменяем содержимое ячейки на input
    cell.innerHTML = '';
    cell.appendChild(input);
    
    // Устанавливаем значение для input (если это не checkbox)
    if (fieldType !== 'boolean' && input.value !== undefined) {
      input.value = originalValue;
    }
    
    // Фокус на input
    setTimeout(() => {
      input.focus();
      if (input.select && input.tagName.toLowerCase() !== 'select') {
        input.select();
      }
    }, 10);
    
    // Обработчики событий
    let saved = false;
    
    const save = function() {
      if (saved) return;
      saved = true;
      
      const newValue = getInputValue(input, fieldType);
      
      // Если значение не изменилось, просто отменяем редактирование
      if (newValue === originalValue) {
        cancelEditing(cell, originalHTML);
        return;
      }
      
      // Показываем индикатор загрузки
      showLoading(cell);
      
      // Отправляем AJAX запрос
      saveField(modelName, recordId, fieldName, newValue, cell, originalHTML, originalValue);
    };
    
    const cancel = function() {
      if (saved) return;
      cancelEditing(cell, originalHTML);
    };
    
    // Сохранение при потере фокуса
    input.addEventListener('blur', function() {
      // Небольшая задержка, чтобы клик по кнопке успел обработаться
      setTimeout(save, 200);
    });
    
    // Сохранение при нажатии Enter
    input.addEventListener('keydown', function(e) {
      if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        e.stopPropagation();
        save();
      } else if (e.key === 'Escape') {
        e.preventDefault();
        e.stopPropagation();
        cancel();
      }
    });
  }
  
  function getFieldType(cell) {
    const classes = Array.from(cell.classList);
    
    if (classes.some(c => c.includes('enum_type'))) return 'enum';
    if (classes.some(c => c.includes('boolean_type'))) return 'boolean';
    if (classes.some(c => c.includes('integer_type') || c.includes('decimal_type'))) return 'number';
    if (classes.some(c => c.includes('date_type') || c.includes('datetime_type'))) return 'date';
    if (classes.some(c => c.includes('text_type'))) return 'textarea';
    
    return 'text';
  }
  
  function createInputElement(fieldType, value, fieldName, cell) {
    let input;
    
    switch(fieldType) {
      case 'enum':
        input = document.createElement('select');
        input.className = 'form-control inline-edit-input';
        
        // Получаем варианты enum из data-атрибута или из класса
        const enumOptions = getEnumOptions(fieldName, value);
        enumOptions.forEach(option => {
          const opt = document.createElement('option');
          opt.value = option.value;
          opt.textContent = option.label;
          if (option.value === value || option.label === value) {
            opt.selected = true;
          }
          input.appendChild(opt);
        });
        break;
        
      case 'boolean':
        input = document.createElement('input');
        input.type = 'checkbox';
        input.className = 'inline-edit-checkbox';
        input.checked = value === 'true' || value === true || value === '1' || value === 1;
        break;
        
      case 'number':
        input = document.createElement('input');
        input.type = 'number';
        input.className = 'form-control inline-edit-input';
        input.value = value;
        break;
        
      case 'date':
      case 'datetime':
        input = document.createElement('input');
        input.type = fieldType === 'date' ? 'date' : 'datetime-local';
        input.className = 'form-control inline-edit-input';
        // Парсим дату из текста
        const dateValue = parseDate(value);
        if (dateValue) {
          input.value = formatDateForInput(dateValue, fieldType === 'datetime');
        }
        break;
        
      case 'textarea':
        input = document.createElement('textarea');
        input.className = 'form-control inline-edit-input';
        input.value = value;
        input.rows = 3;
        break;
        
      default:
        input = document.createElement('input');
        input.type = 'text';
        input.className = 'form-control inline-edit-input';
        input.value = value;
    }
    
    return input;
  }
  
  function getEnumOptions(fieldName, currentValue) {
    // Конфигурация enum полей для разных моделей
    const enumConfig = {
      'role': [
        { value: 'user', label: 'user' },
        { value: 'admin', label: 'admin' },
        { value: 'super_admin', label: 'super_admin' }
      ],
      'status': [
        { value: 'active', label: 'active' },
        { value: 'archived', label: 'archived' },
        { value: 'pending', label: 'pending' },
        { value: 'completed', label: 'completed' },
        { value: 'failed', label: 'failed' }
      ],
      'kind': [
        { value: 'input', label: 'input' },
        { value: 'output', label: 'output' },
        { value: 'reference', label: 'reference' }
      ],
      'operation': [
        { value: 'spend', label: 'spend' },
        { value: 'refund', label: 'refund' },
        { value: 'bonus', label: 'bonus' }
      ]
    };
    
    // Ищем конфигурацию для поля
    if (enumConfig[fieldName]) {
      return enumConfig[fieldName];
    }
    
    // Если конфигурации нет, возвращаем текущее значение
    return [
      { value: currentValue, label: currentValue }
    ];
  }
  
  function getInputValue(input, fieldType) {
    switch(fieldType) {
      case 'boolean':
        return input.checked;
      case 'number':
        return input.value ? parseFloat(input.value) : null;
      case 'date':
      case 'datetime':
        return input.value || null;
      default:
        return input.value.trim();
    }
  }
  
  function getRecordId(cell) {
    // Ищем ID в строке таблицы
    const row = cell.closest('tr');
    if (!row) return null;
    
    // Пытаемся найти ID в первой ячейке с классом id_field
    const idCell = row.querySelector('.id_field');
    if (idCell) {
      return idCell.textContent.trim();
    }
    
    // Или ищем в ссылке на редактирование
    const editLink = row.querySelector('a[href*="/edit"]');
    if (editLink) {
      const match = editLink.href.match(/\/(\d+)\/edit/);
      if (match) return match[1];
    }
    
    // Или в ссылке на просмотр
    const showLink = row.querySelector('a[href*="/admin/"][href*="/"][href*=""]');
    if (showLink) {
      const match = showLink.href.match(/\/admin\/[^\/]+\/(\d+)/);
      if (match) return match[1];
    }
    
    return null;
  }
  
  function getModelName() {
    const url = window.location.href;
    const match = url.match(/\/admin\/([^\/\?]+)/);
    return match ? match[1] : null;
  }
  
  function saveField(modelName, recordId, fieldName, fieldValue, cell, originalHTML, originalValue) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
    if (!csrfToken) {
      showError(cell, 'CSRF token not found');
      return;
    }
    
    const url = `/rails_admin/inline_edit/${modelName}/${recordId}`;
    
    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        field_name: fieldName,
        field_value: fieldValue
      })
    })
    .then(response => {
      if (!response.ok) {
        return response.json().then(data => {
          throw new Error(data.error || data.errors?.join(', ') || 'Server error');
        });
      }
      return response.json();
    })
    .then(data => {
      if (data.success) {
        showSuccess(cell, data.field_value || fieldValue);
      } else {
        showError(cell, data.error || data.errors?.join(', ') || 'Unknown error');
      }
    })
    .catch(error => {
      console.error('Inline edit error:', error);
      showError(cell, error.message || 'Network error');
    });
  }
  
  function showLoading(cell) {
    cell.innerHTML = '<span class="inline-edit-loading">💾 Сохранение...</span>';
    cell.classList.add('saving');
  }
  
  function showSuccess(cell, newValue) {
    cell.classList.remove('editing', 'saving');
    cell.classList.add('saved');
    cell.innerHTML = escapeHtml(newValue);
    cell.style.cursor = 'pointer';
    
    // Убираем класс saved через 2 секунды
    setTimeout(() => {
      cell.classList.remove('saved');
    }, 2000);
  }
  
  function showError(cell, errorMessage) {
    cell.classList.remove('editing', 'saving');
    cell.classList.add('error');
    cell.innerHTML = `<span class="inline-edit-error" title="${escapeHtml(errorMessage)}">❌ Ошибка</span>`;
    
    // Показываем ошибку 3 секунды, затем возвращаем оригинальное значение
    setTimeout(() => {
      const row = cell.closest('tr');
      if (row) {
        // Находим оригинальное значение из других ячеек или восстанавливаем
        cell.classList.remove('error');
        cell.innerHTML = cell.textContent || '—';
        cell.style.cursor = 'pointer';
      }
    }, 3000);
  }
  
  function cancelEditing(cell, originalHTML) {
    cell.classList.remove('editing');
    cell.innerHTML = originalHTML;
    cell.style.cursor = 'pointer';
  }
  
  function parseDate(dateString) {
    if (!dateString || dateString === '-' || dateString.trim() === '') return null;
    
    // Пытаемся распарсить различные форматы дат
    const date = new Date(dateString);
    if (!isNaN(date.getTime())) {
      return date;
    }
    
    return null;
  }
  
  function formatDateForInput(date, includeTime) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    
    if (includeTime) {
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      return `${year}-${month}-${day}T${hours}:${minutes}`;
    }
    
    return `${year}-${month}-${day}`;
  }
  
  function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
  }
})();
