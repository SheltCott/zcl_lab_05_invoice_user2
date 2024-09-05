CLASS zcl_lab_05_invoice_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    DATA: mv_exercise          TYPE n LENGTH 4,
          mv_invoice_no        TYPE n LENGTH 8,
          mv_invoice_code      TYPE string,
          mt_employees         TYPE TABLE OF zemp_logali,
          mv_case1             TYPE string,
          mv_case2             TYPE string,
          mv_data              TYPE string,
          mv_id_customer       TYPE string,
          mv_customer          TYPE string,
          mv_year              TYPE string,
          mv_invoice_num       TYPE string,
          mv_response          TYPE string,
          mv_count             TYPE i,
          mv_translate_invoice TYPE string VALUE 'Report the issuance of this invoice',
          mv_sale              TYPE string,
          mv_sale_status       TYPE string,
          mv_result            TYPE string,
          mv_status            TYPE string,
          mv_request           TYPE string,
          mv_regex             TYPE string,
          mv_email             TYPE string,
          mv_idcustome         TYPE string,
          mv_format            TYPE string.

    METHODS concatenate_variables IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS concatenate_table_lines IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS condense_strings IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS split_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS shift_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS strlen_numofchar IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS translate_case IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS insert_reverse IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS overlay_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS substring_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS find_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS replace_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS regex_validation IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS remove_leading_zeros IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS repeat_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS escape_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_05_invoice_user IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
********************First part**************************************************
*    Concatenation
    me->concatenate_variables( out ).

*    Concatenate table lines
    me->concatenate_table_lines( out ).

*    Condensation
    me->condense_strings( out ).

*    SPLIT
    me->split_string( out ).

*    SHIFT
    me->shift_string( out ).

*    STRLEN and NUMOFCHAR functions
    me->strlen_numofchar( out ).

*    TO_LOWER and TO_UPPER functions
    me->translate_case( out ).

*    INSERT and REVERSE functions
    me->insert_reverse( out ).

********************Second part**************************************************
*    OVERLAY
    me->overlay_string( out ).

*    SUBSTRING function
    me->substring_string( out ).

*    FIND
    me->find_string( out ).

*    REPLACE
    me->replace_string( out ).

*    PCRE Regex
    me->regex_validation( out ).

*    Regular expressions
    me->remove_leading_zeros( out ).

*    String repetition
    me->repeat_string( out ).

*    ESCAPE function
    me->escape_string( out ).
  ENDMETHOD.

  METHOD concatenate_variables.
*     Assign values to variables
    me->mv_exercise = '1234'.
    me->mv_invoice_no = '56789012'.

*     Concatenate variables
    me->mv_invoice_code = |{ me->mv_exercise }/{ me->mv_invoice_no }|.
    ir_out->write( |{ me->mv_invoice_code }| ).
  ENDMETHOD.

  METHOD concatenate_table_lines.
*     Dynamic query to the ZEMP_LOGALI table
    SELECT * FROM zemp_logali
        INTO TABLE me->mt_employees.

*     Concatenate table lines with a space
    DATA(lv_employees_string) = concat_lines_of( table = me->mt_employees sep = ' ' ).
    ir_out->write( |{ lv_employees_string }| ).
  ENDMETHOD.

  METHOD condense_strings.
*     Assign values to variables
    me->mv_case1 = 'Sales invoice with          status in process'.
    me->mv_case2 = '***ABAP*Cloud***'.

*     Remove spaces
    me->mv_case1 = condense( val = me->mv_case1 ).
    ir_out->write( |{ me->mv_case1 }| ).

*     Remove asterisks
    me->mv_case2 = condense( val = me->mv_case2 del = '*' ).
    ir_out->write( |{ me->mv_case2 }| ).
  ENDMETHOD.

  METHOD split_string.
*     Assign value to variable
    me->mv_data = '0001111111;LOGALI GROUP;2024'.

*     Split the string
    SPLIT me->mv_data AT ';' INTO me->mv_id_customer me->mv_customer me->mv_year.
    ir_out->write( |{ me->mv_id_customer }| ).
    ir_out->write( |{ me->mv_customer }| ).
    ir_out->write( |{ me->mv_year }| ).
  ENDMETHOD.

  METHOD shift_string.
*     Assign value to variable
    me->mv_invoice_num = '2015ABCD'.

*     Remove characters at the beginning and end
    me->mv_invoice_num = shift_left( val = me->mv_invoice_num places = 2 ).
    me->mv_invoice_num = shift_right( val = me->mv_invoice_num places = 2 ).
    ir_out->write( |{ me->mv_invoice_num }| ).
  ENDMETHOD.

  METHOD strlen_numofchar.
*     Assign value to variable
    me->mv_response = ' Generating Invoice '.
    ir_out->write( | { me->mv_response }| ).

