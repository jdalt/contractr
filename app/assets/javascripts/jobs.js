// TODO: !! cost estimation is not correct if items are deleted!! fix and add js tests
var contractr = {};
$(document).ready(function(){
  window.NestedFormEvents.prototype.insertFields = function(content, assoc, link) {
    var $tr = $(link).closest('tr');
    return $(content).insertBefore($tr);
  }

  $(document).on('nested:fieldAdded:work_items', function(event){
    // this field was just inserted into your form
    var $field = event.field; 
    var num_columns = $('.work-items').length;
    $field.attr('data-column', num_columns)
    console.log($field);
    // it's a jQuery object already! Now you can find date input
    var $select = $field.find('select');
    contractr.updateCategoryDetailOnChange($select);

    var $amount_input = $field.find('.work-item-amount input');
    contractr.updateCostOnKeyUp($amount_input);
  })
});

$(document).ready(function(){

  contractr.updateCategoryDetailOnChange = function($bindSelection){
    $bindSelection.change(function(){
      var $me = $(this);
      var category_id = $me.find(':selected').val();
      var $col = contractr.getParentColumn$($me);
      if(category_id == ""){
        $col.find('.category-detail').empty();
        $col.find('.work-item-amount label').empty();
        contractr.clear_cost($me);
      } else {
        // json object (contractr.work_categories) is indexed from 0 rather than 1
        var category = contractr.work_categories[category_id-1];
        var detail = category.price_per_unit + " per " + category.unit;
        $col.find('.category-detail').html(detail);
        $col.find('.work-item-amount label').html(category.unit);

        contractr.clear_cost($me);
      }
    });
  }

  contractr.updateCostOnKeyUp = function($bindSelection){
    // entering input into "amount" column will update "cost" and "total_cost"
    $bindSelection.keyup(function(){
      var $me = $(this);
      var amount = $me.val();
      var selected_id = $me.closest('.work-items').find(':selected').attr('value');

      // Exit if no category is selected
      if(selected_id == 0){
        return;
      }
      var price_per_unit = contractr.work_categories[selected_id-1].price_per_unit;
      var $col = contractr.getParentColumn$($me);

      // This is a hack to prevent the decimal from repeating
      // more than two places. Prefer a more robust show decimal
      // place solution.
      var cost_two_dec = Math.round((amount * price_per_unit)*100)/100
      $col.find('.work-item-cost').html(cost_two_dec);

      // update the total by summing the work-items which have valid values
      var total = 0;
      $('.work-items .work-item-cost').each(function(){
        var cost_value = parseFloat($(this).html());
        if(!isNaN(cost_value)){
          total += cost_value;
        }
      });
      $('#job-total-cost').html(total);
    });
  }

  // Helper functions on the "contractr" namspace
  contractr.getParentColumn$ = function($child_of_column)
  {
    var column_id = $child_of_column.closest('.work-items').attr('data-column');
    return $('tr.work-items[data-column="'+column_id+'"]');
  }

  contractr.clear_cost = function($category_option)
  {
    // empty the current amount since its units probably won't match
    var $column_root = $category_option.closest('.work-items');
    $column_root.find('.work-item-amount input').val("");
    $column_root.find('.work-item-cost').html("");
    $('#job-total-cost').html("???");
  }

  contractr.updateCategoryDetailOnChange($('.work-items select'));
  contractr.updateCostOnKeyUp($('.work-item-amount input'));
});

  
 
