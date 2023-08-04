<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later

// s-expression parser


abstract class LispValue {
   const tList = 1;
   const tSymbol = 2;
   const tOperator = 4;
   const tString = 8;
   const tSymbolOrString = 2 | 8;
   const tInt = 16;
   const tFloat = 32;
   const tNum = 16 | 32;
   protected $value;
   protected $sexp;
   protected $lineno;
   function get() {
      return $this->value;
   }
   function is_list() {
      return FALSE;
   }
   function is_symbol() {
      return FALSE;
   }
   function is_operator() {
      return FALSE;
   }
   function may_be_head() {
      return FALSE;
   }
   function is_string() {
      return FALSE;
   }
   function is_symbol_or_string() {
      return FALSE;
   }
   function is_number() {
      return FALSE;
   }
   function is_int() {
      return FALSE;
   }
   function is_float() {
      return FALSE;
   }
   function trim() {
      return $this;
   }
   function fatal($msg) {
      if (isset($this->sexp)) {
         $this->sexp->fatalAtLine($msg, $this->lineno);
      }
      throw new Exception($msg);
   }
}

class LispList extends LispValue {
   protected $head;
   function __construct($head, $body, $sexp = NULL, $lineno = 0) {
      $this->head = $head;
      $this->value = $body;
      $this->sexp = $sexp;
      $this->lineno = $lineno;
   }
   function typeMask() {
      return self::tList;
   }
   function is_list() {
      return TRUE;
   }
   function get_head() {
      return $this->head;
   }
   function trim() {
      $this->value = NULL;
      return $this;
   }
}

class LispSymbol extends LispValue {
   function __construct($kw, $sexp = NULL, $lineno = 0) {
      $this->value = $kw;
      $this->sexp = $sexp;
      $this->lineno = $lineno;
   }
   function typeMask() {
      return self::tSymbol;
   }
   function is_symbol() {
      return TRUE;
   }
   function is_symbol_or_string() {
      return TRUE;
   }
   function may_be_head() {
      return TRUE;
   }
}

class LispOperator extends LispValue {
   function __construct($op, $sexp = NULL, $lineno = 0) {
      $this->value = $op;
      $this->sexp = $sexp;
      $this->lineno = $lineno;
   }
   function typeMask() {
      return self::tOperator;
   }
   function is_operator() {
      return TRUE;
   }
   function may_be_head() {
      return TRUE;
   }
}

class LispString extends LispValue {
   function __construct($value, $sexp = NULL, $lineno = 0) {
      $this->value = $value;
      $this->sexp = $sexp;
      $this->lineno = $lineno;
   }
   function typeMask() {
      return self::tString;
   }
   function is_string() {
      return TRUE;
   }
   function is_symbol_or_string() {
      return TRUE;
   }
}

abstract class LispNumber extends LispValue {
   function __construct($value, $sexp = NULL, $lineno = 0) {
      $this->value = $value;
      $this->sexp = $sexp;
      $this->lineno = $lineno;
   }
   function is_number() {
      return TRUE;
   }
}

class LispInteger extends LispNumber {
   function is_int() {
      return TRUE;
   }
   function typeMask() {
      return self::tInt;
   }
}

class LispFloat extends LispNumber {
   function is_float() {
      return TRUE;
   }
   function typeMask() {
      return self::tFloat;
   }
}


class Sexp {
   private $filename;
   private $input;
   private $lineno = 0;
   private $workline = "";

   function parse($blob, $filename = NULL) {
      $this->filename = $filename;
      $this->input = $blob;
      $rootItems = array();
      while (!is_null($item = $this->parseNext())) {
         $rootItems[] = $item;
      }
      return $this->newLispList('0', $rootItems, 1);
   }