*     Show length before removing spaces
    me->mv_count = strlen( |{ me->mv_response }| ).
    ir_out->write( |Length before: { me->mv_count }| ).

*     Remove spaces
    me->mv_count = numofchar( |{ me->mv_response }| ).
    ir_out->write( |Length after: { me->mv_count }| ).
  ENDMETHOD.

  METHOD translate_case.
*     Convert to uppercase
    ir_out->write( |Uppercase: { to_upper( me->mv_translate_invoice ) }| ).

*     Convert to lowercase
    ir_out->write( |Lowercase: { to_lower( me->mv_translate_invoice ) }| ).
  ENDMETHOD.

  METHOD insert_reverse.
*     Move the string " to client" to the end
    me->mv_translate_invoice = insert( val = me->mv_translate_invoice sub = ' to client' off = 35  ).

    ir_out->write( |{ me->mv_translate_invoice }| ).

*     Reverse the string
    me->mv_translate_invoice = reverse( me->mv_translate_invoice ).
    ir_out->write( |{ me->mv_translate_invoice }| ).
  ENDMETHOD.

  METHOD overlay_string.
*     Assign values to variables
    me->mv_sale =        'Purchase           Completed'.
    me->mv_sale_status = 'Invoice                        '.

*     Replace "Purchase" with "Invoice"
    OVERLAY me->mv_sale WITH me->mv_sale_status.
    ir_out->write( |{ me->mv_sale }| ).
  ENDMETHOD.

  METHOD substring_string.
*     Assign value to variable
    me->mv_result = 'SAP-ABAP-32-PE'.

*     Get the substring
    me->mv_result = substring( val = me->mv_result off = 9 len = 5 ).
    ir_out->write( |{ me->mv_result }| ).

    me->mv_result = 'SAP-ABAP-32-PE'.

    me->mv_result = substring_before( val = me->mv_result sub = 'ABAP' ).
    ir_out->write( |{ me->mv_result }| ).

    me->mv_result = 'SAP-ABAP-32-PE'.

    me->mv_result = substring_after( val = me->mv_result sub = 'ABAP' ).
    ir_out->write( |{ me->mv_result }| ).
  ENDMETHOD.

  METHOD find_string.
*     Assign value to variable
    me->mv_status = 'INVOICE GENERATED SUCCESSFULLY'.

*     Find "GEN"
    FIND 'GEN' IN me->mv_status MATCH OFFSET me->mv_count.
    me->mv_count = find( val = me->mv_status sub = 'GEN' ).
    ir_out->write( |Position of "GEN": { me->mv_count }| ).

*     Count occurrences of "A"
    me->mv_count = count( val = me->mv_status sub = 'A' ).
    ir_out->write( |Count of "A": { me->mv_count }| ).
  ENDMETHOD.

  METHOD replace_string.
*     Assign value to variable
    me->mv_request = 'SAP-ABAP-32-PE'.

*     Replace "-" with "/"
    REPLACE ALL OCCURRENCES OF '-' IN me->mv_request WITH '/'.
    ir_out->write( |{ me->mv_request }| ).
  ENDMETHOD.

  METHOD regex_validation.
*     Assign values to variables
    me->mv_regex = '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
    me->mv_email = 't100437@logali.com'.

*     Validate email format
    FIND REGEX me->mv_regex IN me->mv_email MATCH OFFSET me->mv_count.
    IF me->mv_count >= 0.
      ir_out->write( |Valid email: { me->mv_email }| ).
    ELSE.
      ir_out->write( |Invalid email: { me->mv_email }| ).
    ENDIF.
  ENDMETHOD.

  METHOD remove_leading_zeros.
*     Assign value to variable
    me->mv_idcustome = '0000012345'.

*     Remove leading zeros
    me->mv_regex = '0*'.
*    REPLACE REGEX me->mv_regex IN me->mv_idcustome WITH ''.
    me->mv_idcustome = replace( val = me->mv_idcustome pcre = me->mv_regex with = '' ).
    ir_out->write( |{ me->mv_idcustome }| ).
  ENDMETHOD.

  METHOD repeat_string.
*     Repeat the value of the variable 3 times
    me->mv_idcustome = repeat( val = me->mv_idcustome occ = 3 ).
    ir_out->write( |{ me->mv_idcustome }| ).
  ENDMETHOD.

  METHOD escape_string.
*     Assign value to variable
    me->mv_format = 'Send payment data via Internet'.

*     Display in different formats
    ir_out->write( escape( val = me->mv_format format = cl_abap_format=>e_url_full ) ).
    ir_out->write( escape( val = me->mv_format format = cl_abap_format=>e_json_string  ) ).
    ir_out->write( escape( val = me->mv_format format = cl_abap_format=>e_string_tpl ) ).
  ENDMETHOD.

ENDCLASS.