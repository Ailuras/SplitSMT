(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2499 0)
(declare-sort var1282 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var1282-init () var1282)
(declare-fun <init>/875830710 (var1282 String) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var1791 (Array Int Int)) ; Statement: r1 := @parameter0: byte[] 
(assert (not (= var1791 null-__Array__Int__Int__)))
(declare-const var2176 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var2176 null-Int)))
(declare-const var3598 Int) ; Statement: i2 := @parameter2: int 
(assert (not (= var3598 null-Int)))
(declare-const var2121 String) ; Statement: r0 := @parameter3: java.lang.String 
(assert (not (= var2121 null-String)))
(assert true)
(define-const var3261 Int (length/-134980193 var2121)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 >= 64 goto $r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>() 
(assert (not (>= var3261 64))) ; Negate: Cond: $i0 >= 64  
(define-const var3418 var1282 var1282-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var3418 "Base64 code length < 64.")) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Base64 code length < 64.") 

(declare-const var3418!1 var1282)
(declare-const var574 String)
 ; Statement: throw $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), var1282-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1791=r1, var2176=i1, var3598=i2, var2121=r0, var2499=null_type, var3261=$i0, var1282=java.lang.IllegalArgumentException, var3418=$r4, var574="Base64 code length < 64."}
; {r1=var1791, i1=var2176, i2=var3598, r0=var2121, null_type=var2499, $i0=var3261, java.lang.IllegalArgumentException=var1282, $r4=var3418, "Base64 code length < 64."=var574}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r1 := @parameter0: byte[];	i1 := @parameter1: int;	i2 := @parameter2: int;	r0 := @parameter3: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 >= 64 goto $r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>();	$r4 = new java.lang.IllegalArgumentException;	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Base64 code length < 64.");	throw $r4
;block_num 2