   private function parseNext() {
      again:
      $workline = ltrim($this->workline);
      if (!strlen($workline)) {
         $this->lineno++;
         if (strlen($this->input)) {
            $pos = strpos($this->input, "\n");
            if ($pos === FALSE) {
               $workline = $this->input;
               $this->input = "";
            }
            else {
               $workline = substr($this->input, 0, $pos);
               $this->input = substr($this->input, $pos + 1);
            }
            $this->workline = $workline;
            goto again;
         }
         return NULL;
      }
      $c1 = substr($workline, 0, 1);
      switch ($c1) {
         case '(':
            $this->workline = substr($workline, 1);
            return $this->parseList();
         case ')':
            $this->workline = substr($workline, 1);
            return $c1;
         case '"':
         case "'":
            if (!preg_match('/^(.)((?:\\.|.)*)\1/', $workline, $matches)) {
               $this->fatal("Cannot parse literal string");
            }
            $this->workline = substr($workline, strlen($matches[0]));
            return $this->newLispString(stripcslashes($matches[2]));
         case ';':
            $this->workline = '';
            goto again;
         case '#':
            if (!preg_match('/^#([[:xdigit:]]+)/', $workline, $matches)) {
               $this->fatal("Expected at least one digit in hex literal");
            }
            $this->workline = substr($workline, strlen($matches[0]));
            return $this->newLispInteger(pack('H*', $matches[1]));
         case '|':
            if (!preg_match('/^\|([[:alnum:]+/]+=*)/', $workline, $matches)) {
               $this->fatal("Expected at least one character in base-64 literal");
            }
            $this->workline = substr($workline, strlen($matches[0]));
            $str = base64_decode($matches[1]);
            if ($str === FALSE) {
               $this->fatal("Illegal base64 literal {$matches[1]}");
            }
            return $this->newLispString($str);
         default:
            preg_match('/^..*?(?=$|[\s()"\'|#;])/', $workline, $matches);
            $matchlen = strlen($matches[0]);
            $str = substr($workline, 0, $matchlen);
            $this->workline = substr($workline, $matchlen);
            if (ctype_digit($c1) || $c1 == '-' || $c1 == '+' || $c1 == '.') {
               if (!preg_match('/^([-+]?(?:(\d+)|\d+\.\d*|\.\d+))$/', $str, $matches)) {
                  $this->fatal("$str is not a valid number");
               }
               if (isset($matches[2]) && strlen($matches[2])) {
                  return $this->newLispInteger($matches[1]);
               }
               return $this->newLispFloat($matches[1]);
            }
            if (preg_match('/^[[:alpha:]_]\w*(?:\.\w*)*$/', $str, $matches)) {
               return $this->newLispSymbol($str);
            }
            return $this->newLispOperator($str);
      }
   }

   private function parseList() {
      $items = array();
      $startline = $this->lineno;
      for (;;) {
         $item = $this->parseNext();
         if (!$item) {
            $this->lineno = $startline;
            $this->fatal("Unterminated list");
         }
         if ($item == ')') {
            break;
         }
         $items[] = $item;
      }
      if ($items && $items[0]->may_be_head()) {
         $head = array_shift($items);
         $head = $head->get();
      }
      else {
         $head = NULL;
      }
      return $this->newLispList($head, $items, $startline);
   }


   private function newLispList($head, $items, $lineno) {
      return new LispList($head, $items, $this, $lineno);
   }

   private function newLispSymbol($kw) {
      return new LispSymbol($kw, $this, $this->lineno);
   }

   private function newLispOperator($op) {
      return new LispOperator($op, $this, $this->lineno);
   }

   private function newLispString($value) {
      return new LispString($value, $this, $this->lineno);
   }

   private function newLispInteger($val) {
      return new LispInteger($val, $this, $this->lineno);
   }

   private function newLispFloat($val) {
      return new LispFloat($val, $this, $this->lineno);
   }

   private function fatal($msg) {
      $filename = isset($this->filename) ? "in {$this->filename}" : 'at';
      throw new Exception("$msg $filename line {$this->lineno}");
   }

   function fatalAtLine($msg, $lineno) {
      $this->lineno = $lineno;
      $this->fatal($msg);
   }
}

