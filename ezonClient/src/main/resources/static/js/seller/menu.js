document.addEventListener("DOMContentLoaded", function () {

  const lnbItems = document.querySelectorAll('.lnb_custom > li > button');

  lnbItems.forEach((button) => {
    button.addEventListener('click', () => {
      const li = button.parentElement;
      const isOpen = li.classList.contains('on');

      document.querySelectorAll('.lnb_custom > li').forEach((item) =>
        item.classList.remove('on')
      );

      if (!isOpen) li.classList.add('on');
    });
  });
  
});