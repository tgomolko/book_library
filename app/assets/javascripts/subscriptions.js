document.addEventListener("turbolinks:load", function() {
  const publishableKey = "pk_test_WinUnLY18E0n0McRfBTLcnEn";
  const stripe = Stripe(publishableKey);

  const elements = stripe.elements({
    fonts: [{
      cssSrc: "https://rsms.me/inter/inter-ui.css"
    }],
    locale: "auto"
  });

  const style = {
    base: {
      color: "#32325d",
      fontWeight: 500,
      fontFamily: "Inter UI, Open Sans, Segoe UI, sans-serif",
      fontSize: "16px",
      fontSmoothing: "antialiased",

      "::placeholder": {
        color: "#CFD7DF"
      }
    },
    invalid: {
      color: "#E25950"
    }
  };

  const card = elements.create('card', { style });
  card.mount("#card-element");

  card.addEventListener('change', ( {error} ) => {
    const displayError = document.getElementById('card-errors');
    if(error) {
      displayError.textContent = error.message;
    } else {
      displayError.textContent = "";
    }
  });

  const form = document.getElementById('payment-form');

  form.addEventListener('submit', async(event) => {
    event.preventDefault();

    const { token, error } = await stripe.createToken(card);

    if (error) {
      const errorElement = document.getElementById('card-errors');
      errorElement.textContent = error.message;
    } else {
      stripeTokenHandler(token);
    }
  });

  const stripeTokenHandler = (token) => {
    const form = document.getElementById('payment-form');
    const hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);

    ["last4", "exp_month", "exp_year", "brand"].forEach(function(field) {
      addCardField(form, token, field);
    });

    form.submit();
  }

  function addCardField(form, token, field) {
    let hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', "card[" + field + "]");
    hiddenInput.setAttribute('value', token.card[field]);
    form.appendChild(hiddenInput);
  }

  var modal = document.querySelector('.modal');  // assuming you have only 1
  var html = document.querySelector('html');

  modal.querySelector('.modal-background').addEventListener('click', function(e) {
    e.preventDefault();
    modal.classList.remove('is-active');
    html.classList.remove('is-clipped');
  });

  modal.querySelector('.modal-close').addEventListener('click', function(e) {
    e.preventDefault();
    modal.classList.remove('is-active');
    html.classList.remove('is-clipped');
  });

});

$(document).ready (function () {
   $(document).on("click", ".dropdown", function(){

    $(this).toggleClass("is-active");
  });
});

