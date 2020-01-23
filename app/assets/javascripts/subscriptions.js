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
});

document.addEventListener("turbolinks:load", function() {

  var bookImage = document.querySelector('.book-image');

  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = ['<img class="course-preview-thumb" src="', e.target.result,
            '" title="', escape(theFile.name), '"/>'
          ].join('');
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);
      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  if (bookImage) {
    this.addEventListener('change', handleFileSelect, false);
  }

});

$.notify.defaults(
  { globalPosition:"top right" }
);

document.addEventListener("turbolinks:load", function() {
  var stripe = Stripe('pk_test_WinUnLY18E0n0McRfBTLcnEn');

  function setOutcome(result) {
    var errorElement = document.querySelector('.error');

    if (result.token) {
      var form = document.getElementById('account-form');
      form.querySelector('input[name="token"]').setAttribute('value', result.token.id);
      form.submit();
    } else {
      errorElement.textContent = result.error.message;
      errorElement.addClass('visible');
    }
  }

  form = document.getElementById('account-form');

  form.addEventListener('submit', function(e) {
    e.preventDefault();

  var bankAccountParams = {
    country: document.getElementById('country').value,
    currency: document.getElementById('currency').value,
    account_number: document.getElementById('account-number').value,
    account_holder_name: document.getElementById('account-holder-name').value,
    account_holder_type: document.getElementById('account-holder-type').value,
  }
  if (document.getElementById('routing-number').value != '') {
    bankAccountParams['routing_number'] = document.getElementById('routing-number').value;
  }

  stripe.createToken('bank_account', bankAccountParams).then(setOutcome);

  });
});
